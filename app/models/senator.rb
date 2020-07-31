class Senator < ApplicationRecord
  has_many :senator_favorites, dependent: :destroy
  has_many :users, through: :senator_favorites
  def self.by_state(state_abbrev, order = 'asc', limit = 400)
    self.where(state: "#{state_abbrev}")
        .order(last_name: "#{order}")
        .limit(limit)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.includes?(congress_id)
    self.exists?(congress_id: "#{congress_id}")
  end

  def self.senator_favorite_for_user(id)
    Senator.joins(senator_favorites:[:user]).where('senator_favorites.comparison_score IS NOT NULL AND senator_favorites.user_id = ?', id)
  end

  def compare_votes_with_user(user_votes)
    yes_hash = {}
    no_hash = {}
    user_votes.each do |bill_id, vote|
      bill = Bill.find_by(bill_id: bill_id)
      roll_call = bill.senate_bill_vote.roll_call
      session = bill.senate_bill_vote.session
      if vote == 'yes'
        yes_hash["#{bill_id}"] = SinatraService.new.get_member_votes(congress_id, roll_call, "senate", session)["data"]["#{roll_call}"]
      elsif vote == 'no'
        no_hash["#{bill_id}"] = SinatraService.new.get_member_votes(congress_id, roll_call, "senate", session)["data"]["#{roll_call}"]
      end
    end
    matching_bills = []
    not_matching_bills = []
    yes_hash.each do |bill_id, senator_vote|
      bill_title = Bill.find_by(bill_id: bill_id).short_title
      if senator_vote == 'Yes'
        matching_bills << bill_title
      elsif senator_vote == 'No'
        not_matching_bills << bill_title
      end
    end
    no_hash.each do |bill_id, senator_vote|
      bill_title = Bill.find_by(bill_id: bill_id).short_title
      if senator_vote == 'No'
        matching_bills << bill_title
      elsif senator_vote == 'Yes'
        not_matching_bills << bill_title
      end
    end
    number_compared = matching_bills.length + not_matching_bills.length.to_f
    comparison_score = (matching_bills.length / number_compared) * 100
    {comparison_score: comparison_score, matching_bills: matching_bills, not_matching_bills: not_matching_bills}
  end
end

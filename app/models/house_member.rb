class HouseMember < ApplicationRecord
  has_many :house_favorites, dependent: :destroy
  has_many :users, through: :house_member_favorites
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

  def self.house_favorites_for_user(id)
    HouseMember.joins(house_favorites:[:user]).where('house_favorites.comparison_score IS NOT NULL AND house_favorites.user_id = ?', id)
  end

  def compare_votes_with_user(user_votes)
    yes_hash = {}
    no_hash = {}
    user_votes.each do |bill_id, vote|
      bill = Bill.find_by(bill_id: bill_id)
      roll_call = bill.house_bill_vote.roll_call
      session = bill.house_bill_vote.session
      if vote == 'yes'
        yes_hash["#{bill_id}"] = SinatraService.new.get_member_votes(congress_id, roll_call, "house", session)["data"]["#{roll_call}"]
      elsif vote == 'no'
        no_hash["#{bill_id}"] = SinatraService.new.get_member_votes(congress_id, roll_call, "house", session)["data"]["#{roll_call}"]
      end
    end
    matching_bills = []
    not_matching_bills = []
    yes_hash.each do |bill_id, house_member_vote|
      bill_id = Bill.find_by(bill_id: bill_id).id
      if house_member_vote == 'Yes'
        matching_bills << bill_id
      elsif house_member_vote == 'No'
        not_matching_bills << bill_id
      end
    end
    no_hash.each do |bill_id, house_member_vote|
      bill_id = Bill.find_by(bill_id: bill_id).id
      if house_member_vote == 'No'
        matching_bills << bill_id
      elsif house_member_vote == 'Yes'
        not_matching_bills << bill_id
      end
    end
    number_compared = matching_bills.length + not_matching_bills.length.to_f
    comparison_score = (matching_bills.length / number_compared) * 100
    {comparison_score: comparison_score, matching_bills: matching_bills, not_matching_bills: not_matching_bills}
  end
end

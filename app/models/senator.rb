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

  def compare_with_user(user_votes)
    @results = {}
    @sorted_bills = {}
    user_votes.each do |bill_id, vote|
      bill = Bill.find_by(bill_id: bill_id)
      roll_call = bill.senate_bill_vote.roll_call
      session = bill.senate_bill_vote.session
      if @results[vote].nil?
        @results[vote] = [{bill_id => SinatraService.new.get_member_votes(congress_id, roll_call, "senate", session)["data"]["#{roll_call}"]}]
      else
        @results[vote] << {bill_id => SinatraService.new.get_member_votes(congress_id, roll_call, "senate", session)["data"]["#{roll_call}"]}
      end
    end
    @results.each do |user_vote, senator_vote_info|
      senator_vote_info.each do |bill_id|
        bill_title = Bill.find_by(bill_id: bill_id.keys.first).short_title
        if user_vote == bill_id.values.first.downcase && @sorted_bills[:matching].nil?
          @sorted_bills[:matching] = [bill_title]
        elsif user_vote == bill_id.values.first.downcase
          @sorted_bills[:matching] << bill_title
        elsif @sorted_bills[:not_matching].nil?
          @sorted_bills[:not_matching] = [bill_title]
        else
          @sorted_bills[:not_matching] << bill_title
        end
      end
    end
    number_compared = @sorted_bills[:matching].length + @sorted_bills[:not_matching].length.to_f
    comparison_score = (@sorted_bills[:matching].length / number_compared) * 100
    { comparison_score: comparison_score, matching_bills: @sorted_bills[:matching], not_matching_bills: @sorted_bills[:not_matching] }
  end
end

class HouseFavorite < ApplicationRecord
  belongs_to :house_member
  belongs_to :user

  def update_aggregate_comparison(results)
    if self.aggregate_comparison
      current_compared = results[:matching_bills].size + results[:not_matching_bills].size
      weighted_current_score = (results[:comparison_score] / 100) * current_compared
      weighted_aggregate_score = (aggregate_comparison / 100) * bills_compared
      weighted_total = weighted_current_score + weighted_aggregate_score
      total_compared = current_compared + bills_compared
      self.aggregate_comparison = (weighted_total / total_compared) * 100
    else
      self.aggregate_comparison = results[:comparison_score]
    end
  end

  def update_bills_compared(results)
    current_compared = results[:matching_bills].size + results[:not_matching_bills].size
    if self.bills_compared
      self.bills_compared += current_compared
    else
      self.bills_compared = current_compared
    end
  end
end

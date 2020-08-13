class AddAggregateComparisonToSenatorFavorites < ActiveRecord::Migration[5.1]
  def change
    add_column :senator_favorites, :aggregate_comparison, :float
  end
end

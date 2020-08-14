class AddAggregateComparisonToHouseFavorites < ActiveRecord::Migration[5.1]
  def change
    add_column :house_favorites, :aggregate_comparison, :float
  end
end

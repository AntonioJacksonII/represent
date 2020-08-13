class AddBillsComparedToHouseFavorites < ActiveRecord::Migration[5.1]
  def change
    add_column :house_favorites, :bills_compared, :integer
  end
end

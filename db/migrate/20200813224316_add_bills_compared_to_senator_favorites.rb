class AddBillsComparedToSenatorFavorites < ActiveRecord::Migration[5.1]
  def change
    add_column :senator_favorites, :bills_compared, :integer
  end
end

class CreateHouseFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :house_favorites do |t|
      t.references :user, foreign_key: true
      t.references :house_member, foreign_key: true
      t.float :comparison_score
      t.timestamps
    end
  end
end

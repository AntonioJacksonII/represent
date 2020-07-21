class CreateSenatorFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :senator_favorites do |t|
      t.references :user, foreign_key: true
      t.references :senator, foreign_key: true
      t.float :comparison_score
      t.timestamps
    end
  end
end

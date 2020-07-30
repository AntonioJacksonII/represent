class CreateHouseBillVote < ActiveRecord::Migration[5.1]
  def change
    create_table :house_bill_votes do |t|
      t.references :bill, foreign_key: true
      t.integer :offset
      t.integer :roll_call
      t.timestamps
    end
  end
end

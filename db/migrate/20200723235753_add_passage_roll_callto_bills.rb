class AddPassageRollCalltoBills < ActiveRecord::Migration[5.1]
  def change
    add_column :bills, :passage_roll_call, :integer
  end
end

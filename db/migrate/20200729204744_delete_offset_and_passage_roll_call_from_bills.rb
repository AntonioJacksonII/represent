class DeleteOffsetAndPassageRollCallFromBills < ActiveRecord::Migration[5.1]
  def change
    remove_column :bills, :offset
    remove_column :bills, :passage_roll_call
  end
end

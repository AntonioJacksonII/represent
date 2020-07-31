class ChangeOffsetsToSessions < ActiveRecord::Migration[5.1]
  def change
    remove_column :house_bill_votes, :offset
    remove_column :senate_bill_votes, :offset
    add_column :house_bill_votes, :session, :integer
    add_column :senate_bill_votes, :session, :integer
  end
end

class ChangeVotesWithoutPartyPercentage < ActiveRecord::Migration[5.1]
  def change
    remove_column :house_members, :votes_without_party_percentage, :string
    remove_column :senators, :votes_without_party_percentage, :string
    add_column :house_members, :votes_without_party_percentage, :float
    add_column :senators, :votes_without_party_percentage, :float
  end
end

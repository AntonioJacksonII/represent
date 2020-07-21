class CreateSenators < ActiveRecord::Migration[5.1]
  def change
    create_table :senators do |t|
      t.string :first_name
      t.string :last_name
      t.string :dob
      t.string :gender
      t.string :party
      t.string :leadership_role
      t.string :facebook_account
      t.string :twitter_account
      t.integer :govtrack_id
      t.string :url
      t.string :contact_form
      t.float :dw_nominate
      t.integer :next_election
      t.integer :total_votes
      t.integer :missed_votes
      t.datetime :last_updated
      t.string :office
      t.string :phone
      t.string :state
      t.float :missed_votes_percentage
      t.float :votes_with_percentage
      t.string :votes_without_party_percentage
      t.string :congress_id
      t.integer :senate_class
      t.string :state_rank
      t.timestamps
    end
  end
end

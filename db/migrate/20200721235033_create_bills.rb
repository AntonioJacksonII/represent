class CreateBills < ActiveRecord::Migration[5.1]
  def change
    create_table :bills do |t|
      t.string :bill_id
      t.text :summary_short
      t.string :congress_url
      t.text :short_title
      t.string :primary_subject
      t.integer :offset
      t.timestamps
    end
  end
end

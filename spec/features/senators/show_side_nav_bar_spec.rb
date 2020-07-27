require 'rails_helper'

describe "Senator Show Pages" do
  it "has a side nav bar with other reps/senators in the same state", :vcr do
    parser = PropublicaParser.new
    parser2 = PropublicaParser.new
    parser.parse_house_members
    parser2.parse_senators
    senator = Senator.find_by(first_name: "Kirsten", last_name: "Gillibrand")
    anthony = HouseMember.find_by(first_name: "Anthony", last_name: "Brindisi")
    visit "/senators/#{senator.id}"
    has_link? ("Anthony Brindisi")
    has_link? ("Charles Schumer")
    click_on "Anthony Brindisi"
    expect(current_path).to eq("/house_members/#{anthony.id}")
  end
end

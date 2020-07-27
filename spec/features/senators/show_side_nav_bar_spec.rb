require 'rails_helper'

describe "Senator Show Pages" do
  it "has a side nav bar with other reps/senators in the same state" do
    json_response = File.read('spec/fixtures/house_representatives.json')
    parser = PropublicaParser.new(json_response)
    senate_json_response = File.read('spec/fixtures/senate.json')
    parser2 = PropublicaParser.new(senate_json_response)
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

require 'rails_helper'

RSpec.describe "On the bill select page" do
  it "has a field to enter the bill number", :vcr do
    @rep = create(:house_member)
    visit "/house_members/#{@rep.id}"
    click_on "Compare Positions"
    has_field? "Search"
  end

  it "has a dropdown with only topics voted on in the rep's chamber", :vcr do
    create(:bill, primary_subject: "Armed Forces and National Security", house_bill_vote: create(:house_bill_vote))
    create(:bill, primary_subject: "Finance", house_bill_vote: create(:house_bill_vote))
    create(:bill, primary_subject: "Public Lands and Natural Resources", senate_bill_vote: create(:senate_bill_vote))
    create(:bill, primary_subject: "Families", senate_bill_vote: create(:senate_bill_vote))
    @rep = create(:house_member)
    @senator = create(:senator)
    visit "/house_members/#{@rep.id}"
    click_on "Compare Positions"

    expect(page).to have_content("Armed Forces and National Security")
    expect(page).to have_content("Finance")
    expect(page).to_not have_content("Public Lands and Natural Resources")
    expect(page).to_not have_content("Families")

    visit "/senators/#{@senator.id}"
    click_on "Compare Positions"

    expect(page).to_not have_content("Armed Forces and National Security")
    expect(page).to_not have_content("Finance")
    expect(page).to have_content("Public Lands and Natural Resources")
    expect(page).to have_content("Families")
  end

  it "has field to enter number of bills to compare", :vcr do
    @rep = create(:house_member)
    visit "/house_members/#{@rep.id}"
    click_on "Compare Positions"

    has_field? "Search"
  end
end

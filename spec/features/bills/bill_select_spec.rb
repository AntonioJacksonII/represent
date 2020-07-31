require 'rails_helper'

RSpec.describe "On the bill select page" do
  it "has a field to enter the bill number", :vcr do
    @rep = create(:house_member)
    visit "/house_members/#{@rep.id}"
    click_on "Compare Positions"
    has_field? "Search"
  end
  it "has a dropdown with topic selection", :vcr do
    create(:bill, primary_subject: "Armed Forces and National Security")
    create(:bill, primary_subject: "Public Lands and Natural Resources")
    @rep = create(:house_member)
    visit "/house_members/#{@rep.id}"
    click_on "Compare Positions"

    page.select("Armed Forces and National Security")
    expect(page).to have_content("Armed Forces and National Security")
    page.select("Public Lands and Natural Resources")
    expect(page).to have_content("Public Lands and Natural Resources")
  end

  it "has field to enter number of bills to compare", :vcr do
    @rep = create(:house_member)
    visit "/house_members/#{@rep.id}"
    click_on "Compare Positions"

    has_field? "Search"
  end
end

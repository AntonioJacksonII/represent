require 'rails_helper'

RSpec.describe "On the bill select page" do
  it "has a field to enter the bill number" do
    visit "/bills"
    has_field? "Search"
  end
  it "has a dropdown with topic selection" do
    create(:bill, primary_subject: "Armed Forces and National Security")
    create(:bill, primary_subject: "Public Lands and Natural Resources")
    visit "/bills"

    page.select("Armed Forces and National Security")
    expect(page).to have_content("Armed Forces and National Security")
    page.select("Public Lands and Natural Resources")
    expect(page).to have_content("Public Lands and Natural Resources")
  end

  it "has field to enter number of bills to compare" do
    visit "/bills"

    has_field? "Search"
  end
end

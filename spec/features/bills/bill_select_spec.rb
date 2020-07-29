require 'rails_helper'

RSpec.describe "On the bill select page" do
  it "has a field to enter the bill number" do
    visit "/bills"
    has_field? "Search"
  end
  xit "has a dropdown with topic selection" do
    bill = Bill.create(bill_id: 1, offset: 2, primary_subject: "Armed Forces and National Security")
    bill2 = Bill.create(bill_id: 2, offset: 2, primary_subject: "New Topic")
    visit "/bills"
    binding.pry
    click_on "Select Topic"
    expect(page).to have_content("New Topic")
    expect(page).to have_content("Armed Forces and National Security")
  end

  it "has field to enter number of bills to compare" do
    visit "/bills"

    has_field? "Search"
  end
end

require 'rails_helper'

RSpec.describe "As a visitor, when i visit the home page" do
  it "has a select bar with states" do
    visit "/"

    expect(page).to have_content("Select a state to see representatives")
    expect(page).to have_content("Search a representative by name:")
  end

  it "reroutes the user to the representatives state index page" do
    visit "/"
    select("Alaska")
  end

end

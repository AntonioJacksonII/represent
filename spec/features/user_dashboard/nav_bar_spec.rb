require 'rails_helper'

RSpec.describe "as a logged in user" do
  describe "it shows links to favorites reps and senators" do
    before(:each) do
      @member1 = create(:house_member, state: "CO", congress_id: "A000374", last_name: "zz")

      @senator1 = create(:senator, state: "CO", congress_id: "E000296", last_name: "zz")
    end

    it "is a clickable link" do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/senators/#{@senator1.id}"
      click_button "Add to Favorites"
      visit "/dashboard"
      expect(page).to have_content("#{@senator1.first_name}")
      expect(page).to have_content("#{@senator1.last_name}")
      click_on "#{@senator1.first_name}"
      expect(current_path).to eq("/senators/#{@senator1.id}")
    end
    it "shows both reps and senators" do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/senators/#{@senator1.id}"
      click_button "Add to Favorites"
      visit "/house_members/#{@member1.id}"
      click_button "Add to Favorites"
      visit "/dashboard"
      expect(page).to have_content("#{@senator1.first_name}")
      expect(page).to have_content("#{@senator1.last_name}")
      expect(page).to have_content("#{@member1.first_name}")
      expect(page).to have_content("#{@member1.last_name}")
      click_on "#{@member1.first_name}"
      expect(current_path).to eq("/house_members/#{@member1.id}")
    end
  end
end

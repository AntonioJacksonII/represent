require 'rails_helper'

RSpec.describe "on the rep or senator show page" do
  describe "It shows a buton to favorite and remove favorite" do
    before(:each) do
      @member1 = create(:house_member, state: "CO", congress_id: "A000374", last_name: "zz")

      @senator1 = create(:senator, state: "CO", congress_id: "E000296", last_name: "zz")
    end
    it "as a logged in user it shows the add favorites button", :vcr do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/house_members/#{@member1.id}"

      has_button? "Add to Favorites"
      visit "/senators/#{@senator1.id}"
      has_button? "Add to Favorites"
    end
    it "allows the logged in user to add representative to favorites", :vcr do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/house_members/#{@member1.id}"
      click_on "Add to Favorites"
      favorites = user.house_members.first

      expect(favorites).to eq(@member1)
    end
    it "allows a logged in user to remove from representative favorites", :vcr do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit "/house_members/#{@member1.id}"
      click_on "Add to Favorites"
      has_button? "Remove from Favorites"
      click_button "Remove from Favorites"

      favorites = user.house_members

      expect(favorites).to_not eq(@member1)
    end
    it "allows a logged in user to add senator from favorites", :vcr do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/senators/#{@senator1.id}"
      click_on "Add to Favorites"
      favorites = user.senators.first

      expect(favorites).to eq(@senator1)
    end
    it "allows a logged in user to remove senator from favorites", :vcr do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/senators/#{@senator1.id}"
      click_on "Add to Favorites"
      click_on "Remove from Favorites"
      favorites = user.senators

      expect(favorites).to_not eq(@senator1)
    end
    it "shows a message for a non logged in user to sign up", :vcr do
      visit "/senators/#{@senator1.id}"
      expect(page).to have_content("Click on Register to favorite")
      visit "/house_members/#{@member1.id}"
      expect(page).to have_content("Click on Register to favorite")
    end
  end
end

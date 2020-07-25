require 'rails_helper'

RSpec.describe "Representatives Index Page" do
  describe "Issue-18 As a visitor, when I select a state from the dropdown menu" do
    before(:each) do
      @member1 = create(:house_member, state: "CO")
      @member2 = create(:house_member, state: "FL")
      @member3 = create(:house_member, state: "CO")
      @member4 = create(:house_member, state: "CO")
      @member5 = create(:house_member, state: "CA")
      @member6 = create(:house_member, state: "CO")
      @member7 = create(:house_member, state: "CO")
      @member8 = create(:house_member, state: "CA")
      @member9 = create(:house_member, state: "CO")
      @member10 = create(:house_member, state: "CO")

      @senator1 = create(:senator, state: "CO")
      @senator2 = create(:senator, state: "CO")
      @senator3 = create(:senator, state: "MN")
      @senator4 = create(:senator, state: "CT")
    end

    it 'it displays the name of the state in the header' do 
      visit '/representatives/CO'

      expect(page).to have_content("Colorado")

      visit '/representatives/MN'

      expect(page).to have_content("Minnesota")

      visit '/representatives/SC'

      expect(page).to have_content("South Carolina")

    end 
    it 'it displays the names of all house members from that state' do 
      visit '/representatives/CO'

      expect(page).to have_css('.member', count: 7)

      within(first('.member')) do
        within('.name') do
          expect(page).to have_content("#{@member1.full_name}")
        end
      end
    end 

    it 'it displays the names of all senate members from that state' do 
      visit '/representatives/CO'

      expect(page).to have_css('.senator', count: 2)

      within(first('.senator')) do
        within('.name') do
          expect(page).to have_content("#{@senator1.first_name} #{@senator1.last_name}")
        end
      end

    end 
  end
end

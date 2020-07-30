require 'rails_helper'

describe 'Representative Show Pages' do
  it 'displays house member information', :vcr do
    parser = PropublicaParser.new
    parser.parse_house_members
    aoc = HouseMember.where(first_name: 'Alexandria', last_name: 'Ocasio-Cortez').first

    visit "/house_members/#{aoc.id}"

    expect(page).to have_css('.rep-info')
    within('.rep-info') do
      expect(page).to have_css('#rep-image')
      expect(page).to have_css('.rep-name')
      within ('.rep-name') do
        expect(page).to have_content('Alexandria Ocasio-Cortez')
      end
      # expect(page).to have_button('Add to Favorites')
      expect(page).to have_css('.rep-dob')
      expect(page).to have_css('.rep-gender')
      expect(page).to have_css('.rep-party')
      expect(page).to_not have_css('.rep-leadership')
      expect(page).to_not have_css('.rep-facebook')
      expect(page).to have_css('.rep-twitter')
      expect(page).to have_css('.rep-url')
      expect(page).to_not have_css('.rep-contact')
      expect(page).to have_css('.rep-cook_pvi')
      expect(page).to_not have_css('.rep-dw_nominate')
      expect(page).to have_css('.rep-total_votes')
      expect(page).to have_css('.rep-missed_votes')
      expect(page).to have_css('.rep-office')
      expect(page).to have_css('.rep-phone')
      expect(page).to have_css('.rep-district')
      expect(page).to have_css('.rep-missed_votes_percentage')
      expect(page).to have_css('.rep-votes_with_percentage')
      expect(page).to have_css('.rep-votes_without_party_percentage')
    end
    expect(page).to have_link('Compare Positions')
  end

  it 'displays senator information', :vcr do
    parser = PropublicaParser.new
    parser.parse_senators
    bennet = Senator.where(first_name: 'Michael', last_name: 'Bennet').first

    visit "/senators/#{bennet.id}"

    expect(page).to have_css('.sen-info')
    within('.sen-info') do
      expect(page).to have_css('#sen-image')
      expect(page).to have_css('.sen-name')
      within ('.sen-name') do
        expect(page).to have_content('Michael Bennet')
      end
      # expect(page).to have_button('Add to Favorites')
      expect(page).to have_css('.sen-dob')
      expect(page).to have_css('.sen-gender')
      expect(page).to have_css('.sen-party')
      expect(page).to_not have_css('.sen-leadership')
      expect(page).to have_css('.sen-facebook')
      expect(page).to have_css('.sen-twitter')
      expect(page).to have_css('.sen-url')
      expect(page).to have_css('.sen-contact')
      expect(page).to have_css('.sen-dw_nominate')
      expect(page).to have_css('.sen-next_election')
      expect(page).to have_css('.sen-total_votes')
      expect(page).to have_css('.sen-missed_votes')
      expect(page).to have_css('.sen-office')
      expect(page).to have_css('.sen-phone')
      expect(page).to have_css('.sen-state')
      expect(page).to have_css('.sen-missed_votes_percentage')
      expect(page).to have_css('.sen-votes_with_percentage')
      expect(page).to have_css('.sen-votes_without_party_percentage')
      expect(page).to have_link('Compare Positions')
    end
  end
end

require 'rails_helper'

RSpec.describe 'on the comparison page' do
  it 'lists a specific bill selected by the visitor/user' do
    aoc = HouseMember.create!(first_name: 'Alexandria', last_name: 'Ocasio-Cortez', congress_id: "O000172")
    parser = PropublicaParser.new
    parser.parse_bills

    bill = Bill.first

    visit "/comparison?bill=#{bill.bill_id}&id=#{aoc.congress_id}"

    expect(page).to have_content('Compare Your Votes with Alexandria Ocasio-Cortez')
    expect(page).to have_content('For the bills below, select "YES" if you would vote for the bill or "NO" if you would vote against the bill.')

    expect(page).to have_css('#bills-table')
    within('#bills-table') do
      expect(page).to have_css('#bill-title')
      expect(page).to have_link(bill.short_title)
      expect(page).to have_css('#bill-summary')
      expect(page).to have_css('#vote-yes')
      expect(page).to have_css('#vote-no')
    end

    choose "#{bill.bill_id}_yes"
    click_button('Submit Your Votes and Get Your Comparison Score')
    expect(current_path).to eq("/results/#{aoc.congress_id}")
  end

  it 'lists bills selected by topic' do
    aoc = HouseMember.create!(first_name: 'Alexandria', last_name: 'Ocasio-Cortez', congress_id: "O000172")
    parser = PropublicaParser.new
    parser.parse_bills

    bill_1 = Bill.last
    bill_2 = Bill.where(bill_id: "hr1957-116").first

    visit "/comparison?topic=Public%20Lands%20and%20Natural%20Resources&id=#{aoc.congress_id}"

    expect(page).to have_content('Compare Your Votes with Alexandria Ocasio-Cortez')
    expect(page).to have_content('For the bills below, select "YES" if you would vote for the bill or "NO" if you would vote against the bill.')

    expect(page).to have_css('#bills-table')
    within('#bills-table') do
      expect(page).to have_css('#bill-title')
      expect(page).to have_link(bill_1.short_title)
      expect(page).to have_link(bill_2.short_title)
      expect(page).to have_css('#bill-summary')
      expect(page).to have_css('#vote-yes')
      expect(page).to have_css('#vote-no')
    end

    choose "#{bill_1.bill_id}_yes"
    choose "#{bill_2.bill_id}_no"
    click_button('Submit Your Votes and Get Your Comparison Score')
    expect(current_path).to eq("/results/#{aoc.congress_id}")
  end

end

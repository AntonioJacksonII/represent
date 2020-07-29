require 'rails_helper'

RSpec.describe 'on the comparison page' do
  it 'lists a specific bill selected by the visitor/user' do
    aoc = HouseMember.create!(first_name: 'Alexandria', last_name: 'Ocasio-Cortez', congress_id: "O000172")
    json_response = File.read('spec/fixtures/bill.json')
    parser = PropublicaParser.new
    bill = parser.parse_bill(json_response, 0)

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
    json_response = File.read('spec/fixtures/bill.json')
    parser = PropublicaParser.new
    bill_1 = parser.parse_bill(json_response, 0)
    bill_2 =   Bill.create!(id: 20,
        bill_id: "hr1957-116",
        summary_short:
         "Great American Outdoors Act This bill establishes the National Parks and Public Land Legacy Restoration Fund to support deferred maintenance projects on federal lands.  For FY2021-FY2025, there shall be deposited into the fund an amount equal to 50% of energy development revenues credited, covered, or deposited as miscellaneous receipts from oil, gas, coal, or alternative or renewable energy development on federal lands and waters. Deposited amounts must not exceed $1.9 billion for any fiscal...",
        congress_url: "https://www.congress.gov/bill/116th-congress/house-bill/1957",
        short_title: "Great American Outdoors Act",
        primary_subject: "Armed Forces and National Security",
        offset: 0,
        created_at: "Tue, 28 Jul 2020 19:37:05 UTC +00:00",
        updated_at: "Tue, 28 Jul 2020 19:37:05 UTC +00:00",
        passage_roll_call: 153)

    visit "/comparison?topic=Armed%20Forces%20and%20National%20Security&id=#{aoc.congress_id}"

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

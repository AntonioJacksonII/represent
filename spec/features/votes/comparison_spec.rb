require 'rails_helper'

RSpec.describe 'on the comparison page' do
  it 'lists a bill selected by the visitor/user' do
    json_response = File.read('spec/fixtures/bill.json')
    parser = PropublicaParser.new
    bill = parser.parse_bill(json_response, 0)

    visit "/comparisons?bill=#{bill.bill_id}"

    expect(page).to have_content('Compare Your Votes')
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
    expect(current_path).to eq(results_path)
  end
end

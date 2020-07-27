require 'rails_helper'

RSpec.describe 'on the comparison page' do
  it 'lists the bill(s) selected by the visitor/user' do
    visit comparisons_path

    expect(page).to have_content('Compare Your Votes')
    expect(page).to have_content('For the bills below, select "yes" if you would vote for the bill or "no" if you would vote against the bill')

    expect(page).to have_css('#bills-table')
    within('#bills-table') do
      expect(page).to have_css('#bill-name')
      expect(page).to have_css('#bill-summary')
      expect(page).to have_css('#bill-vote')
    end
  end
end

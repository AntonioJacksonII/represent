require "rails_helper"

describe "Logged in User" do
  before(:each) do
    @user1 = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

    @aoc = HouseMember.create!(first_name: 'Alexandria', last_name: 'Ocasio-Cortez', congress_id: "O000172")
    # json_response = File.read('spec/fixtures/bill.json')
    # parser = PropublicaParser.new
    # @bill_1 = parser.parse_bill(json_response, 0)
    @bill_1 =   Bill.create!(
      bill_id: "hr6395-116",
      summary_short:
      "To authorize appropriations for fiscal year 2021 for military activities of the Department of Defense and for military construction, to prescribe military personnel strengths for such fiscal year, and for other purposes.",
      congress_url: "https://www.congress.gov/bill/116th-congress/house-bill/6395",
      short_title: "William M. (Mac) Thornberry National Defense Authorization Act for Fiscal Year 2021",
      primary_subject: "Armed Forces and National Security"
    )

    @bill_2 =   Bill.create!(
      bill_id: "hr1957-116",
      summary_short:
      "Great American Outdoors Act This bill establishes the National Parks and Public Land Legacy Restoration Fund to support deferred maintenance projects on federal lands.  For FY2021-FY2025, there shall be deposited into the fund an amount equal to 50% of energy development revenues credited, covered, or deposited as miscellaneous receipts from oil, gas, coal, or alternative or renewable energy development on federal lands and waters. Deposited amounts must not exceed $1.9 billion for any fiscal...",
      congress_url: "https://www.congress.gov/bill/116th-congress/house-bill/1957",
      short_title: "Great American Outdoors Act",
      primary_subject: "Armed Forces and National Security",
      created_at: "Tue, 28 Jul 2020 19:37:05 UTC +00:00",
      updated_at: "Tue, 28 Jul 2020 19:37:05 UTC +00:00")
    
    @house_bill_vote1 = create(:house_bill_vote, roll_call: 153, offset: 0, bill_id: @bill_1.id)
    @house_bill_vote2 = create(:house_bill_vote, roll_call: 152, offset: 20, bill_id: @bill_2.id)

    visit "/comparison?topic=Armed%20Forces%20and%20National%20Security&id=#{@aoc.congress_id}"
    choose "#{@bill_1.bill_id}_yes"
    choose "#{@bill_2.bill_id}_no"
    click_button('Submit Your Votes and Get Your Comparison Score')
    

    # We are passed in from the comparisions page a congress_id, each bill's ID and whether the user voted yes or no
    # Need to identify whether the congress_id is a house or senate member
    # Then we need to look up in the BillVotes table and get role call # and the offset
    # Then we hit our member votes api and see how the member voted on each bill 
    # One we have that information, compare that with how the user voted, then create a comparison score
    # and then save the comparison score on the respective favorites table

    # <ActionController::Parameters {"utf8"=>"✓", 
    #                                "authenticity_token"=>"5Gf72jXaZfaYZbuGTdQr9GYUYoH6+yt62i4ih2RLWch48REkHi3cq8Dc5F5Ts91coqtOLZ16FxvDISWLv9P5qw==", 
    #                                "hr6395-116"=>"yes", "hr1957-116"=>"no", "commit"=>"Submit Your Votes and Get Your Comparison Score", 
    #                                "controller"=>"results", 
    #                                "action"=>"show", 
    #                                "congress_id"=>"O000172"} permitted: false>
    
  end

  it "User sees results from comparison with politician" do

    # binding.pry

    # visit dashboard_path

    # expect(page).to have_css(".cards", count: 6)

    # within(first('.cards')) do
    #   expect(page).to have_css(".card-title")
    #   expect(page).to have_css(".card-source")
    #   expect(page).to have_css(".card-link")
    # end
  end

  xit "User has a prefabbed twitter response to send to representative" do

    visit dashboard_path

    expect(page).to have_css(".cards", count: 6)

    within(first('.cards')) do
      expect(page).to have_css(".card-title")
      expect(page).to have_css(".card-source")
      expect(page).to have_css(".card-link")
    end
  end
end
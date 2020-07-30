require "rails_helper"

describe "Logged in User" do
  before(:each) do
    @user1 = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

    @aoc = HouseMember.create!(first_name: 'Alexandria', last_name: 'Ocasio-Cortez', congress_id: "O000172")
    @lamar = Senator.create!(first_name: 'Lamar', last_name: 'Alexander', congress_id: "A000360")

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
      
    @bill_3 =   Bill.create!(
      bill_id: "s4049-116",
      summary_short:
      "To authorize appropriations for fiscal year 2021 for military activities of the Department of Defense and for military construction, to prescribe military personnel strengths for such fiscal year, and for other purposes.",
      congress_url: "https://www.congress.gov/bill/116th-congress/house-bill/6395",
      short_title: "William M. (Mac) Thornberry National Defense Authorization Act for Fiscal Year 2021",
      primary_subject: "Armed Forces and National Security"
     )

    @house_bill_vote1 = create(:house_bill_vote, roll_call: 153, offset: 0, bill_id: @bill_1.id)
    @house_bill_vote2 = create(:house_bill_vote, roll_call: 152, offset: 20, bill_id: @bill_2.id)

    @senate_bill_vote1 = SenateBillVote.create!(roll_call: 140, offset: 0, bill: @bill_3)
    @senate_bill_vote2 = SenateBillVote.create!(roll_call: 121, offset: 20, bill: @bill_2)
  end
  
  it "User sees results from comparison with house member", :vcr do
    
    visit "/comparison?topic=Armed%20Forces%20and%20National%20Security&id=#{@aoc.congress_id}"
    choose "#{@bill_1.bill_id}_yes"
    choose "#{@bill_2.bill_id}_yes"
    click_button('Submit Your Votes and Get Your Comparison Score')

    comparison_score = find(".comparison-score").text

    within('.comparison-score') do
      expect(page).to have_content(@aoc.full_name)
    end

    expect(page).to have_css(".comparison-score")
    expect(comparison_score).to_not be_empty

    expect(page).to have_css(".agreed-votes")
    within('.agreed-votes') do
      expect(page).to have_content("William M. (Mac) Thornberry National Defense Authorization Act for Fiscal Year 2021")
    end

    expect(page).to have_css(".disagreed-votes")
    within('.disagreed-votes') do
      expect(page).to have_content("Great American Outdoors Act")
    end
  end

  it "User sees results from comparison with senator", :vcr do

    visit "/comparison?topic=Armed%20Forces%20and%20National%20Security&id=#{@lamar.congress_id}"
    choose "#{@bill_3.bill_id}_yes"
    choose "#{@bill_2.bill_id}_no"
    click_button('Submit Your Votes and Get Your Comparison Score')

    comparison_score = find(".comparison-score").text

    expect(page).to have_css(".comparison-score")
    expect(comparison_score).to_not be_empty

    
    expect(page).to have_css(".agreed-votes")
    within('.agreed-votes') do
      expect(page).to have_content("William M. (Mac) Thornberry National Defense Authorization Act for Fiscal Year 2021")
    end

    expect(page).to have_css(".disagreed-votes")
    within('.disagreed-votes') do
      expect(page).to have_content("Great American Outdoors Act")
    end
    save_and_open_page
  end

  it "User sees results from comparison with senator who is a favorite", :vcr do

    SenatorFavorite.create(senator_id: @lamar.id, user_id: @user1.id)

    visit "/comparison?topic=Armed%20Forces%20and%20National%20Security&id=#{@lamar.congress_id}"
    choose "#{@bill_3.bill_id}_yes"
    choose "#{@bill_2.bill_id}_no"
    click_button('Submit Your Votes and Get Your Comparison Score')

    comparison_score = find(".comparison-score").text

    expect(page).to have_css(".comparison-score")
    expect(comparison_score).to_not be_empty

    
    expect(page).to have_css(".agreed-votes")
    within('.agreed-votes') do
      expect(page).to have_content("William M. (Mac) Thornberry National Defense Authorization Act for Fiscal Year 2021")
    end

    expect(page).to have_css(".disagreed-votes")
    within('.disagreed-votes') do
      expect(page).to have_content("Great American Outdoors Act")
    end
    
    visit dashboard_path
    
    within('.compared-rep') do
      expect(page).to have_content(@lamar.full_name)
      expect(page).to have_content("50%")
    end
  end

  it "User sees results from comparison with house member who is a favorite", :vcr do

    HouseFavorite.create!(house_member_id: @aoc.id, user_id: @user1.id)

    visit "/comparison?topic=Armed%20Forces%20and%20National%20Security&id=#{@aoc.congress_id}"
    choose "#{@bill_1.bill_id}_yes"
    choose "#{@bill_2.bill_id}_yes"
    click_button('Submit Your Votes and Get Your Comparison Score')

    comparison_score = find(".comparison-score").text

    expect(page).to have_css(".comparison-score")
    expect(comparison_score).to_not be_empty

    
    expect(page).to have_css(".agreed-votes")
    within('.agreed-votes') do
      expect(page).to have_content("William M. (Mac) Thornberry National Defense Authorization Act for Fiscal Year 2021")
    end

    expect(page).to have_css(".disagreed-votes")
    within('.disagreed-votes') do
      expect(page).to have_content("Great American Outdoors Act")
    end
    
    visit dashboard_path

    within('.compared-rep') do
      expect(page).to have_content(@aoc.full_name)
      expect(page).to have_content("50%")
    end
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
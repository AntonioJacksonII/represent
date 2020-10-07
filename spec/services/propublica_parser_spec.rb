require 'rails_helper'

describe 'Propublica parser' do
  it 'can parse a representative', :vcr do
    parser = PropublicaParser.new
    parser.parse_house_members
    test_member = HouseMember.first

    expect(test_member.first_name).to eq("Ralph")
    expect(test_member.last_name).to eq("Abraham")
    expect(test_member.congress_id).to eq("A000374")
    expect(test_member.dob).to eq("1954-09-16")
    expect(test_member.gender).to eq("M")
    expect(test_member.party).to eq("R")
    expect(test_member.leadership_role).to be_empty
    expect(test_member.twitter_account).to eq("RepAbraham")
    expect(test_member.facebook_account).to eq("CongressmanRalphAbraham")
    expect(test_member.govtrack_id).to eq(412630)
    expect(test_member.url).to eq("https://abraham.house.gov")
    expect(test_member.contact_form).to be_nil
    expect(test_member.cook_pvi).to eq("R+15")
    expect(test_member.dw_nominate).to eq(0.541)
    expect(test_member.total_votes).to be_a(Integer)
    expect(test_member.missed_votes).to be_a(Integer)
    expect(test_member.office).to eq("417 Cannon House Office Building")
    expect(test_member.phone).to eq("202-225-8490")
    expect(test_member.state).to eq("LA")
    expect(test_member.district).to eq(5)
    expect(test_member.at_large).to eq(false)
    expect(test_member.missed_votes_percentage).to be_a(Float)
    expect(test_member.votes_with_percentage).to be_a(Float)
    expect(test_member.votes_without_party_percentage).to be_a(Float)

    expect(HouseMember.count).to eq(436)
  end

  it 'can parse a senator', :vcr do
    parser = PropublicaParser.new
    parser.parse_senators
    test_senator = Senator.first

    expect(test_senator.first_name).to eq("Lamar")
    expect(test_senator.last_name).to eq("Alexander")
    expect(test_senator.congress_id).to eq("A000360")
    expect(test_senator.dob).to eq("1940-07-03")
    expect(test_senator.gender).to eq("M")
    expect(test_senator.party).to eq("R")
    expect(test_senator.leadership_role).to be_nil
    expect(test_senator.twitter_account).to eq("SenAlexander")
    expect(test_senator.facebook_account).to eq("senatorlamaralexander")
    expect(test_senator.govtrack_id).to eq(300002)
    expect(test_senator.url).to eq("https://www.alexander.senate.gov/public")
    expect(test_senator.contact_form).to eq("http://www.alexander.senate.gov/public/index.cfm?p=Email")
    expect(test_senator.dw_nominate).to eq(0.324)
    expect(test_senator.next_election).to eq(2020)
    expect(test_senator.total_votes).to be_a(Integer)
    expect(test_senator.missed_votes).to be_a(Integer)
    # expect(test_senator.last_updated).to eq(DateTime.parse('23rd Jul 2020 16:01:39 -0400'))
    expect(test_senator.office).to eq("455 Dirksen Senate Office Building")
    expect(test_senator.phone).to eq("202-224-4944")
    expect(test_senator.state).to eq("TN")
    expect(test_senator.senate_class).to eq(2)
    expect(test_senator.state_rank).to eq("senior")
    expect(test_senator.missed_votes_percentage).to be_a(Float)
    expect(test_senator.votes_with_percentage).to be_a(Float)
    expect(test_senator.votes_without_party_percentage).to be_a(Float)

    expect(Senator.count).to eq(100)
  end

  it 'can seed and update bills', :vcr do
    parser = PropublicaParser.new
    parser.seed_and_update_bills

    test_bill = Bill.last

    expect(test_bill.bill_id).to eq('s47-116')
    expect(test_bill.summary_short).to include("Natural Resources Management Act")
    expect(test_bill.congress_url).to eq("https://www.congress.gov/bill/116th-congress/senate-bill/47")
    expect(test_bill.short_title).to eq("John D. Dingell, Jr. Conservation, Management, and Recreation Act")
    expect(test_bill.primary_subject).to eq("Public Lands and Natural Resources")
    expect(test_bill.house_bill_vote.session).to eq(1)
    expect(test_bill.house_bill_vote.roll_call).to eq(95)
    expect(test_bill.senate_bill_vote.session).to eq(1)
    expect(test_bill.senate_bill_vote.roll_call).to eq(22)

    expect(Bill.count).to eq(236)
    expect(HouseBillVote.count).to eq(231)
    expect(SenateBillVote.count).to eq(18)
  end
end

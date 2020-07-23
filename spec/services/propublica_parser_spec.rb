require 'rails_helper'

describe 'Propublica parser' do
  it 'can parse a representative' do
    json_response = File.read('spec/fixtures/house_representatives.json')
    parser = PropublicaParser.new(json_response)

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
    expect(test_member.dw_nominate).to eq(0.54)
    expect(test_member.total_votes).to eq(853)
    expect(test_member.missed_votes).to eq(292)
    expect(test_member.last_updated).to eq(DateTime.parse('22nd Jul 2020 15:30:29-04:00'))
    expect(test_member.office).to eq("417 Cannon House Office Building")
    expect(test_member.phone).to eq("202-225-8490")
    expect(test_member.state).to eq("LA")
    expect(test_member.district).to eq(5)
    expect(test_member.at_large).to eq(false)
    expect(test_member.missed_votes_percentage).to eq(34.23)
    expect(test_member.votes_with_percentage).to eq(94.78)
    expect(test_member.votes_without_party_percentage).to eq(5.04)

    expect(HouseMember.count).to eq(437)
  end

  it 'can parse a senator' do
    json_response = File.read('spec/fixtures/senate.json')
    parser = PropublicaParser.new(json_response)

    parser.parse_senators
    test_senator = Senator.first

    expect(test_senator.first_name).to eq("Lamar")
    expect(test_senator.last_name).to eq("Alexander")
    expect(test_senator.congress_id).to eq("A000360")
    expect(test_senator.dob).to eq("1940-07-03")
    expect(test_senator.gender).to eq("M")
    expect(test_senator.party).to eq("R")
    expect(test_senator.leadership_role).to be_empty
    expect(test_senator.twitter_account).to eq("SenAlexander")
    expect(test_senator.facebook_account).to eq("senatorlamaralexander")
    expect(test_senator.govtrack_id).to eq(300002)
    expect(test_senator.url).to eq("https://www.alexander.senate.gov/public")
    expect(test_senator.contact_form).to eq("http://www.alexander.senate.gov/public/index.cfm?p=Email")
    expect(test_senator.dw_nominate).to eq(0.324)
    expect(test_senator.next_election).to eq(2020)
    expect(test_senator.total_votes).to eq(564)
    expect(test_senator.missed_votes).to eq(105)
    expect(test_senator.last_updated).to eq(DateTime.parse('22nd Jul 2020 14:30:59-04:00'))
    expect(test_senator.office).to eq("455 Dirksen Senate Office Building")
    expect(test_senator.phone).to eq("202-224-4944")
    expect(test_senator.state).to eq("TN")
    expect(test_senator.senate_class).to eq(2)
    expect(test_senator.state_rank).to eq("senior")
    expect(test_senator.missed_votes_percentage).to eq(18.62)
    expect(test_senator.votes_with_percentage).to eq(96.27)
    expect(test_senator.votes_without_party_percentage).to eq(3.73)
  end
end

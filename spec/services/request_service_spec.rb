require 'rails_helper'

describe 'Sinatra Request API Service' do
  it 'gets all representatives' do

    representatives = RequestService.new.get_representatives

    expect(representatives[:data]).to be_a(Array)
    expect(representatives[:data].count).to eq(449)
    expect(representatives[:data].first).to have_key(:first_name)
    expect(representatives[:data].first).to have_key(:last_name)
    expect(representatives[:data].first).to have_key(:congress_id)
    expect(representatives[:data].first).to have_key(:dob)
    expect(representatives[:data].first).to have_key(:gender)
    expect(representatives[:data].first).to have_key(:party)
    expect(representatives[:data].first).to have_key(:leadership_role)
    expect(representatives[:data].first).to have_key(:twitter_account)
    expect(representatives[:data].first).to have_key(:facebook_account)
    expect(representatives[:data].first).to have_key(:govtrack_id)
    expect(representatives[:data].first).to have_key(:url)
    expect(representatives[:data].first).to have_key(:contact_form)
    expect(representatives[:data].first).to have_key(:cook_pvi)
    expect(representatives[:data].first).to have_key(:dw_nominate)
    expect(representatives[:data].first).to have_key(:total_votes)
    expect(representatives[:data].first).to have_key(:missed_votes)
    expect(representatives[:data].first).to have_key(:last_updated)
    expect(representatives[:data].first).to have_key(:office)
    expect(representatives[:data].first).to have_key(:phone)
    expect(representatives[:data].first).to have_key(:state)
    expect(representatives[:data].first).to have_key(:district)
    expect(representatives[:data].first).to have_key(:at_large)
    expect(representatives[:data].first).to have_key(:missed_votes_percentage)
    expect(representatives[:data].first).to have_key(:votes_with_percentage)
    expect(representatives[:data].first).to have_key(:votes_without_party_percentage)
  end

  it 'gets all senators' do

    senators = RequestService.new.get_senators

    expect(senators[:data]).to be_a(Array)
    expect(senators[:data].count).to eq(101)
    expect(senators[:data].first).to have_key(:first_name)
    expect(senators[:data].first).to have_key(:last_name)
    expect(senators[:data].first).to have_key(:congress_id)
    expect(senators[:data].first).to have_key(:dob)
    expect(senators[:data].first).to have_key(:gender)
    expect(senators[:data].first).to have_key(:party)
    expect(senators[:data].first).to have_key(:leadership_role)
    expect(senators[:data].first).to have_key(:twitter_account)
    expect(senators[:data].first).to have_key(:facebook_account)
    expect(senators[:data].first).to have_key(:govtrack_id)
    expect(senators[:data].first).to have_key(:url)
    expect(senators[:data].first).to have_key(:contact_form)
    expect(senators[:data].first).to have_key(:dw_nominate)
    expect(senators[:data].first).to have_key(:next_election)
    expect(senators[:data].first).to have_key(:total_votes)
    expect(senators[:data].first).to have_key(:missed_votes)
    expect(senators[:data].first).to have_key(:last_updated)
    expect(senators[:data].first).to have_key(:office)
    expect(senators[:data].first).to have_key(:phone)
    expect(senators[:data].first).to have_key(:state)
    expect(senators[:data].first).to have_key(:senate_class)
    expect(senators[:data].first).to have_key(:state_rank)
    expect(senators[:data].first).to have_key(:missed_votes_percentage)
    expect(senators[:data].first).to have_key(:votes_with_percentage)
    expect(senators[:data].first).to have_key(:votes_without_party_percentage)
  end

  it 'gets all articles' do

    favorite_names = "Nancy Pelosi, John Hickenlooper"
    sort = "popularity"
    language = "en"
    num_results = 5

    articles = RequestService.new.get_articles(favorite_names, sort, language, num_results)

    expect(articles[:data]).to be_a(Array)
    expect(articles[:data].count).to eq(5)
    expect(articles[:data].first).to have_key(:source)
    expect(articles[:data].first).to have_key(:title)
    expect(articles[:data].first).to have_key(:description)
    expect(articles[:data].first).to have_key(:url)
    expect(articles[:data].first).to have_key(:published_at)
  end
end
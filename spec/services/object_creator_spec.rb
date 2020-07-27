require 'rails_helper'

describe 'RequestObjectCreator' do
  it 'creates house member objects' do
    creator = ObjectCreator.new

    members = creator.create_members

    expect(members.first).to be_a(HouseMember)
  end

  it 'creates senator objects' do
    creator = ObjectCreator.new

    senators = creator.create_senators

    expect(senators.first).to be_a(Senator)
  end
end
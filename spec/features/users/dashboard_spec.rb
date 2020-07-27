require "rails_helper"

describe "Logged in User" do
  before(:each) do
    @user1 = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

    @member1 = create(:house_member, first_name: "Nancy", last_name: "Pelosi")
    @member2 = create(:house_member, first_name: "Mitt", last_name: "Romney")
    @member3 = create(:house_member)

    HouseFavorite.create(user_id: @user1.id, house_member_id: @member1.id)
    HouseFavorite.create(user_id: @user1.id, house_member_id: @member2.id)

    @senator1 = create(:senator, first_name: "Amy", last_name: "Klobuchar")
    @senator2 = create(:senator, first_name: "Cory", last_name: "Gardner")
    @senator3 = create(:senator)

    SenatorFavorite.create(user_id: @user1.id, senator_id: @senator1.id)
    SenatorFavorite.create(user_id: @user1.id, senator_id: @senator2.id)
  end
  xit "User sees news articles from favorited represntatives on dashboard", :vcr do

    visit dashboard_path

    # expect(user.name).to eq("Tom Smith")
    # expect(user.email).to eq("tom.smith@email.com")
  end
end
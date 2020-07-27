require "rails_helper"

describe "Visitor" do
  it "Visitor can create account through google oauth" do

    OmniAuth.config.test_mode = true
    auth_hash = OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({
        "provider"=>"google_oauth2",
        "info"=> {
          "name"=>"Tom Smith",
          "email"=>"tom.smith@email.com",
          "unverified_email"=>"tom.smith@email.com",
          "email_verified"=>true,}
          })

    user = User.from_omniauth(auth_hash)

    expect(user.name).to eq("Tom Smith")
    expect(user.email).to eq("tom.smith@email.com")

    OmniAuth.config.mock_auth[:google] = nil
  end
end

describe "User" do
  it "Registered user can logout" do

    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path
    
    click_on "Logout"

    expect(current_path).to eq(root_path)
  end
end

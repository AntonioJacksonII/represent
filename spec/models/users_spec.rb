require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it {should have_many :house_favorites}
    it {should have_many(:house_members).through(:house_favorites)}
    it {should have_many :senator_favorites}
    it {should have_many(:senators).through(:senator_favorites)}
  end

  describe 'validations' do
    it {should validate_presence_of :email}
    it {should validate_presence_of :name}
    it {should validate_uniqueness_of :email}
  end

  describe 'instance methods' do
    before(:each) do
      @user1 = create(:user)
      @user2 = create(:user)

      @member1 = create(:house_member)
      @member2 = create(:house_member)

      @senator1 = create(:senator)
      @senator2 = create(:senator)
    end

    it "has_favorites?" do
      HouseFavorite.create(user_id: @user2.id, house_member_id: @member1.id)

      expect(@user1.has_favorites?).to eq(false)
      expect(@user2.has_favorites?).to eq(true)
    end
  end
end

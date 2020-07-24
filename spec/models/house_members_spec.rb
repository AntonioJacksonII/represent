require 'rails_helper'

RSpec.describe HouseMember, type: :model do
  describe 'class methods' do
    before(:each) do
      @member1 = create(:house_member, state: "CO")
      @member2 = create(:house_member, state: "AL")
      @member3 = create(:house_member, state: "CO")
      @member4 = create(:house_member, state: "TX")
    end

    it 'by_state' do

      expect(HouseMember.by_state("CO")).to eq([@member1, @member3])
    end
  end
end

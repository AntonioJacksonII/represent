require 'rails_helper'

RSpec.describe HouseBillVote, type: :model do
  describe 'validations' do
    it {should validate_presence_of :roll_call}
    it {should validate_presence_of :session}
  end

  describe 'relationships' do
    it {should belong_to :bill}
  end
end

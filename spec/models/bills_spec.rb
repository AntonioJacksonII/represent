require 'rails_helper'

RSpec.describe Bill, type: :model do
  describe 'validations' do
    it {should validate_presence_of :bill_id}
  end

  describe 'relationships' do
    it {should have_one :house_bill_vote}
    it {should have_one :senate_bill_vote}
  end
end

require 'rails_helper'

RSpec.describe Bill, type: :model do
  describe 'validations' do
    it {should validate_presence_of :bill_id}
    it {should validate_presence_of :offset}
  end
end

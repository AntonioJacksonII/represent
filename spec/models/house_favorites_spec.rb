require 'rails_helper'

RSpec.describe HouseFavorite, type: :model do
  describe 'relationships' do
    it {should belong_to :house_member}
  end
end

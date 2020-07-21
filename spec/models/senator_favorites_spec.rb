require 'rails_helper'

RSpec.describe SenatorFavorite, type: :model do
  describe 'relationships' do
    it {should belong_to :senator}
  end
end

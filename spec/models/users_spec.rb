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
  end

end

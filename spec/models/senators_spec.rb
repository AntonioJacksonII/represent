require 'rails_helper'

RSpec.describe Senator, type: :model do
  describe 'class methods' do
    before(:each) do
      @senator1 = create(:senator, state: "CO", last_name: 'A')
      @senator2 = create(:senator, state: "ME", last_name: 'B')
      @senator3 = create(:senator, state: "MN", last_name: 'C')
      @senator4 = create(:senator, state: "CO", last_name: 'D')
    end

    it 'by_state' do

      expect(Senator.by_state("CO")).to eq([@senator1, @senator4])
    end
  end

  describe 'instance methods' do
    before(:each) do
      @senator1 = create(:senator, state: "CO")
      @senator2 = create(:senator, state: "ME")
      @senator3 = create(:senator, state: "MN")
      @senator4 = create(:senator, state: "CO")
    end

    it 'full_name' do

      expect(@senator1.full_name).to eq("#{@senator1.first_name} #{@senator1.last_name}")
    end
  end
end

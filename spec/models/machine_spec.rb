require 'rails_helper'

RSpec.describe Machine, type: :model do
  describe 'validations' do
    it { should validate_presence_of :location }
    it { should belong_to :owner }
  end

  describe "relationships" do
    it { should have_many(:snacks).through(:machine_snacks) }
  end

  describe "instance methods" do
    it "#average_price" do
      owner = Owner.create(name: "Sam's Snacks")
      dons  = owner.machines.create(location: "Don's Mixed Drinks")
      snack_1 = dons.snacks.create(name: "KitKat", price: 2.50)
      snack_2 = dons.snacks.create(name: "Snickers", price: 1.70)
      avg_price = (snack_1.price + snack_2.price) / 2.0

      expect(dons.average_price).to eq (avg_price)
    end
  end
end

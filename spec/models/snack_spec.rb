require 'rails_helper'

RSpec.describe Snack, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :price }
    it { should have_many(:machines).through(:machine_snacks) }
  end


  describe "instance methods" do
    it "#machine_count" do
      snack_1 = Snack.create(name: "KitKat", price: 2.50)
      owner = Owner.create(name: "Sam's Snacks")
      dons  = snack_1.machines.create(location: "Don's Mixed Drinks", owner: owner)
      turing  = snack_1.machines.create(location: "Turing Basement", owner: owner)

      expect(snack_1.machine_count).to eq (2)
    end
  end
end

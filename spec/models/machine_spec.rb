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

    it "#snack_count" do
      owner = Owner.create(name: "Sam's Snacks")
      dons  = owner.machines.create(location: "Don's Mixed Drinks")
      snack_1 = dons.snacks.create(name: "KitKat", price: 2.50)
      snack_2 = dons.snacks.create(name: "Snickers", price: 1.70)

      expect(dons.snack_count).to eq (2)
    end

    it "#snack_count_words - single" do
      owner = Owner.create(name: "Sam's Snacks")
      dons  = owner.machines.create(location: "Don's Mixed Drinks")
      snack_1 = dons.snacks.create(name: "KitKat", price: 2.50)

      expect(dons.snack_count_words).to eq ("1 kind")
    end

    it "#snack_count_words - multiple" do
      owner = Owner.create(name: "Sam's Snacks")
      dons  = owner.machines.create(location: "Don's Mixed Drinks")
      snack_1 = dons.snacks.create(name: "KitKat", price: 2.50)
      snack_2 = dons.snacks.create(name: "Snickers", price: 1.70)

      expect(dons.snack_count_words).to eq ("2 kinds")
    end

    it "#unique_snacks" do
      owner = Owner.create(name: "Sam's Snacks")
      turing  = owner.machines.create(location: "Turing Basement")
      snack_1 = Snack.create(name: "KitKat", price: 2.50)
      snack_2 = Snack.create(name: "Snickers", price: 1.70)
      turing.machine_snacks.create(snack: snack_1)
      turing.machine_snacks.create(snack: snack_1)
      turing.machine_snacks.create(snack: snack_2)


      expect(turing.unique_snacks).to eq ([snack_1, snack_2])
    end
  end
end

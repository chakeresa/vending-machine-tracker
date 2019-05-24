require 'rails_helper'

RSpec.describe 'When a user visits a snack show page', type: :feature do
  scenario 'they see the attributes of that snack' do
    snack = Snack.create(name: "KitKat", price: 2.50)
    other_snack = Snack.create(name: "Snickers", price: 1.50)

    visit snack_path(snack)

    expect(page).to have_content(snack.name)
    expect(page).to have_content("Price: $#{snack.price}")

    expect(page).to_not have_content(other_snack.name)
    expect(page).to_not have_content("Price: $#{other_snack.price}")
  end

  scenario "they see a list of vending machines selling that snack" do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    turing  = owner.machines.create(location: "Turing Basement")
    other_machine  = owner.machines.create(location: "Some Other Place")
    snack_1 = dons.snacks.create(name: "KitKat", price: 2.50)
    snack_2 = dons.snacks.create(name: "Snickers", price: 1.70)
    turing.machine_snacks.create(snack: snack_1)
    turing.machine_snacks.create(snack: snack_1)
    other_machine.machine_snacks.create(snack: snack_2)

    visit snack_path(snack_1)

    expect(page).to have_content("Locations")

    within("#machine-#{dons.id}") do
      expect(page).to have_content("#{dons.location} (2 kinds of snacks, average price of $#{((snack_2.price + snack_2.price)/2.0).round(2)})")
    end

    within("#machine-#{turing.id}") do
      expect(page).to have_content("#{turing.location} (1 kind of snacks, average price of $#{snack_1.price.round(2)})")
    end

    expect(page).to_not have_content(other_machine.location)
  end
end
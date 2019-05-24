require 'rails_helper'

RSpec.describe 'When a user visits a vending machine show page', type: :feature do
  scenario 'they see the location of that machine' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")

    visit machine_path(dons)

    expect(page).to have_content("Don's Mixed Drinks Vending Machine")
  end

  scenario "they see the names and prices of all snacks in that machine" do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    snack_1 = dons.snacks.create(name: "KitKat", price: 2.50)
    snack_2 = dons.snacks.create(name: "Snickers", price: 1.70)

    visit machine_path(dons)

    within("#snack-#{snack_1.id}") do
      expect(page).to have_content("#{snack_1.name}: $#{snack_1.price}")
    end

    within("#snack-#{snack_2.id}") do
      expect(page).to have_content("#{snack_2.name}: $#{snack_2.price}")
    end
  end

  scenario "they see the average price of all snacks in that machine" do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    snack_1 = dons.snacks.create(name: "KitKat", price: 2.50)
    snack_2 = dons.snacks.create(name: "Snickers", price: 1.70)
    avg_price = (snack_1.price + snack_2.price) / 2.0

    visit machine_path(dons)

    expect(page).to have_content("Average Price: $#{avg_price}")
  end
end

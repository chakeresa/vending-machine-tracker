require 'rails_helper'

RSpec.describe 'When a user visits a snack show page', type: :feature do
  scenario 'they see the attributes of that snack' do
    snack = Snack.create(name: "KitKat", price: 2.50)
    other_snack = Snack.create(name: "Snickers", price: 1.50)

    visit snack_path(snack)

    expect(page).to have_content(snack.name)
    expect(page).to have_content("$#{snack.price}")
    
    expect(page).to_not have_content(other_snack.name)
    expect(page).to_not have_content("$#{other_snack.price}")
  end
end
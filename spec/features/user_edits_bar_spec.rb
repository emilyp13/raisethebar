require 'rails_helper'

feature 'user edits bar' do
  let!(:bar) do
    Bar.create(
    name: 'Punters',
    address: '40 Huntington Ave',
    city: 'Boston',
    state: 'MA',
    zip: '02120',
    description: 'An awful college dive bar.'
    )
  end

  scenario 'user visits detail page and edits bar info successfully' do
    visit bars_path
    click_link bar.name
    click_link 'Edit'

    fill_in 'Name', with: 'The Mission'
    fill_in 'Address', with: '20 Huntington Ave'

    click_button 'Update Bar'

    expect(page).to have_content('The Mission')
    expect(page).to have_content('20 Huntington Ave')
    expect(page).to_not have_content(bar.name)
    expect(page).to_not have_content(bar.address)
  end

  scenario 'user visits detail page and edits bar info unsuccessfully' do
    visit bars_path
    click_link bar.name
    click_link 'Edit'

    fill_in 'Name', with: 'The Mission'
    fill_in 'Address', with: ''
    fill_in 'Zip', with: 'unknown'

    click_button 'Update Bar'

    expect(page).to have_content("Address can't be blank, Zip is not a number, Zip is the wrong length (should be 5 characters)")
  end
end

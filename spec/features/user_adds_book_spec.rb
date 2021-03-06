require 'rails_helper'

feature 'user adds book' do

  background do
    visit root_path
    user = create(:user)
    sign_in_as(user)
    add_book
    visit root_path
    click_link user.username
    click_link "ToRead"
  end

  scenario 'successfully' do
    expect(page).to have_content "Harry Potter and the Sorcerer's Stone"
  end

  scenario 'but already had this book' do
    within('.book', text: "Harry Potter and the Sorcerer's Stone") do
      expect(page).to have_no_button 'Add to MyReads'
    end
  end
end

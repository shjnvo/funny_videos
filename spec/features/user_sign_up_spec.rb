require 'rails_helper'

feature 'Visitor register' do
  scenario 'with valid email and password' do
    register_with 'valid@example.com', 'password'
    visit root_path

    expect(page).to have_content('valid@example.com')
  end

  scenario 'with invalid email' do
    register_with 'invalid_email', 'password'

    expect(page).to have_content('register')
  end

  scenario 'with blank password' do
    register_with 'valid@example.com', ''

    expect(page).to have_content('register')
  end

  def register_with(email, password)
    visit root_path
    fill_in 'email', with: email
    fill_in 'password', with: password
    click_button 'register_user'
  end
end
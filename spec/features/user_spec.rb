# frozen_string_literal: true

require 'rails_helper'
require 'sign_in_helper'

describe 'I want work with user,' do
  scenario 'sign in with correct password' do
    user = User.create email: 'user@example.com',
                       password: '12345678'

    visit root_path

    sign_in 'user@example.com', '12345678'

    expect(page).to have_link 'Sign out'
  end

  scenario 'sign in with incorrect password' do
    user = User.create email: 'user@example.com',
                       password: '12345678'

    visit root_path

    sign_in 'user@example.com', '11111111'
    expect(page).to have_content('Invalid Email or password.')
    expect(page).not_to have_link 'Sign out'
  end

  scenario 'edit user test' do
    visit root_path
    user = User.create email: 'user@example.com',
                       password: '12345678'
    sign_in 'user@example.com', '12345678'

    click_button 'edit'
    name = 'Name'
    last_name = 'Last name'

    fill_in :user_name, with: name
    fill_in :user_last_name, with: last_name
    fill_in :user_current_password, with: '12345678'

    click_on 'Submit'

    expect(page).to have_content "#{name} #{last_name}"
  end
end

# frozen_string_literal: true

def sign_in(email, password)
  click_on 'Sign in'

  fill_in :user_email, with: email
  fill_in :user_password, with: password

  click_button 'Submit'
end

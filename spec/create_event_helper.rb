# frozen_string_literal: true

require 'sign_in_helper'

def create_event(name, content, period)
  user = User.create email: 'user@example.com',
                     password: '12345678'
  visit root_path
  sign_in 'user@example.com', '12345678'

  visit new_event_path
  fill_in :event_title, with: name
  fill_in :event_content, with: content

  select '2020', from: :event_time_of_event_1i
  select 'January', from: :event_time_of_event_2i
  select '1', from: :event_time_of_event_3i
  select '12', from: :event_time_of_event_4i
  select '30', from: :event_time_of_event_5i

  select period, from: :event_period

  click_button 'Submit'
end

# frozen_string_literal: true

require 'rails_helper'
require 'create_event_helper'

describe 'As User I want to work with Events,' do
  scenario 'create event' do
    name = 'Event1'
    content = 'Content'
    period = 'weekly'

    create_event name, content, period

    expect(page).to have_content name
    expect(page).to have_content content
    expect(page).to have_content period
  end

  scenario 'edit event' do
    name = 'Event1'
    content = 'Content'
    period = 'weekly'

    create_event name, content, period
    click_on 'Edit'
    name2 = 'Edit2'

    fill_in :event_title, with: name2
    click_button 'Submit'

    expect(page).to have_content name2
  end

  scenario 'policy of event' do
    name = 'Event1'
    content = 'Content'
    period = 'weekly'

    create_event name, content, period
    expect(page).to have_link 'Edit'

    visit by_date_events_path(1, 1, 2020)
    expect(page).to have_link 'Edit'
    expect(page).to have_link 'Destroy'

    click_on 'Sign Out'

    user = User.create email: 'user2@example.com',
                       password: '12345678'

    sign_in 'user2@example.com', '12345678'

    visit by_date_events_path(1, 1, 2020)

    expect(page).to_not have_content name

    visit by_date_events_path(1, 1, 2020, group: :all)

    expect(page).to have_content name

    expect(page).to_not have_link 'Edit'
    expect(page).to_not have_link 'Destroy'
  end

  scenario 'copy event to my calendar' do
    visit root_path
    name = 'Event1'
    content = 'Content'
    period = 'weekly'
    create_event name, content, period
    click_on 'Sign Out'

    visit root_path

    user = User.create email: 'user2@example.com',
                       password: '12345678'
    sign_in 'user2@example.com', '12345678'
    visit by_date_events_path(1, 1, 2020)
    expect(page).to_not have_content name

    visit by_date_events_path(1, 1, 2020, group: :all)
    click_on name
    click_on "Copy"
    expect(page).to have_content 'Event copied successfully'
    visit by_date_events_path(1, 1, 2020)
    expect(page).to have_content name
  end
end

# frozen_string_literal: true
require 'spec_helper'

feature 'Users', feature: true do
  let(:user) { create(:user, name: 'user1', email: 'user1@imagehex.com', password: 'password') }

  scenario 'Creates a new user account' do
    visit new_user_registration_path
    fill_in 'user_email', with: 'user2@imagehex.com'
    fill_in 'user_name', with: 'user2'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    expect { click_button 'Create account' }.to change { User.count }.by(1)
  end
end

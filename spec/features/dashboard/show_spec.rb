require 'rails_helper'

RSpec.describe 'User Dashboard' do
  describe 'As a logged in user' do
    it 'I can visit my dashboard' do
      visit '/dashboard'
    end
  end
end

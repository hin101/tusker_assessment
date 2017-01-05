require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.create(:user) }

  it 'has a valid factory' do
  	expect(user).to be_valid
  end

  it { should validate_presence_of(:name) }
end

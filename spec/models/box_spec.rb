require 'rails_helper'

RSpec.describe Box, type: :model do
  let(:box) { FactoryGirl.create(:box) }

  it 'has a valid factory' do
  	expect(box).to be_valid
  end

  it { should validate_presence_of(:code) }

  it { should validate_uniqueness_of(:code) }

  it { should belong_to(:user) }

  it { should have_many(:box_contents) }

  it { should have_many(:contents).through(:box_contents) }
end

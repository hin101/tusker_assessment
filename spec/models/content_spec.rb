require 'rails_helper'

RSpec.describe Content, type: :model do
  let(:content) { FactoryGirl.create(:content) }

  it 'has a valid factory' do
  	expect(content).to be_valid
  end

  it { should validate_presence_of(:content) }

  it { should have_many(:box_contents) }

  it { should have_many(:boxes).through(:box_contents) }
end

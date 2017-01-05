require 'rails_helper'

RSpec.describe BoxContent, type: :model do
  it { should belong_to(:content) }
  it { should belong_to(:box) }
end

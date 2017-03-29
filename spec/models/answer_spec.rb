require 'rails_helper'

RSpec.describe Answer, type: :model do
  context "relationships" do
    it { should have_many(:comments) }
    it { should belong_to(:user) }
    it { should belong_to(:question) }
  end
end
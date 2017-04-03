require 'rails_helper'

RSpec.describe Downvote, type: :model do
  context "relationships" do
    it { should belong_to(:downvoted) }
    it { should belong_to(:user) }
  end

  context "validations" do
    it { should validate_presence_of(:creator) }
  end
end
require 'rails_helper'

RSpec.describe Comment, type: :model do
  context "relationships" do
    it { should belong_to(:commentable) }
    it { should belong_to(:user) }
  end

  context "validations" do
    it { should validate_presence_of(:body) }
  end
end
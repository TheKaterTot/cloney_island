require 'rails_helper'

RSpec.describe Comment, type: :model do
  context "relationships" do
    it { should belong_to(:answers) }
    it { should belong_to(:questions) }
    it { should belong_to(:users) }
  end
end
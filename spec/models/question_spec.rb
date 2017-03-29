require 'rails_helper'

RSpec.describe Question, type: :model do
  context "relationships" do
    it { should belong_to(:user) }
    it { should belong_to(:category) }
    it { should have_many(:answers) }
    it { should have_many(:comments) }
  end
end
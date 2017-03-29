require 'rails_helper'

RSpec.describe User, type: :model do
  context "relationships" do
    it { should have_many(:answers) }
    it { should have_many(:questions) }
    it { should have_many(:comments) }
    it { should have_many(:user_roles) }
    it { should have_many(:roles) }
  end
end
require 'rails_helper'

RSpec.describe User, type: :model do
  context "relationships" do
    it { should have_many(:answers) }
    it { should have_many(:questions) }
    it { should have_many(:comments) }
    it { should have_many(:user_roles) }
    it { should have_many(:roles) }
  end

  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:phone) }
  end
end
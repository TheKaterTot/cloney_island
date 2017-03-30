require 'rails_helper'

RSpec.describe Role, type: :model do
  context "relationships" do
    it { should have_many(:user_roles) }
  end

  context "validations" do
    it { should validate_presence_of(:name) }
  end
end
require 'rails_helper'

RSpec.describe User, type: :model do
  context "relationships" do
    it { should has_many(:answers) }
    it { should has_many(:questions) }
    it { should has_many(:comments) }
    it { should has_many(:user_roles) }
    it { should has_many(:roles) }
  end
end
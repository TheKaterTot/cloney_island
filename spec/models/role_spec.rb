require 'rails_helper'

RSpec.describe Role, type: :model do
  context "relationships" do
    it { should have_many(:user_roles) }
  end
end
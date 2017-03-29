require 'rails_helper'

RSpec.describe UserRole, type: :model do
  context "relationships" do
    it { should belongs_to(:user) }
    it { should belongs_to(:role) }
  end
end
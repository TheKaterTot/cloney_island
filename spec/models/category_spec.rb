require 'rails_helper'

RSpec.describe Category, type: :model do
  context "relationships" do
    it { should have_many(:questions) }
  end
end
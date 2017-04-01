require 'rails_helper'

describe TokenSender do
  let(:user) { Fabricate(:user) }
  let(:client) { double(:client) }
  let(:token) { TokenSender.new(user, client: client) }
  let(:messages) { double(:messages, create: true) }

  before do
    allow(client).to receive(:messages).and_return(messages)
  end

  describe "#execute" do
    it "generates a token" do
      token.execute
      expect(user.password_tokens.count).to eq(1)
      expect(user.password_tokens.first.token.length).to eq(8)
    end

    it "sends a message" do
      allow(token).to receive(:create_token).and_return("1")
      expect(messages).to receive(:create).with({
        from: ENV["twilio_number"],
        to: user.phone,
        body: "Your password reset token is: 1"
      })
      token.execute
    end
  end
end

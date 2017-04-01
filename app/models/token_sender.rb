class TokenSender
  def initialize(user, options={})
    @user = user
    @client = options[:client] || Twilio::REST::Client.new(ENV["twilio_key"], ENV["twilio_s_id"])
  end

  def execute
    token = create_token
    PasswordToken.create(user: @user, token: token)
    @client.messages.create({
      from: ENV["twilio_number"],
      to: @user.phone,
      body: "Your password reset token is: #{token}"
    })
  end

  private

  def create_token
    UUID.new
      .generate(:compact)
      .split("")
      .take(8)
      .join
  end
end

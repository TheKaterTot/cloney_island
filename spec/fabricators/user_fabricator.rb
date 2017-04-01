Fabricator(:user) do
  name 'burgerbob'
  email 'beefersutherland@example.com'
  password 'password'
  password_confirmation 'password'
  phone '8675309'
  image 'bologna'
  reputation 0
  roles { [Fabricate.build(:role, name: "registered_user")] }
end

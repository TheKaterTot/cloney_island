Fabricator(:user) do
  name 'burgerbob'
  email 'beefersutherland@example.com'
  password 'password'
  phone '8675309'
  image Faker::Avatar.image
  reputation 0
end

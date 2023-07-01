5.times do |n|
    name = Faker::Name.last_name
    email = Faker::Internet.email
    password = "password"
    User.create!(name: name,
                email: email,
                password: password,
                )
  end
end
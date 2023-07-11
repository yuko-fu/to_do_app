User.create!(name: "name",
            email: "email@mail.com",
            password: "password",
            password_confirmation: "password",
            admin: true)

  10.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
                email: email,
                password:              password,
                password_confirmation: password)

  5.times do |i|
    Label.create!(name: "sample#{i + 1}")
  end
end
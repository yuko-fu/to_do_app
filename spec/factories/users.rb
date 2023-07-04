FactoryBot.define do
  factory :user do
    name { 'D-robot' }
    email { 'dpro@mail.com' }
    password { '123456' }
    admin { 'true' }
  end
    
  factory :second_user, class: User do
    name { 'はなこ' }
    email { 'hanako@mail.com' }
    password { '123456' }
    admin { 'false' }
  end
end

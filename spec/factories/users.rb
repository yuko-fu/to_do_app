FactoryBot.define do
  factory :user do
    name { 'D-robot' }
    email { 'dpro@mail.com' }
    password { 'dpro@mail.com' }
    password_confirmation { 'dpro@mail.com' }
    admin { 'false' }
  end
    
  factory :second_user, class: User do
    name { 'はなこ' }
    email { 'hanako@mail.com' }
    password { 'hanako@mail.com' }
    password_confirmation { 'hanako@mail.com'  }
    admin { 'false' }
  end

  factory :third_user, class: User do
    name { '333' }
    email { '333@mail.com' }
    password { '333@mail.com' }
    password_confirmation { '333@mail.com'  }
    admin { 'false' }
  end

  factory :admin1_user, class: User do
    name { 'admin1' }
    email { 'admin1@mail.com' }
    password { 'admin1@mail.com' }
    password_confirmation { 'admin1@mail.com'  }
    admin { 'true' }
  end
  factory :admin2_user, class: User do
    name { 'admin2' }
    email { 'admin2@mail.com' }
    password { 'admin2@mail.com' }
    password_confirmation { 'admin2@mail.com'  }
    admin { 'true' }
  end
  factory :admin3_user, class: User do
    name { 'admin3' }
    email { 'admin3@mail.com' }
    password { 'admin3@mail.com' }
    password_confirmation { 'admin3@mail.com'  }
    admin { 'true' }
  end
  factory :admin4_user, class: User do
    name { 'admin4' }
    email { 'admin4@mail.com' }
    password { 'admin4@mail.com' }
    password_confirmation { 'admin4@mail.com'  }
    admin { 'true' }
  end
  factory :admin5_user, class: User do
    name { 'admin5' }
    email { 'admin5@mail.com' }
    password { 'admin5@mail.com' }
    password_confirmation { 'admin5@mail.com'  }
    admin { 'true' }
  end
end

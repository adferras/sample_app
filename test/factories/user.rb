FactoryGirl.define do
  factory :user, class: User do
    name { Faker::Name.name  }
    email { Faker::Internet.email }
    password_digest User.digest('password')
    activated true
    activated_at Time.zone.now
  end
end

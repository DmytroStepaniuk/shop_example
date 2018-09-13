FactoryBot.define do
  factory :user do
    sequence(:first_name) { |n| "users first name #{n}" }
    sequence(:last_name)  { |n| "users last name #{n}"  }

    password { 'password' }

    email { first_name.gsub(" ", "_") + "@test.com" }

    factory :user_with_session do
      after(:create) do |user|
        create(:session, user: user)
      end
    end
  end
end
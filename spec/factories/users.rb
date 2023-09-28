FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'password123' }
    password_confirmation { 'password123' }

    factory :user_with_avatar do
      avatar { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/avatar.jpg').to_s) }
    end
  end
end

FactoryBot.define do
  factory :architecture do
    user
    name { Faker::Lorem.words(number: 3).join(' ') }
    location { Faker::Address.city }
    architect { Faker::Name.name }
    description { Faker::Lorem.paragraph }
    open_range { 1 }
    experience { 0 }
    pref { '東京都' }

    transient do
      image_count { 3 }
    end

    after(:build) do |architecture, evaluator|
      architecture.images.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'sample.jpg')), filename: 'sample.jpg', content_type: 'image/jpeg')
      if evaluator.image_count > 1
        (evaluator.image_count - 1).times do
          architecture.images.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'sample.jpg')), filename: 'sample.jpg', content_type: 'image/jpeg')
        end
      end
    end
  end
end
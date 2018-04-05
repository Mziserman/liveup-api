FactoryBot.define do
  factory :user, aliases: [:streamer] do
    password "password"
    sequence(:email, 1)        { |n| "#{n}-#{Faker::Internet.email}" }

    factory :user_with_channel do
      after(:create) do |user, evaluator|
        create(:channel, streamer: user)
      end
    end

    factory :user_with_streams do
      transient do
        streams_count 5
      end

      after(:create) do |user, evaluator|
        create(:channel_with_streams, streamer: user, streams_count: evaluator.streams_count)
      end
    end
  end
end

FactoryBot.define do
  factory :channel do
    sequence(:name, 1)        { |n| "#{n}-#{Faker::Internet.name}" }

    factory :channel_with_streams do

      transient do
        streams_count 5
      end

      after(:create) do |channel, evaluator|
        create_list(:stream, evaluator.streams_count, channel: channel)
      end

    end

  end
end

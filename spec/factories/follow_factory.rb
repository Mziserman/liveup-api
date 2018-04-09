FactoryBot.define do
  factory :follow do
    before(:create) do |follow|
      follow.streamer = create(:user)
      follow.follower = create(:user)
    end
  end
end

require 'rails_helper'

RSpec.describe Channel, type: :model do
  context "association" do
    it { should belong_to(:streamer) }
    it { should have_many(:streams) }
    it { should have_many(:follows) }
  end

  context "channel" do
    let!(:channel) { create(:channel, :with_streamer) }
    let!(:follower) { create(:user) }
    let!(:follower2) { create(:user) }

    it "can't be persisted without streamer" do
      expect{ create(:channel) }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "can be persisted" do
      expect(channel).to be_persisted
      expect(channel.slug).to eq(channel.name.parameterize)
    end

    it "can have a stream" do
      stream = channel.streams.create
      expect(stream).to be_persisted
      expect(stream.channel).to eq channel
      expect(channel.streams.length).to eq 1
      expect(channel.streams.first).to eq stream
    end

    it "can be followed" do
      follow = channel.follows.create follower: follower
      expect(follow).to be_persisted
      expect(follow.follower).to eq(follower)
      expect(channel.followers).to eq([follower])

      follow2 = channel.follows.create follower: follower2
      channel.reload

      expect(channel.followers).to eq([follower, follower2])
    end
  end
end

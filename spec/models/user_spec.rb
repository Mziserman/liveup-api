require 'rails_helper'

RSpec.describe User, type: :model do
  context "association" do
    it { should have_one(:channel) }
    it { should have_many(:streams) }

    it { should have_many(:follows) }
    it { should have_many(:followed_channels) }
    it { should have_many(:followed_streamers) }

    it { should have_many(:followeds) }
    it { should have_many(:followed_by) }
  end

  context "streamer" do
    let!(:streamer) { create(:user_with_streams, streams_count: 10) }

    context "streamer" do
      it "has a channel" do
        expect(streamer.channel).to be_persisted
      end

      it "has streams" do
        expect(streamer.streams.count).to eq(10)
      end
    end
  end

  context "follower" do
    let!(:streamer) { create(:user_with_channel) }
    let!(:follower) { create(:user) }

    context "streamer" do
      it "can follow a channel" do
        expect(follower.follow! streamer.channel).to be_persisted
      end
    end
  end
end

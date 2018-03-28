streamer = User.create(email: "streamer@gmail.com", password: "salutcstreamer")
channel = streamer.create_channel
stream = channel.streams.create

follower = User.create(email: "follower@gmail.com", password: "salutcfollower")
follower.follows.create(channel: channel)

streamer = User.create(email: "streamer@gmail.com", password: "salutcstreamer")
stream = streamer.streams.create()

follower = User.create(email: "follower@gmail.com", password: "salutcfollower")
stream.followers << follower
stream.save

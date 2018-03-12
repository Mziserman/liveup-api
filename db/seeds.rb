# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

streamer = User.create(email: "streamer@gmail.com", password: "salutcstreamer")
stream = streamer.streams.create()

subscriber = User.create(email: "subscriber@gmail.com", password: "salutcsubscriber")
subscription = stream.subscriptions.create(stream: stream, user: subscriber)

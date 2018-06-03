module AwsStreamingConcern
  extend ActiveSupport::Concern
  include MediaPackageConcern
  include MediaLiveConcern

	SECURITY_GROUP_ID = "630998"

	CONFIG_CLIENT_AWS = {
		region: 'eu-west-1'
		# credentials: Aws::Credentials.new(ENV["AWS_ACCESS_KEY_ID"], ENV["AWS_SECRET_ACCESS_KEY"])
	}

	def get_channel(user_id, input_id, channel_id)

		client = Aws::MediaLive::Client.new(CONFIG_CLIENT_AWS)

		if channel_id
			state = check_status_channel(channel_id)
			if state == "STOPPING"
				input_id = nil,
				channel_id = nil
			end
		end

		puts "creating stream..."
		_destinations = get_or_create_package_channel(CONFIG_CLIENT_AWS, user_id)

		_channel = get_or_create_channel(client, user_id, _destinations[0], _destinations[1], SECURITY_GROUP_ID, input_id, channel_id)

		puts "stream created !"
		{
			channel_id: _channel[:channel_id],
			input_id: _channel[:input_id],
			output_stream_url: _destinations[0][:endpoint_output],
			input_stream_url: _channel[:destination_url]
		}
	end

	def start_stream(user_id, input_id=nil, channel_id=nil)
		client = Aws::MediaLive::Client.new(CONFIG_CLIENT_AWS)
		stream = get_channel(user_id, input_id, channel_id)
		puts "starting channel..."
		start_when_ready(stream[:channel_id])
		puts "channel is starting ! Note: this may take from 2 to 3 minutes"
		pp stream
		stream
	end

	def stop_stream(user_id, input_id, channel_id)
		client = Aws::MediaLive::Client.new(CONFIG_CLIENT_AWS)
		puts "stopping channel..."
		client.stop_channel({channel_id: channel_id})
		puts "channel stopped !"
		puts "deleting stream..."
		delete_when_stopped(client, user_id, input_id, channel_id)
		puts "stream deleted !"
	end

	def delete_when_stopped(client, user_id, input_id, channel_id, time_left=20)
		state = check_status_channel(channel_id)
		puts "current state of stream is %s" % state
		if time_left <= 0
			raise "An error occured"
		end
		if state == "IDLE"
			delete_package_channel_and_endpoint(CONFIG_CLIENT_AWS, user_id)
			delete_channel_and_input(client, input_id, channel_id)
		else
			sleep(3)
			time_left -= 1
			delete_when_stopped(client, user_id, input_id, channel_id, time_left)
		end
	end

	def start_when_ready(channel_id, time_left=20)
		client = Aws::MediaLive::Client.new(CONFIG_CLIENT_AWS)
		state = check_status_channel(channel_id)
		puts "current state of stream is %s" % state
		if time_left <= 0
			raise "An error occured"
		end
		if state == "IDLE"
			client.start_channel({channel_id: channel_id})
		elsif state != "RUNNING" && state != "STARTING"
			sleep(3)
			time_left -= 1
			start_when_ready(channel_id, time_left)
		end
	end

	def check_status_channel(channel_id)
		client = Aws::MediaLive::Client.new(CONFIG_CLIENT_AWS)
		begin
			client.describe_channel({channel_id: channel_id}).state
		rescue Aws::MediaLive::Errors::ServiceError
			"DOES_NOT_EXIST"
		end
	end
end

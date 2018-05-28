module MediaLiveConcern
  extend ActiveSupport::Concern
  include MediaPackageConcern
  include GetConfigLiveChannelConcern

	def create_input(client, user_id, security_group_id)
		client.create_input({
		  destinations: [
		    {
		      stream_name: "LiveupStreamChannelA/%s%s" % [user_id, security_group_id]
		    },
		    {
		      stream_name: "LiveupStreamChannelB/%s%s" % [user_id, security_group_id]
		    },
		  ],
		  input_security_groups: [security_group_id],
		  name: "%s-LiveupInput" % user_id,
		  type: "RTMP_PUSH", # accepts UDP_PUSH, RTP_PUSH, RTMP_PUSH, RTMP_PULL, URL_PULL
		})
	end

	def get_or_create_inputs(client, user_id, security_group_id, input_id)

		puts "creating input..."

		if input_id
			begin
				resp = client.describe_input({input_id: input_id})
			rescue Aws::MediaLive::Errors::ServiceError
				resp = nil
			end
		end

		unless resp && resp.state != "DELETED"
			resp = create_input(client, user_id, security_group_id).input
			puts "input created !"
		else
			puts "input found !"
		end

		{
			id: resp.id,
			name: resp.name,
			destination_a: resp.destinations[0].url,
			destination_b: resp.destinations[1].url
		}
	end

	def get_or_create_channel(client, user_id, endpoint_a, endpoint_b ,security_group_id, input_id, channel_id)
		input = get_or_create_inputs(client, user_id, security_group_id, input_id)

		input_id = input[:id]

		puts "creating channel..."

		if channel_id
			begin
				resp = client.describe_channel({channel_id: channel_id})
			rescue Aws::MediaLive::Errors::ServiceError
				resp = nil
			end
		end

		unless resp && resp.state != "DELETED"
			channel_config = get_config_live_channel(user_id, endpoint_a, endpoint_b, input_id)
			resp = client.create_channel(channel_config).channel
			puts "channel created !"
		else
			puts "channel found !"
		end

		{
			channel_id: resp.id,
			input_id: input_id,
			destination_url: input[:destination_a]
		}
	end

	def check_status_channel(client, channel_id)
		begin
			client.describe_channel({channel_id: channel_id}).state
		rescue Aws::MediaLive::Errors::ServiceError
			"DOES_NOT_EXIST"
		end
	end
end

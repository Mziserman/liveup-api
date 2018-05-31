module MediaPackageConcern
  extend ActiveSupport::Concern
  include SystemManagerConcern

	def get_or_create_package_channel(config_client, user_id, user_pseudo="a liveup user")

		client_package = Aws::MediaPackage::Client.new(config_client)
		client_parameters_store = Aws::SSM::Client.new(config_client)

		id_a, id_b = get_ids_package_channel(user_id)

		puts "creating package destination %s and %s..." % [id_a, id_b]

		begin
			resp_a = client_package.create_channel({
			  description: "Channel package A for %s" % user_pseudo,
			  id: id_a,
			})

			endpoint_a = create_package_endpoint(client_package, resp_a.id)

			resp_b = client_package.create_channel({
			  description: "Channel package B for %s" % user_pseudo,
			  id: id_b,
			})

			endpoint_b = create_package_endpoint(client_package, resp_b.id)

			puts "package destination created !"

		rescue Aws::MediaPackage::Errors::ServiceError

			resp_a = client_package.describe_channel({id: id_a})
			resp_b = client_package.describe_channel({id: id_b})

			puts "package destination found !"
		end

		password_param_a = create_parameter_store_password(
			client_parameters_store,
			resp_a.id,
			resp_a.hls_ingest.ingest_endpoints.first.password
		)
		password_param_b = create_parameter_store_password(
			client_parameters_store,
			resp_b.id,
			resp_b.hls_ingest.ingest_endpoints.first.password
		)

		[
			format_package_channel_response(resp_a, password_param_a, endpoint_a.url), 
			format_package_channel_response(resp_b, password_param_b, endpoint_b.url)
		]
	end

	def format_package_channel_response(response, password_param, endpoint_output)
		{
			id: response.id,
			username: response.hls_ingest.ingest_endpoints.first.username,
			password_param: password_param,
			url: response.hls_ingest.ingest_endpoints.first.url,
			endpoint_output: endpoint_output
		}
	end

	def delete_package_channel_and_endpoint(config_client, user_id)
		client = Aws::MediaPackage::Client.new(config_client)

		id_a, id_b = get_ids_package_channel(user_id)

		endpoint_a = get_ids_package_endpoint(id_a)
		endpoint_b = get_ids_package_endpoint(id_b)

		puts "deleting package endpoints ..."
		client.delete_origin_endpoint({id: endpoint_a})
		client.delete_origin_endpoint({id: endpoint_b})

		puts "package endpoints deleted !"
		puts "deleting package channels..."
		client.delete_channel({id: id_a})
		client.delete_channel({id: id_b})
		puts "package channels deleted !"
	end

	def get_ids_package_channel(user_id)
		[
			id_a = "%s-LiveupChannelA" % user_id,
			id_b = "%s-LiveupChannelB" % user_id
		]
	end

	def get_ids_package_endpoint(channel_id)
		"%sEndpoint" % channel_id
	end

	def create_package_endpoint(client, channel_id)
		config = {
		  "id": "%sEndpoint" % channel_id,
		  "channel_id": channel_id,
		  "description": "",
		  "startover_window_seconds": 0,
		  "time_delay_seconds": 0,
		  "manifest_name": "index",
		  "whitelist": [],
		  "hls_package": {
		    "playlist_type": "EVENT",
		    "include_iframe_only_stream": false,
		    "stream_selection": {
		      "stream_order": "ORIGINAL"
		    },
		    "use_audio_rendition_group": false,
		    "program_date_time_interval_seconds": 0,
		    "segment_duration_seconds": 6,
		    "playlist_window_seconds": 60,
		    "ad_markers": "NONE"
		  }
		}

		resp = client.create_origin_endpoint(config)
		puts "%sEndpoint created" % channel_id
		resp
	end

end

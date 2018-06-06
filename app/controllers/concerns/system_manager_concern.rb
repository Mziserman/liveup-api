module SystemManagerConcern
	extend ActiveSupport::Concern

	def create_parameter_store_password(client, id, password)

		name_parameter = "/liveup/mediapackage/%sPass" % id

		client.put_parameter({
			name: name_parameter,
			description: "Password for %s" % id,
			value: password,
			type: "SecureString", # required, accepts String, StringList, SecureString
			key_id: "alias/aws/ssm",
			overwrite: true
		})

		name_parameter
	end
end

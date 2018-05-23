CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     ENV["AWS_ACCESS_KEY_ID"],     # required
    aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"], # required
    region:                ENV["AWS_REGION"]             # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'liveup-avatars'               # required
  config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" } # optional, defaults to {}
end
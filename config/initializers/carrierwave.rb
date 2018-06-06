CarrierWave.configure do |config|
  config.ignore_integrity_errors = false
  config.ignore_processing_errors = false
  config.ignore_download_errors = false

  config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     ENV["AWS_ACCESS_KEY_ID"],     # required
    aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"], # required
    region:                'eu-west-3'             # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'liveup-avatar'               # required
  config.storage = :fog
  config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" } # optional, defaults to {}
end
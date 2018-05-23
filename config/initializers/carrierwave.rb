CarrierWave.configure do |config|
  config.ignore_integrity_errors = false
  config.ignore_processing_errors = false
  config.ignore_download_errors = false
  config.fog_provider = 'fog/aws' # 'fog/aws' etc. Defaults to 'fog'
end
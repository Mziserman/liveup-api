Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://redistogo:aff9cc76ddee4104f91bdd34ec257dc6@porgy.redistogo.com:10507/' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://redistogo:aff9cc76ddee4104f91bdd34ec257dc6@porgy.redistogo.com:10507/' }
end

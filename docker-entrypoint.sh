#!/bin/bash
set -e

cd /app

# If the first argument of the command is "start"...
if [ "$1" = 'start' ]; then
	# if db:migrate fails, then set ip up !
	bundle exec rake db:migrate || bundle exec rake db:create && bundle exec rake db:migrate
  	# exec = end of script
	exec bundle exec puma -v -p ${API_PORT:-3000} -C config/puma.rb
	# exec bundle exec rails s -p ${API_PORT:-3000} -b '0.0.0.0'
fi

if [ "$1" = 'sidekiq' ]; then
	exec bundle exec sidekiq
fi

if [ "$1" = 'cable' ]; then
	exec bundle exec puma -v -p 28080 cable/config.ru
fi

# Execute the command
exec "$@"

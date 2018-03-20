#!/bin/bash
set -e

cd /app

# If the first argument of the command is "start"...
if [ "$1" = 'start' ]; then
	# if db:migrate fails, then set ip up !
	rake db:migrate 2>/dev/null || bundle exec rake db:setup
  	# exec = end of script
	exec bundle exec rails s -p ${API_PORT:-3000} -b ${API_URL:-'0.0.0.0'}
fi

# Execute the command
exec "$@"

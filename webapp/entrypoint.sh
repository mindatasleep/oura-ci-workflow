#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /webapp/tmp/pids/server.pid

# Check for database
# if [ "$DATABASE" = "postgres" ]
# then
#     echo "Waiting for postgres..."

#     while ! nc -z $SQL_HOST $SQL_PORT; do
#       sleep 0.1
#     done

#     echo "PostgreSQL started"
# fi


# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"

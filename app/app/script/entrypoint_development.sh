#/bin/sh
echo -------------------------------
if [ -e /app/tmp/pids/server.pid ]; then
    rm -f /app/tmp/pids/server.pid;
fi

bundle exec rails db:migrate
foreman start
echo -------------------------------
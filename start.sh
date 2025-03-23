#!/bin/ash
echo "Starting Ghost..."
cd ./ghost && ghost run &
echo "Starting Caddy..."
./caddy-server run --watch --config ./caddy/Caddyfile

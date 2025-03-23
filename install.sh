#!/bin/ash
set -e

cd /mnt/server

apk add --no-cache curl sudo nodejs npm su-exec

npm install ghost-cli@latest -g

mkdir -p /.npm
chmod -R 755 /.npm

# Copy necessary files
cp -r ./temp/caddy /mnt/server/
cp ./temp/start.sh /mnt/server
curl "https://caddyserver.com/api/download?os=linux&arch=amd64&idempotency=33572405766393" -s --output /mnt/server/caddy-server

chmod +x /mnt/server/caddy-server
chmod +x /mnt/server/start.sh

mkdir -p /mnt/server/.ghost
ln -s /mnt/server/.ghost /.ghost

chown -R nobody: /mnt/server/
chmod -R u+w /mnt/server/

mkdir -p /home/container
chown -R nobody: /home/container/
chmod -R u+w /home/container/

mkdir -p /.cache/yarn
chown -R nobody: /.cache/yarn/
chmod -R u+w /.cache/yarn/

# Install Ghost headlessly with provided DB credentials
su -s /bin/ash nobody -c "ghost install --no-start --no-enable --no-prompt --dir /home/container/ghost --db mysql --dbhost $1 --dbuser $2 --dbpass $3 --dbname $4"
unlink /.ghost

mv /home/container/ghost /mnt/server

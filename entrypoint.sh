#!/bin/bash
sleep 1

cd /home/container

# Replace Startup Variables
MODIFIED_STARTUP=$(eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g'))
echo "Executing: ${MODIFIED_STARTUP}"

exec ${MODIFIED_STARTUP}

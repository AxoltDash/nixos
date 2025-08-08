#!/bin/bash

MAC="84:a9:3e:07:31:3e"
SERVER="192.168.101.200"
PORT=22

wakeonlan $MAC

echo "Waiting to open the SSH port..."

while ! nc -z $SERVER $PORT; do
  sleep 2
done

echo "Server READY. Conecting by SSH..."

ssh -i ~/.ssh/server axolt@$SERVER

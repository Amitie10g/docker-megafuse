#!/bin/bash

mkdir /tmp

# Write the config file from environment variables
if [ ! -f /config/megafuse.conf ]; then
  if [ $1 == "-i" ]; then
    [ -z "$USERNAME" ] && read -p "Username: " USERNAME || exit 1
    [ -z "$PASSWORD" ] && read -p "Password: " PASSWORD || exit 1
    [ -z "$APPKEY" ] && read   -p "App  key: " APPKEY || exit 1

    cat << EOF > megafuse.conf
###################
# Config file, please remove the # in front of the variable when you edit it: "#USERNAME" --> "USERNAME"
###################


USERNAME = $USERNAME
PASSWORD = $PASSWORD

##### create your appkey at https://mega.co.nz/#sdk

APPKEY = $APPKEY

#### you can specify a mountpoint here, only absolute paths are supported.

MOUNTPOINT = /mega

#### path for the cached files; /tmp is the default, change it if your /tmp is small

CACHEPATH = /tmp

EOF

    chown abc:abc /config/megafuse.conf
    
    megafuse -c /config/megafuse.conf

  else
    echo "Fatal: No config file found. Please run 'start.sh -i' or provide the required parameters from the envirnment variables."
  fi
fi
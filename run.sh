#!/bin/bash

main () {
  [ -n "$SEED" ] && echo "level-seed=$SEED" >> server/server.properties

  # Get current version
  [ -f "server/version" ] && current_version=$(cat "server/version") || current_version=0
  echo "Current version: $current_version"

  # Get latest version
  url="https://net.web.minecraft-services.net/api/v1.0/download/links"
  download_url=$(curl -s "$url" | jq -r ".result.links[] | select(.downloadType==\"serverBedrockLinux\") | .downloadUrl")
  latest_version=$(echo "$download_url" | sed 's#.*r-##; s#\.zip##')
  echo "Latest version: $latest_version"

  # Update if not up-to-date
  [ $current_version != $latest_version ] && update

  # Run updater in background
  ./update.sh &

  # Starting server
  echo "Starting server..."
  cd server
  screen -S mc ./bedrock_server
}

update () {
  # Download new version
  echo "Downloading new version..."
  download_file=$(echo "$download_url" | sed 's#.*/##')
  wget -q "$download_url" -O "$download_file"

  # Backup current config
  [ -f "server/server.properties" ] && cp "server/server.properties" "server/server.properties.bak"
  [ -f "server/permissions.json" ] && cp "server/permissions.json" "server/permissions.json.bak"

  # Extract
  echo "Extracting archive..."
  unzip -oq "$download_file" -d "server"
  rm "$download_file"
  echo "$latest_version" > "server/version"
  echo "Updated!"

  # Restore config
  cp "server/server.properties" "server/server.properties.org"
  cp "server/permissions.json" "server/permissions.json.org"
  [ -f "server/server.properties.bak" ] && mv "server/server.properties.bak" "server/server.properties"
  [ -f "server/permissions.json.bak" ] && mv "server/permissions.json.bak" "server/permissions.json"
}

main

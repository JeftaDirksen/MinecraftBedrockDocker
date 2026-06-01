#!/bin/bash
echo "Online players check started."
sleep 10
while true; do
  echo "Checking online players..."
  screen -S mc -X logfile /tmp/mc_output
  screen -S mc -X logfile flush 1
  screen -S mc -X log on
  screen -S mc -X stuff "list\n"
  sleep 2
  screen -S mc -X log off
  sleep 2
  online_players="-1"
  online_players=$(cat /tmp/mc_output | grep -oP '(?<=There are )\d+(?=/\d+ players online)')
  rm -f /tmp/mc_output
  world_size=$(du -s server/worlds | awk '{printf "%.5f", $1 / 1024 / 1024}')
  # Send data to NumericValueGraphing URL if configured
  if [ -n "$NVG_URL" ] && [ -n "$NVG_SECRET" ]; then
      echo ""
      echo "Sending data to NumericValueGraphing: players=$online_players, worldsize=$world_size GB"
      curl -d secret=$NVG_SECRET -d players=$online_players -d worldsize=$world_size $NVG_URL
  fi

  sleep 1m
done

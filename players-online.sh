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
  echo ""
  echo "Players online: $online_players"
  sleep 1m
done

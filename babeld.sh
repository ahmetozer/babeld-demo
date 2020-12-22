#!/bin/bash
#   Start babeld for each namespace
#   ahmetozer.org
#
interfaces=()
while read p; do
    interfaces+=("$p")
done <<<$(ls /sys/class/net/ | grep vertex)

babeld -I /var/run/babeld$node_ID.pid "${interfaces[@]}"
sleep 30
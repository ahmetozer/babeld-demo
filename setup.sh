#!/bin/bash
#   Create enviroment for test
#   ahmetozer.org
#
NAMESPACE_COUNT=20

###
# ! I recommend to run this script in temporary container.
# docker run -it --rm --privileged ahmetozer/cna
# in container curl https://gist.githubusercontent.com/ahmetozer/d01538327a98ed70cf04e48e89fe8c31/raw/mesh-topology-example.sh -o mesh-topology-example.sh ; chmod +x mesh-topology-example.sh
###

# IANA TEST NET 3  - 203.0.113.0/24 - https://tools.ietf.org/html/rfc5737
IP_BLOCK="203.0.113"

if [ "$1" == "print" ]; then
    RUN_COMMAND='echo'
else
    RUN_COMMAND='command'
fi
command -v babeld
if [ $? != 0 ]; then
    export DEBIAN_FRONTEND=noninteractive
    apt update
    apt install babeld screen -y
fi
# Create namespaces
echo -e "\n\tCreateting namespaces"
for ((i = 1; i <= $NAMESPACE_COUNT; i++)); do
    $RUN_COMMAND ip netns add node-$i
    $RUN_COMMAND ip netns exec node-$i bash -c "
        ifconfig lo up;
        echo 1 >/proc/sys/net/ipv6/conf/all/forwarding;
        echo 1 >/proc/sys/net/ipv4/ip_forward;
    "
done

set -e
for ((i = 1; i <= $NAMESPACE_COUNT; i++)); do
    echo -e "\n\tFor node-$i"
    for ((n = (($i + 1)); n <= $NAMESPACE_COUNT; n++)); do
        $RUN_COMMAND ip link add vertex$i-$n netns node-$i type veth peer name vertex$n-$i netns node-$n
        $RUN_COMMAND ip netns exec node-$i ifconfig vertex$i-$n $IP_BLOCK.$i up
        $RUN_COMMAND ip netns exec node-$n ifconfig vertex$n-$i $IP_BLOCK.$n up
    done
    node_ID=$i $RUN_COMMAND ip netns exec node-$i screen -dmS node-$i-babeld ./babeld.sh
done

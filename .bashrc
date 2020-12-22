#!/bin/bash

function jump {
    if [ -z $ns ]; then
    local ns=${1-"node-1"}
    local e2=${2-"bash"}
    shift 2
    ns=$ns ip netns exec $ns $e2 $@
    else
        echo "You are already in namespace \"$ns\"."
    fi
}
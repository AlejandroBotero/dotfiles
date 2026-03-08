#!/bin/bash
if ! command -v nvidia-smi &> /dev/null; then
    echo "OFF"
    exit 0
fi

usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null)
if [ $? -ne 0 ]; then
    echo "OFF"
else
    echo "${usage}%"
fi

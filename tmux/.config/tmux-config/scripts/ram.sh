#!/bin/bash
used_mem=$(top -l 1 | grep "PhysMem" | awk '{print $2}')
total_mem=$(echo $(( $(sysctl -n hw.memsize) / 1024 / 1024 / 1024 ))G)
echo "$used_mem / $total_mem"

#!/bin/bash

# Get page size (in bytes)
page_size=$(sysctl -n hw.pagesize)

# Get stats from vm_stat
vm_stat_out=$(vm_stat)

# Extract pages (remove trailing dot)
pages_wired=$(echo "$vm_stat_out" | grep "Pages wired" | awk '{print $NF}' | tr -d '.')
pages_compressed=$(echo "$vm_stat_out" | grep "Pages occupied by compressor" | awk '{print $NF}' | tr -d '.')
pages_anonymous=$(echo "$vm_stat_out" | grep "Anonymous pages" | awk '{print $NF}' | tr -d '.')
pages_purgeable=$(echo "$vm_stat_out" | grep "Pages purgeable" | awk '{print $NF}' | tr -d '.')

# Check if we got anonymous pages (modern macOS), otherwise fallback to active
if [ -z "$pages_anonymous" ]; then
    pages_active=$(echo "$vm_stat_out" | grep "Pages active" | awk '{print $NF}' | tr -d '.')
    used_bytes=$(( (pages_active + pages_wired + pages_compressed) * page_size ))
else
    # App Memory = Anonymous - Purgeable
    # Used = App Memory + Wired + Compressed
    used_bytes=$(( (pages_anonymous - pages_purgeable + pages_wired + pages_compressed) * page_size ))
fi

# Calculate total bytes
total_bytes=$(sysctl -n hw.memsize)

# Convert to GB using awk for floating point precision
used_gb=$(awk -v val=$used_bytes 'BEGIN {printf "%.1f", val / 1024 / 1024 / 1024}')
total_gb=$(awk -v val=$total_bytes 'BEGIN {printf "%.0f", val / 1024 / 1024 / 1024}')

echo "${used_gb}G / ${total_gb}G"

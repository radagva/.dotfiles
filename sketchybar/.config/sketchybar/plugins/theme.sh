#!/bin/bash

# Debounce to prevent multiple executions if the event fires twice
if [ "$SENDER" = "theme_change" ]; then
  # Get current timestamp
  NOW=$(date +%s)
  
  # File to store the last execution time
  LOCK_FILE="/tmp/sketchybar_theme_change.lock"
  
  # Check if lock file exists
  if [ -f "$LOCK_FILE" ]; then
    LAST_RUN=$(cat "$LOCK_FILE")
    DIFF=$((NOW - LAST_RUN))
    
    # If less than 2 seconds have passed, exit
    if [ $DIFF -lt 2 ]; then
      exit 0
    fi
  fi
  
  # Update the lock file
  echo "$NOW" > "$LOCK_FILE"
  
  # Run the update
  sketchybar --update
fi

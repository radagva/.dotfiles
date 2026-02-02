#!/bin/bash
top -l 1 | grep -E "^CPU" | awk '{
    usage = $3 + $5;
    if (usage >= 70) color="#ed8796";
    else if (usage >= 50) color="#f5a97f";
    else if (usage >= 10) color="#eed49f";
    else color="#cad3f5";
    
    printf "#[fg=%s] %s%%", color, usage
}'

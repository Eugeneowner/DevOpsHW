#!/bin/bash

echo "Script executed at $(date)" >> "/var/log/disk_space_$(date '+%Y-%m-%d_%H-%M-%S').log"
df -h >> "/var/log/disk_space_$(date '+%Y-%m-%d_%H-%M-%S').log"

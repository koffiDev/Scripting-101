#!/bin/bash

# Get a list of Linode IDs with the label "test-linode"
linodes=$(linode-cli linodes list --json | jq -r '.[] | select(.label | startswith("test-linode")) | .id')

# Loop through each Linode ID and delete the Linode
for linode in $linodes; do
  linode-cli linodes delete $linode
done

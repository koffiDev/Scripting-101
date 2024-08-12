#!/bin/bash

# Get a list of region IDs
regions=$(linode-cli regions list --json | jq -r '.[].id')

# Define the parameters for the new Linode
TYPE="g6-nanode-1"  # Adjust as needed
IMAGE="linode/debian11"
LABEL="test-linode"
ROOT_PASS="veryStrongPassWord"

# Loop through each region and create a Linode
for region in $regions; do
  linode-cli linodes create --type $TYPE --image $IMAGE --region $region --label "${LABEL}-${region}" --root_pass $ROOT_PASS
done


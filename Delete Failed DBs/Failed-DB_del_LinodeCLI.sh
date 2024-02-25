#!/bin/bash

# List all PostgreSQL databases
databases=$(linode-cli databases postgresql-list --json)

# Iterate over each database and check if its status is "failed"
for row in $(echo "${databases}" | jq -c '.[]'); do
    database_name=$(echo "${row}" | jq -r '.label')
    database_id=$(echo "${row}" | jq -r '.id')
    database_status=$(echo "${row}" | jq -r '.status')

    if [ "${database_status}" = "failed" ]; then
        echo "Deleting database with ID: ${database_name}"
        linode-cli databases postgresql-delete "${database_id}"
    fi
done


#!/bin/bash

# Function to delete PostgreSQL database
delete_postgresql() {
    local db_id=$1
    local db_name=$2
    echo "Deleting PostgreSQL database: ${db_name}"
    linode-cli databases postgresql-delete "${db_id}"
}

# Function to delete MySQL database
delete_mysql() {
    local db_id=$1
    local db_name=$2
    echo "Deleting MySQL database: ${db_name}"
    linode-cli databases mysql-delete "${db_id}"
}

# List all databases
databases=$(linode-cli databases list --json)

# Iterate over each database and delete it
for row in $(echo "${databases}" | jq -c '.[]'); do
    db_id=$(echo "${row}" | jq -r '.id')
    db_name=$(echo "${row}" | jq -r '.label')
    db_engine=$(echo "${row}" | jq -r '.engine')
    
    if [ "${db_engine}" = "postgresql" ]; then
        delete_postgresql "${db_id}" "${db_name}"
    elif [ "${db_engine}" = "mysql" ]; then
        delete_mysql "${db_id}" "${db_name}"
    else
        echo "Unsupported database engine: ${db_engine}. Skipping deletion for database ${db_name}."
    fi
done


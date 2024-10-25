#!/bin/bash

# Check if at least two arguments are provided
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <template file> key1=value1 key2=value2 ..."
    exit 1
fi

TEMPLATE_FILE=$1
shift

TEMPLATE_CONTENT=$(cat "$TEMPLATE_FILE")

for arg in "$@"; do
    key=$(echo "$arg" | cut -d '=' -f 1)
    value=$(echo "$arg" | cut -d '=' -f 2)
    TEMPLATE_CONTENT=$(echo "$TEMPLATE_CONTENT" | sed "s/{{${key}}}/${value}/g")
done
#(trainer.template fname=sandeep topic=linux)
# Output the processed template
echo "$TEMPLATE_CONTENT"


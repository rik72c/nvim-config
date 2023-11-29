#!/bin/bash

# Assign the first argument to CONTAINER_ID
CONTAINER_ID=$1

# The PHP testing command/script
PHP_TESTER_COMMAND=$2

# Optional filter value for the PHP tester
FILTER_VALUE=$3

# Check if a filter value is provided and append it to the command if it is
if [ ! -z "$FILTER_VALUE" ]; then
    COMMAND="$PHP_TESTER_COMMAND --filter=$FILTER_VALUE"
else
    COMMAND="$PHP_TESTER_COMMAND"
fi

# Run the PHP tests inside the Docker container
# Check if we are in a TTY environment
if [ -t 1 ]; then
    docker exec -it $CONTAINER_ID $COMMAND
else
    docker exec $CONTAINER_ID $COMMAND
fi


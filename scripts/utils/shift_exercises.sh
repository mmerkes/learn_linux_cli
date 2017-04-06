#!/bin/bash

# The purpose of this scripts is to shift exercises up or down to make
# room to insert exercises in between. It shifts it be reading from entire
# contents directories and shifting all files found.

# Use -gt 1 to consume two arguments per pass in the loop (e.g. each
# argument has a corresponding value to go with it).
while [[ $# -gt 1 ]]
do
key="$1"

case $key in
    -s|-start-index)
    START_INDEX="$2"
    shift # past argument
    ;;
    # The number of positions to move
    -p|--positions)
    POSITIONS="$2"
    shift # past argument
    ;;
    # The direction to shift content
    -d|--direction)
    DIRECTION="$2"
    shift # past argument
    ;;
    *)
         # unknown option
    ;;
esac
shift # past argument or value
done

# Load helper functions
. scripts/utils/helper_functions.sh

if [ -z "$START_INDEX" ] || [ -z "$POSITIONS" ];
then
    log_error "Must include a start index (-s, --start-index) and positions to move (-p, --positions)"
    exit 1
fi

shift_contents $START_INDEX $POSITIONS

#!/bin/bash

# The purpose of this script is to serve as a utility to move all of
# the content from a tutorial from one position to another without
# having to manually move everything around.

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
    -e|-end-index)
    END_INDEX="$2"
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

if [ -z "$START_INDEX" ] || [ -z "$END_INDEX" ];
then
    log_error "Must include a start index (-s, --start-index) and an end index (-e, --end-index)"
    exit 1
fi

move_exercise $START_INDEX $END_INDEX

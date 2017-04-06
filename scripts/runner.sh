#! /bin/bash

. scripts/utils/helper_functions.sh

function log_tutorial() {
    validation_script="$1"
}

# Folder that should include project folder
DIRECTORY=$HOME/learn_linux
TUTORIAL_PATH="tutorials/"

export DIRECTORY

BASH=/bin/bash

# Start validating user's setup
log_newline
total_challenges="$(ls -1q scripts/validation/*.sh | wc -l | sed -e 's/[[:blank:]]//g')"
successful_steps=0
failed_validation_script=""
for script in scripts/validation/*.sh
do
    if $BASH $script ; then
        successful_steps=$((successful_steps + 1))
    else
        failed_validation_script=$(basename $script)
        break
    fi
done
# $BASH scripts/validation/0001_create_directory.sh

log_newline
log_line
completion_text="Successfully completed ${successful_steps} of ${total_challenges} challenges."
if [ "$successful_steps" == "$total_challenges" ]; then
    log_success "$completion_text"
else
    log_error "$completion_text"
fi
log_line

if [ "$failed_validation_script" != "" ]; then
    log_newline
    echo "NEXT CHALLENGE"
    log_newline
    tutorial="${TUTORIAL_PATH}${failed_validation_script}"
    tutorial="${tutorial/\.sh/.txt}"
    cat $tutorial
    log_newline
fi

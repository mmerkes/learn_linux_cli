#! /bin/bash

# START Logging functions
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

log_success() {
    prompt="$1"
    printf "${GREEN}$prompt${NC}\n"
}

log_error() {
    prompt="$1"
    printf "${RED}$prompt${NC}\n"
}

log_line() {
    printf '%50s\n' | tr ' ' -
}

log_newline() {
    printf "\n"
}

export GREEN
export RED
export NC
export -f log_success
export -f log_error
export -f log_line
export -f log_newline
# END Logging functions

# START filename functions
# echo the filename prefix. i.e. If you pass in "1" as the argument
# you'll get "0001" back.
echo_filename_prefix() {
    local prefix=$(printf "%04d\n" $1)
    echo $prefix
}

# END filename functions

# START Admin Utilities
validation_dir="scripts/validation"
content_directories=($validation_dir "tutorials")

shift_contents() {
    local start_index=$1
    local positions=$2

    local files=(${validation_dir}/*)    
    #for f in $files; do
    local i
    for ((i=${#files[@]}-1; i>=0; i--)); do
        local f="${files[$i]}"
        local old_index=$(echo $f | tr -dc '0-9' | sed -e 's/^0*//')

        if [ "$old_index" -lt "$start_index" ]
        then
            # Only start when we're at the start index
            continue
        fi
        local new_index=$((old_index + positions))

        move_exercise $old_index $new_index
    done
}

move_exercise() {
    if [ -z "$1" ] || [ -z "$2" ];
    then
        log_error "Must pass in two arguments: start index and end index"
        exit 1
    fi

    local start_index=$1
    local end_index=$2
    local start_prefix=$(echo_filename_prefix $start_index)
    local end_prefix=$(echo_filename_prefix $end_index)
    local i

    for i in ${content_directories[@]}; do
        start_file_glob="${i}/${start_prefix}*"

        for f in $start_file_glob; do
            ## Check if the glob gets expanded to existing files.
            ## If not, f here will be exactly the pattern above
            ## and the exists test will evaluate to false.
            if [ -e $f ]
            then
                start_filename=$f
            else
                log_error "No content found with index ${start_index}"
                exit 1
            fi
            ## This is all we needed to know, so we can break after the first iteration
            break
        done

        end_file_glob="${i}/${end_prefix}*"

        if [ -e $end_file_glob ]
        then
            log_error "Content was already found for end index ${end_index}: ${end_file_glob}"
            exit 1
        fi

        # Generate the new file name
        new_filename="${start_filename/$start_prefix/$end_prefix}"

        mv $start_filename $new_filename
    done

    return
}
# END Admin Utilities

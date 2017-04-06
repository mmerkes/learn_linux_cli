MESSAGE="I can create a deep directory and its parents"

DEEP_DIRECTORY="${DIRECTORY}/challenges/scripts"

if [ ! -d "$DEEP_DIRECTORY" ]; then
    log_error "${MESSAGE}"
    exit 1
else
    log_success "${MESSAGE}"
    exit 0
fi

MESSAGE="I can create a directory"

if [ ! -d "$DIRECTORY" ]; then
    log_error "${MESSAGE}"
    exit 1
else
    log_success "${MESSAGE}"
    exit 0
fi

MESSAGE="I can create an empty file."

empty_file="${DIRECTORY}/challenges/empty.txt"

if [ -e $empty_file ]
then
    log_success "${MESSAGE}"
    exit 0
else
    log_error "${MESSAGE}"
    exit 1
fi

#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
GREY='\033[1;30m'
NC='\033[0m' # No Color

exit_code=0

exitScript() {
    logDebug "Exiting with code: $exit_code" "\n >>> "
    exit ${exit_code}
}

logError() {
    logWithColor "${RED}" "${NC}" "$1" "$2 "
    if [[ ! -z $1 ]]; then
        ((exit_code++))
    fi
}

logSuccess() {
    logWithColor "${GREEN}" "${NC}" "$1" "$2"
}

logInfo() {
    logWithColor "${NC}" "${NC}" "$1" "$2"
}

logDebug() {
    logWithColor "${GREY}" "${NC}" "$1" "$2"
}


logWithColor() {
    while read -r line; do
        if [[ ! -z ${line} ]]; then
            echo -e "$1$4$line$2"
        fi
    done <<< "$3"
}

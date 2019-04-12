#!/bin/bash

#########################
# Do stuff as root here #
#########################

# Set default DEVELOPER_USERID if not exist
: ${DEVELOPER_USERID:=1000}
: ${DEVELOPER_GROUPID:=1000}

usermod -u $DEVELOPER_USERID developer &> /dev/null
groupmod -g $DEVELOPER_GROUPID developer &> /dev/null

XDG_RUNTIME_DIR="/run/user/$(id -u developer)"
export XDG_RUNTIME_DIR
install -d -o developer -g developer -m 0700 /run/user/"$(id -u developer)"

##############################################
# Now run everything else as a non-root user #
##############################################

# Replace new child process (CMD) with parents process and take over its PID
exec su-exec developer:developer "${@}"

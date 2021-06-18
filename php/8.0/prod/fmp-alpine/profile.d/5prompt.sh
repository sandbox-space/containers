#!/bin/sh
NORMAL="\[\e[0m\]"
RED="\[\e[1;31m\]"
GREEN="\[\e[1;32m\]"
if [ "$USER" = root ]; then
    PS1="$RED\u@\h [$NORMAL\w$RED]# $NORMAL"
else
    PS1="$GREEN\u@\h [$NORMAL\w$GREEN]\$ $NORMAL"
fi

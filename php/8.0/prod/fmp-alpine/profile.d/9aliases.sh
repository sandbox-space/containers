#!/bin/sh
alias ll='ls -la'

alias project-root="cd $APP_ROOT"
alias project-log="cd $APP_LOG"
alias project-tmp="cd $APP_TMP"

alias project-console="$APP_ROOT/bin/console $@"
alias project-console-debug="XDEBUG_CONFIG='idekey=PHPSTORM' PHP_IDE_CONFIG='serverName=project-console' project-console $@"
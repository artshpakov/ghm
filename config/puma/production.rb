#!/usr/bin/env puma
environment 'production'
stdout_redirect "/var/www/ghm/shared/log/stdout", "/var/www/ghm/shared/log/stderr"

threads 2, 8
workers 2
pidfile "/var/www/ghm/shared/tmp/pids/puma.pid"
bind "unix:///var/www/ghm/shared/tmp/sockets/puma.sock"

daemonize true

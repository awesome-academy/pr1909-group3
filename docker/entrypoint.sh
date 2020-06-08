#!/bin/bash
set -e
rm -f /project2/tmp/pids/server.pid
exec "$@"

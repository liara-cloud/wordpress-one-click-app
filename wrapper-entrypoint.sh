#!/bin/bash

set -e

echo 'Configuring php.ini ...'
echo "$PHP_INI_CONFIG" > $PHP_INI_DIR/conf.d/liara_php.ini # TODO: Test me.

echo '[APACHE] Starting...'
exec "/usr/local/bin/docker-entrypoint.sh" "apache2-foreground"

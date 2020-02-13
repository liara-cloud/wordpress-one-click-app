#!/bin/bash

set -m

echo 'Configuring php.ini ...'
echo $PHP_INI_CONFIG > /usr/local/etc/php/conf.d/liara_php.ini

/usr/local/bin/docker-entrypoint.sh apache2-foreground

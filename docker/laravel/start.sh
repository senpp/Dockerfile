#!/bin/bash

# Set the desired timezone
echo date.timezone=Asia/Ho_Chi_Minh > /usr/local/etc/php/conf.d/timezone.ini

# Start supervisord and services
exec /usr/bin/supervisord -n -c /etc/supervisord.conf

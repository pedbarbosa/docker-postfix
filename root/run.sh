#!/bin/sh

echo "Checking /config directory for contents ..."

# System aliases
if [[ -e /config/aliases ]]; then
    echo "Using new aliases config"
    cp /config/aliases /etc/aliases
    chmod 0644 /etc/aliases
fi

# Postfix configuration
if [[ -e /config/postfix/access ]]; then
    echo "Using new access config"
    cp /config/postfix/access /etc/postfix/access
else
    touch /etc/postfix/access
fi
if [[ -e /config/postfix/main.cf ]]; then
    echo "Using new main.cf config"
    cp /config/postfix/main.cf /etc/postfix/main.cf
fi
if [[ -e /config/postfix/master.cf ]]; then
    echo "Using new master.cf config"
    cp /config/postfix/master.cf /etc/postfix/master.cf
fi
if [[ -e /config/postfix/relay_domains ]]; then
    echo "Using new relay_domains config"
    cp /config/postfix/relay_domains /etc/postfix/relay_domains
fi
if [[ -e /config/postfix/sasl_passwd ]]; then
    echo "Using new sasl_passwd config"
    cp /config/postfix/sasl_passwd /etc/postfix/sasl_passwd
fi
if [[ -e /config/postfix/sender_access ]]; then
    echo "Using new sender_access config"
    cp /config/postfix/sender_access /etc/postfix/sender_access
else
    touch /etc/postfix/sender_access
fi
if [[ -e /config/postfix/virtual ]]; then
    echo "Using new virtual config"
    cp /config/postfix/virtual /etc/postfix/virtual
fi
chmod -R 0644 /etc/postfix

echo "Running postmap on postfix config files ..."
postmap /etc/postfix/access
postmap /etc/postfix/relay_domains
postmap /etc/postfix/sasl_passwd
postmap /etc/postfix/sender_access
postmap /etc/postfix/virtual
newaliases

echo "Starting supervisord ..."
exec supervisord

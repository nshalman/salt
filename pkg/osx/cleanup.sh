#!/bin/bash -x
launchctl unload /Library/LaunchDaemons/com.saltstack.salt.minion.plist
rm -rf /opt/salt /etc/salt /var/log/salt/minion
pkgutil --forget com.saltstack.salt
true

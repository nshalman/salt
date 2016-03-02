#!/bin/bash -x

[[ -z ${1} ]] && echo "Please provide name of salt master as an argument" && exit 1

THIS="$(cd $(dirname ${0}); pwd)/$(basename ${0})"

[[ $USER == root ]] || exec sudo -H ${THIS} "$@"

mkdir -p /etc/salt
echo "master: ${1}" > /etc/salt/minion

cd /
unzip -f "${THIS}"
sudo installer -pkg ./salt-*.pkg -target /
cp ./start-salt-minion.sh /opt/salt/bin/start-salt-minion.sh
sudo launchctl kickstart -k system/com.saltstack.salt.minion
exit $?

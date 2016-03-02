#!/bin/bash -x

MINION=/etc/salt/minion

update_master () {
	sed -e '/^master:/d' -i .bak ${MINION}
	echo "master: ${1}" >> ${MINION}
}


THIS="$(cd $(dirname ${0}); pwd)/$(basename ${0})"
unzip -u "${THIS}"

[[ $USER == root ]] || exec sudo -H ${THIS} "$@"

if grep -q "^master:" ${MINION}
then
	echo "Found existing master name in ${MINION}"
	[[ ! -z ${1} ]] && echo "Updating ${MINION} with ${1} as new master" && update_master ${1}

else
	[[ -z ${1} ]] && echo "Please provide name of salt master as an argument" && exit 1
	mkdir -p /etc/salt
	touch ${MINION}
	update_master ${1}
fi

installer -pkg ./salt-*.pkg -target /
cp ./start-salt-minion.sh /opt/salt/bin/start-salt-minion.sh
chmod +x /opt/salt/bin/start-salt-minion.sh
[[ -z ${2} ]] && rm -f salt-*.pkg start-salt-minion.sh
sudo launchctl kickstart -k system/com.saltstack.salt.minion
exit 0

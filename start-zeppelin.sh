#!/bin/bash
cd /usr/local/zeppelin

echo "Filling Zeppelin configuration templates"

function replace_env_config {
  local conf_name=$1
  local envs_to_replace=$2
  if [ ! -r conf/$conf_name ]; then
    echo "$conf_name does not exist, creating it"
    envsubst $envs_to_replace < conf.templates/$conf_name.template > conf/$conf_name
  else
    echo "$conf_name already exists, not overwriting"
  fi
}

replace_env_config interpreter.json
replace_env_config zeppelin-env.sh
replace_env_config zeppelin-site.xml
replace_env_config shiro.ini '$ZEPPELIN_PASSWORD'
replace_env_config interpreter-list
replace_env_config log4j.properties

# add zeppelin group if not exists
if getent group $ZEPPELIN_PROCESS_GROUP_NAME; then
  echo "Group $ZEPPELIN_PROCESS_GROUP_NAME already exists"
else
  echo "Group $ZEPPELIN_PROCESS_GROUP_NAME does not exist, creating it with gid=$ZEPPELIN_PROCESS_GROUP_ID"
  addgroup --force-badname -gid $ZEPPELIN_PROCESS_GROUP_ID $ZEPPELIN_PROCESS_GROUP_NAME
fi

# add zeppelin user if not exists
if id -u $ZEPPELIN_PROCESS_USER_NAME 2>/dev/null; then
  echo "User $ZEPPELIN_PROCESS_USER_NAME already exists"
else
  echo "User $ZEPPELIN_PROCESS_USER_NAME does not exist, creating it with uid=$ZEPPELIN_PROCESS_USER_ID"
  adduser --force-badname $ZEPPELIN_PROCESS_USER_NAME --uid $ZEPPELIN_PROCESS_USER_ID --gecos "" --ingroup $ZEPPELIN_PROCESS_GROUP_NAME --disabled-login --disabled-password
fi 

# adjust ownership of the zeppelin folder
chown -R $ZEPPELIN_PROCESS_USER_NAME ../zeppelin
chgrp -R $ZEPPELIN_PROCESS_GROUP_NAME ../zeppelin
chown -R $ZEPPELIN_PROCESS_USER_NAME /user
chgrp -R $ZEPPELIN_PROCESS_GROUP_NAME /user

exec sudo -u $ZEPPELIN_PROCESS_USER_NAME bin/zeppelin.sh

#!/bin/bash

if [ ! -f /config-stat.txt ]; then
  STAT=$(stat -t /envs)
  echo ${STAT} > /config-stat.txt
  FIRST_RUN="yes"
fi

OLD_STAT=$(cat /config-stat.txt)
NEW_STAT=$(stat -t /envs)

if [ "${OLD_STAT}" != "${NEW_STAT}" ] || [ "${FIRST_RUN}" == "yes" ]; then
  echo ${NEW_STAT} > /config-stat.txt
  ALL_FILES=""

  if [ -f /settings.scsv ]; then
    rm /settings.scsv
  fi

  for config in envs/*.env; do
    set -a
    source ${config}
    set +a
    name=$(grep MOODLE_SQL_CONFIG ${config} | cut -f 1 -d '=' | sed 's/_MOODLE_SQL_CONFIG//g')
    filevar=${name}_MOODLE_SQL_CONFIG
    for file in ${!filevar}; do
      file=$(echo -n ${file} | tr -d '\r')
      variables=$(echo -n \'; for variable in $(cat ${config} | cut -f 1 -d '='); do echo -n \$${variable}; done; echo -n \')
      template=$(echo -n ./config/template-${file} | tr -d '\r')
      output=$(echo -n ./config/${file} | tr -d '\r')
      cat ${template-config} | sed "s/^M//g" | tr -d '\r' | envsubst ${variables} > ${output}
      ALL_FILES="${ALL_FILES} ${output}"
    done
  done

  for file in ${ALL_FILES}; do
    cat ${file} | tr -d '\r' | mysql -u root -p${MYSQL_ROOT_PASSWORD} moodle
  done
fi

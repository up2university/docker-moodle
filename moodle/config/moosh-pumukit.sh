set -a
source /envs/pumukit*.env
set +a

/moosh/moosh.php -n config-set toolbar "$(echo -e ${PUMUKIT_EDITOR_ATTO_TOOLBAR})" editor_atto

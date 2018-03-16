set -a
source /envs/pumukit*.env
set +a

/moosh/moosh.php -n config-set toolbar "$(echo -e ${PUMUKIT_EDITOR_ATTO_TOOLBAR})" editor_atto
/moosh/moosh.php -n filter-set pumukit 1
/moosh/moosh.php -n filter-set pumukitpr 1

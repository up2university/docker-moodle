set -a
source /envs/theme_fordson*.env
set +a

/moosh/moosh.php -n config-set footnote "$(echo -e ${THEME_FORDSON_FOOTNOTE})" theme_fordson
/moosh/moosh.php -n config-set fptextbox "$(echo -e ${THEME_FORDSON_WELCOME_LOGGED_IN})" theme_fordson
/moosh/moosh.php -n config-set fptextboxlogout "$(echo -e ${THEME_FORDSON_WELCOME_NOT_LOGGED_IN})" theme_fordson 
/moosh/moosh.php -n config-set adddrawermenu "$(echo -e ${THEME_FORDSON_DRAWER_MENU})" theme_fordson

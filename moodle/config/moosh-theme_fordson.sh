cp ../../../envs/*.png ../../../envs/*.jpg /
chown www-data:www-data /*.png /*.jpg

if [ -f /moosh-theme_fordson-files.sh ]; then
    rm /moosh-theme_fordson-files.sh
fi

set -a
source /envs/theme_fordson*.env
set +a

for mod in ${THEME_FORDSON_HIDE_MODS}; do 
    /moosh/moosh.php -n module-manage hide ${mod}
done

for mod in ${THEME_FORDSON_SHOW_MODS}; do 
    /moosh/moosh.php -n module-manage show ${mod}
done

for variable in $(grep 'png\|jpg' ../../../envs/theme_fordson.env | cut -f 1 -d '=') ; do
    set -a
    filename=$(grep ${variable}= ../../../envs/theme_fordson.env | cut -f 2 -d '=' | sed 's%\\/%%g' | sed 's%\\\"%%g' | sed 's%/%%g')
    component=$(grep ${variable}} /config/template-theme_fordson-settings.scsv | cut -f 1 -d ';' | sed "s/'//g" | sed 's/^[[:space:]]*//g' | sed 's/[[:space:]]*$//g')
    filearea=$(grep ${variable}} /config/template-theme_fordson-settings.scsv | cut -f 2 -d ';' | sed "s/'//g" | sed 's/^[[:space:]]*//g' | sed 's/[[:space:]]*$//g')
    cat /config/template-moosh-theme_fordson-files.sh | envsubst '${filename},${component},${filearea}' >> /moosh-theme_fordson-files.sh
    set +a
done



chmod a+x /moosh-theme_fordson-files.sh
/moosh-theme_fordson-files.sh




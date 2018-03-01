cp ../../../envs/UP2U_Moodle_400x200.png /
cp ../../../envs/Moodle_Header_1500x600.jpg /
chown www-data:www-data /UP2U_Moodle_400x200.png /Moodle_Header_1500x600.jpg
if [ ! "$(/moosh/moosh.php -n file-list -i "filename='UP2U_Moodle_400x200.png' and filearea like 'logo%' and contextid=1")" = "" ]; then
    /moosh/moosh.php -n file-list -i "filename='UP2U_Moodle_400x200.png' and filearea like 'logo%' and contextid=1" | /moosh/moosh.php -n file-delete -s
fi

if [ ! "$(/moosh/moosh.php -n file-list -i "filename='Moodle_Header_1500x600.jpg' and filearea='headerdefaultimage' and contextid=1")" = "" ]; then
    /moosh/moosh.php -n file-list -i "filename='Moodle_Header_1500x600.jpg' and filearea='headerdefaultimage' and contextid=1" | /moosh/moosh.php -n file-delete -s
fi
/moosh/moosh.php -n file-delete --flush
/moosh/moosh.php -n file-upload --contextid=1 --component='core_admin' --filearea='logo' --filepath=/ ../../../UP2U_Moodle_400x200.png
/moosh/moosh.php -n file-upload --contextid=1 --component='theme_fordson' --filearea='headerdefaultimage' --filepath=/ ../../../Moodle_Header_1500x600.jpg

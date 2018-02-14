cp ../../../envs/UP2U_Moodle_400x200.png /
cp ../../../envs/Moodle_Header_1500x600.jpg /
chown www-data:www-data /UP2U_Moodle_400x200.png /Moodle_Header_1500x600.jpg
/moosh/moosh.php -n file-list -i "filename='Moodle_Header_1500x600.jpg' and filearea='headerdefaultimage' and contextid=1" | /moosh/moosh.php -n file-delete -s
/moosh/moosh.php -n file-list -i "filename='UP2U_Moodle_400x200.png' and filearea like 'logo%' and contextid=1" | /moosh/moosh.php -n file-delete -s
/moosh/moosh.php -n file-delete --flush
/moosh/moosh.php -n file-upload --contextid=1 --component='core_admin' --filearea='logo' --filepath=/ ../../../UP2U_Moodle_400x200.png
/moosh/moosh.php -n file-upload --contextid=1 --component='core_admin' --filearea='logocompact' --filepath=/ ../../../UP2U_Moodle_400x200.png

fileids=$(/moosh/moosh.php -n file-list -i "filename='${filename}' and filearea='${filearea}' and component='${component}' and contextid=1")
if [ ! "${fileids}" = "" ]; then
    echo ${fileids} | /moosh/moosh.php -n file-delete -s
fi
/moosh/moosh.php -n file-delete --flush
/moosh/moosh.php -n file-upload --contextid=1 --component='${component}' --filearea='${filearea}' --filepath=/ ../../../${filename}

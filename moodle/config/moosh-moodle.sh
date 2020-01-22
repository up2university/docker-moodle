set -a
source /envs/moodle*.env
set +a

/moosh/moosh.php -n role-create -d "Editing Student" -a student -n "Editing Student" editingstudent

if [ ! -d /var/moodledata/lang ]; then
    mkdir /var/moodledata/lang
    chown www-data:www-data /var/moodledata/lang
fi

pushd /var/moodledata/lang
for lang in $(echo ${MOODLE_LANGUAGE_PACKS} | sed 's/,/ /g'); do
    if [ ! -d /var/moodledata/lang/${lang} ]; then
        curl https://download.moodle.org/download.php/direct/langpack/3.3/${lang}.zip -O
        unzip ${lang}.zip
        rm ${lang}.zip
    fi
done
popd

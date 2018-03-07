set -a
source /envs/moodle*.env
set +a

if [ ! -d /var/moodledata/lang ]; then
    mkdir /var/moodledata/lang
    chown www-data:www-data /var/moodledata/lang
fi

pushd /var/moodledata/lang
for lang in $(echo ${MOODLE_LANGUAGE_PACKS} | sed 's/,/ /g'); do
    curl https://download.moodle.org/download.php/direct/langpack/3.3/${lang}.zip -o ${lang}.zip
    unzip ${lang}.zip
    rm ${lang}.zip
done
popd

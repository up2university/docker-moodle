/moosh/moosh.php -n auth-manage enable saml2
/moosh/moosh.php -n auth-manage up saml2
if [ ! -d /var/moodledata/saml2 ]; then
    mkdir /var/moodledata/saml2
fi

if [ ! -f /var/moodledata/saml2/${EMAIL_DOMAIN}.crt ]; then
    /usr/bin/php admin/cli/cfg.php --name=siteidentifier > /moodle-site-id.txt 
    set -a
    source /envs/common.env
    source /envs/auth_saml2*.env
    set +a
    /usr/bin/openssl req -newkey ${SSO_SSL_KEY_ALGO}:${SSO_SSL_KEY_LENGTH} -new -x509 -days ${SSO_SSL_CERT_EXPIRY} -nodes -out /var/moodledata/saml2/${EMAIL_DOMAIN}.crt -keyout /var/moodledata/saml2/${EMAIL_DOMAIN}.pem -subj "/C=${SSO_SSL_COUNTRY_NAME}/ST=${SSO_SSL_STATE_OR_PROVINCE}/L=${SSO_SSL_LOCALITY}/O=${SSO_SSL_ORGANISATION_NAME}/CN=${SSO_SSL_COMMON_NAME}/emailAddress=${SSO_SSL_EMAIL_ADDRESS}" -passin file:/moodle-site-id.txt
    rm /moodle-site-id.txt
    /usr/bin/curl ${CURL_OPTS} ${UNQUOTED_WWWROOT}/auth/saml2/sp/metadata.php -o /var/moodledata/saml2/${EMAIL_DOMAIN}.xml
fi

if [ ! -f /var/moodledata/saml2/idp.xml ]; then
    set -a
    source /envs/common.env
    source /envs/auth_saml2*.env
    set +a
    /usr/bin/curl $(echo ${SSO_METADATA_URL} | xargs) -o /var/moodledata/saml2/idp.xml
fi

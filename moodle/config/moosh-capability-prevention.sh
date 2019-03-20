#!/bin/bash

IFS=' ' read -a StringArray <<< "${PREVENT_CAPABILITY_LIST}"

pushd /var/www/html

# Iterate the string array using for loop
for val in ${StringArray[@]}; do
   for ((i=1;i<=10;i++));
     do
       echo "/moosh/moosh.php -n role-update-capability -i $i $val prevent 1"
        /moosh/moosh.php -n role-update-capability -i $i $val prevent 1
   done
done

popd

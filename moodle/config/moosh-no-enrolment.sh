#!/bin/bash

# Declare an array of string with type
declare -a StringArray=("enrol/manual:enrol" "enrol/manual:manage" "enrol/manual:config")

pushd /var/www/html

# Iterate the string array using for loop
for val in ${StringArray[@]}; do
   for ((i=1;i<=10;i++));
     do
     moosh -n role-update-capability -i $i $val prevent 1
    done
done

popd

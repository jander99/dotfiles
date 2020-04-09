#!/bin/bash
# Fix certificate errors
# Modified from original by Austin J. Adams IV, Esq., 2018
# set -e

# Login as sudo if not already
if [ $EUID != 0 ]; then
    echo -e "\n*\n**\n***\n****\n*****\n******\n*******"
    echo "******** You need sudo privileges to modify the jvm certs, please login!!"
    sudo "$0" "$@"
    exit $?
fi

# -----------------------------------------------------------------------------------------------
# find any certificate you want to add to your local machine
mitm_cert=$(mktemp)
skope_cert=$(mktemp)
skope_inter_cert=$(mktemp)

echo -e "\n=========================\n"
echo "finding McAfee cert"
security find-certificate -c 'McAfee SSL Web Gateway' -p >"$mitm_cert" && echo "-done"
echo "finding Netskope Root cert"
security find-certificate -c 'caadmin.netskope.com' -p >"$skope_cert" && echo "-done"
echo "finding Netskope Intermediate cert"
security find-certificate -c 'ca.homedepot.goskope.com' -p >"$skope_inter_cert" && echo "-done"

# call this with the directory as the argument
function add_the_key {
    yes | keytool -keystore "$1/cacerts" -storepass changeit -importcert -file "$mitm_cert" -alias "MyMcAfee" 2> /dev/null | grep '^keytool'
    yes | keytool -keystore "$1/cacerts" -storepass changeit -importcert -file "$skope_cert" -alias "MyNetskope" 2> /dev/null | grep '^keytool'
    yes | keytool -keystore "$1/cacerts" -storepass changeit -importcert -file "$skope_inter_cert" -alias "MyInterNetskope" 2> /dev/null | grep '^keytool'
}

# read -p "Press any key to continue... " -n1 -s


# -----------------------------------------------------------------------------------------------
# Start adding to cacerts files

echo -e "\n=========================\n"
echo -e "\t----------------------"
echo "Adding certs to these IDE directories:"
for intellij_dir in ~/Library/Caches/*/tasks/; do
    echo -e "\t$intellij_dir"
    add_the_key $intellij_dir
    echo -e "\t----------------------"
done

jvm_found_dir=$(mktemp)
# Should pull the path out of the output from finding the JVMs
echo -e "\n=========================\n"
echo "Finding JVMs using a Mac command and installing certs there"
/usr/libexec/java_home -V 2>&1 >/dev/null | sed -e "s/^[^\/]*//" >> $jvm_found_dir  # -e "s,Home,Home\/jre\/lib\/security\/," 

echo -e "\t----------------------"
while read -r line || [[ -n "$line" ]]; do
    if [ -z "${line}" ]; then
        echo -e "\tEmpty line!!!"
    else
        echo -e "\tText read from file: $line"
        asdf=$( find $line -mindepth 1 -type d -regex '.*/lib/security/*' )
        # echo $asdf
        add_the_key $asdf
    fi
    echo -e "\t----------------------"
done < "$jvm_found_dir"

rm "$mitm_cert"
rm "$skope_cert"
rm "$skope_inter_cert"
rm "$jvm_found_dir"

cat <<'EOF'

===========================================================
.d8888. db    db  .o88b.  .o88b. d88888b .d8888. .d8888. db
88'  YP 88    88 d8P  Y8 d8P  Y8 88'     88'  YP 88'  YP 88
`8bo.   88    88 8P      8P      88ooooo `8bo.   `8bo.   YP
  `Y8b. 88    88 8b      8b      88~~~~~   `Y8b.   `Y8b.
db   8D 88b  d88 Y8b  d8 Y8b  d8 88.     db   8D db   8D db
`8888Y' ~Y8888P'  `Y88P'  `Y88P' Y88888P `8888Y' `8888Y' YP
===========================================================

EOF
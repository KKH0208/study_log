#!/bin/bash

while read user; do
    if [ -d "/home/${user}/backup" ]; then
        echo "${user} : exists"
    else
        echo "${user} : missing"
    fi

    
done < users.txt


#/bin/bash

if [ $# -ne 1 ] ; then
	echo "usage: gitcommit "message" "
	exit 1 
fi 

git add . 
git commit -m "$1"
git push 

echo "git completed"



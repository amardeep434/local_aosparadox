#!/bin/bash

# Variables
# $BRANCH the par branch
# $FOLDER the target folder
# $CAF_BRANCH the CAF branch
date=$(date +"%Y%m%d" )

function extract() {
    for FILE in `egrep -v '(^#|^$)' $1`; do
        OLDIFS=$IFS IFS=":" PARSING_ARRAY=($FILE) IFS=$OLDIFS
        FILE=`echo ${PARSING_ARRAY[0]} | sed -e "s/^-//g"`
        DEST=${PARSING_ARRAY[1]}
        if [ -z $DEST ]; then
            DEST=$FILE
        fi
	cd ~/WORK/YU_CAF/
	cd $FILE
	git fetch aosparadox $BRANCH
	git reset --hard aosparadox/$BRANCH
	git checkout -b tmp
	git branch -D $BRANCH
	git checkout -b $BRANCH
	git branch -D tmp
	cd ~/WORK/YU_CAF/
    done
}

extract $BRANCH-path-list

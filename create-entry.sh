#!/bin/bash

JEKYLL_ASSETS_DIR=$HOME'/Documents/portfolio/assets/'
JEKYLL_POSTS_DIR=$HOME'/Documents/portfolio/_posts/'

FOLDER_NAME='';
TITLE='';
DETAIL='';
DESCRIPTION='';
VID=false;
IMG=false;

while [ -n "$1" ]; do 

    case "$1" in 
    -from)
        dir="$2"
        echo "Copying files from ${dir} to ${JEKYLL_ASSETS_DIR}"
        cd ${JEKYLL_POSTS_DIR}
        FOLDER_NAME=${dir##*/}
        mkdir ${FOLDER_NAME}
        cp -rf ${dir} ${JEKYLL_ASSETS_DIR}
        
        shift
        
        ;;
    -title)
        TITLE="$2"
        shift
        
        ;;
    -detail)
        DETAIL="$2"
        shift

        ;;
    -description)
       DESCRIPTION="$2"
       shift

        ;;
    --img)
        IMG=true;

        ;;

    --vid)
       VID=true;

       ;;
    *) echo "Not valid option"
      break
        ;;
    esac

    shift
done

TITLE_STRIPPED=${TITLE// /_}
DATE=`date +%Y-%m-%d`
TYPE='.md'
OUTPUT_FILE=${DATE}-${TITLE_STRIPPED}${TYPE}


cd ${JEKYLL_POSTS_DIR}
touch ${OUTPUT_FILE}

echo "Created ${OUTPUT_FILE} in ${JEKYLL_POSTS_DIR}"

echo -n "---
layout: post
title: ${TITLE}
detail: ${DETAIL}
description: ${DESCRIPTION}" >> ${OUTPUT_FILE}

if $IMG; then
    echo -n "
photos:" >> ${OUTPUT_FILE}

    for file in "${JEKYLL_ASSETS_DIR}${FOLDER_NAME}"/*; do
        f=$(echo "${file##*/}");
        extension=$(echo $f| cut  -d'.' -f 2); 
        filename=$(echo $f| cut  -d'.' -f 1);

    if [[ $extension =~ ^(jpg|jpeg|png|gif)$ ]];then
      echo -n "
    "${TITLE}-${filename}": "assets/${FOLDER_NAME}/${f}"" >> ${OUTPUT_FILE}
    fi
done
fi



if $VID; then
    echo -n "
videos:" >> ${OUTPUT_FILE}

    for file in "${JEKYLL_ASSETS_DIR}${FOLDER_NAME}"/*; do
        f=$(echo "${file##*/}");
        extension=$(echo $f| cut  -d'.' -f 2); 
        filename=$(echo $f| cut  -d'.' -f 1);
   
    if [[ $extension =~ ^(mkv|mp4)$ ]];then
      echo -n "
    "${TITLE}-${filename}": "assets/${FOLDER_NAME}/${f}"" >> ${OUTPUT_FILE}

    fi
done
fi

echo -e "
---
" >> ${OUTPUT_FILE}

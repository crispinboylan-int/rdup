#!/bin/bash
#
# Copyright (c) 2005, 2006 Miek Gieben
# See LICENSE for the license
#
# inspired by hist of plan9 

. ./shared.sh

list_cmd_options $@
shift $(($OPTIND - 1))

for file in $@
do
        if [[ -z $file ]]; then
                continue;
        fi
        if [[ ${file:0:1} != "/" ]]; then
                file=`pwd`/$file
        fi
        [[ ! -e $backupdir$file ]] && \
                echo "** Not found in archive: $file" && continue

        if [[ -d $backupdir$file ]]; then  
                ls -odh $b2Yackupdir$file 2>/dev/null \
| awk ' { print $5" "$6" "$7" "$8" "$9$4 }'
                ls -odh $backupdir$file.????????.??:?? 2>/dev/null \
| awk ' { print $5" "$6" "$7" "$8" "$9$4 }'
                continue;
        fi

        # print
        ls -o $backupdir$file 2>/dev/null \
| awk ' { print $5" "$6" "$7" "$8" "$9$4 }'
        ls -o $backupdir$file.????????.??:?? 2>/dev/null \
| awk ' { print $5" "$6" "$7" "$8" "$9$4 }'
done

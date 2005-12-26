#!/bin/bash
#
# Copyright (c) 2005, 2006 Miek Gieben
# See LICENSE for the license
#
# inspired by yesterday of plan9

. ./shared.sh

list_cmd_options $@
shift $(($OPTIND - 1))

for file in $@
do
        if [[ -z $file ]]; then
                continue
        fi
        if [[ ${file:0:1} != "/" ]]; then
                file=`pwd`/$file
        fi
        [ ! -e $backupdir$file ] && \
                echo "** Not found in archive: $file" && continue

        # print
        if [[ $copy -eq 1 ]]; then
                cp -a $backupdir$file $file
                continue
        fi
        if [[ $Ccopy -eq 1 ]]; then
                cmp $backupdir$file $file > /dev/null
                if [[ $? ]]; then
                        cp -a $backupdir$file $file
                fi
                continue
        fi
        if [[ $diff -eq 1 ]]; then
                echo diff -u `basename $backupdir$file` `basename $file`
                [ -f $backupdir$file ] && diff -u $backupdir$file $file
                [ -h $backupdir$file ] && diff -u $backupdir$file $file
                continue
        fi

        echo $backupdir$file
done

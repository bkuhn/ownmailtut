#!/bin/bash

set -e

for type in Ham Spam;
do
    typeLower=`echo $type | perl -pe '$_ = "\l$_\E";'`
    old=${HOME}/Mail/.Old$type
    for subdir in cur new; do
       folder=${HOME}/Mail/.TrainAs$type
       if [ -d $folder/$subdir ]; then
           echo "Training $type that you left in TrainAs$type ($subdir):  "
           sa-learn --no-sync --$typeLower $folder/$subdir
           if [ ! -d $old ]; then
               mkdir -p $old/{cur,new,tmp}
            fi
            cnt=`/bin/ls -1 $folder/$subdir/| wc -l`
            if [ $cnt -gt 0 ]; then
               mv -f $folder/$subdir/* $old/cur/
               echo "Moved $cnt emails from TrainAs$type to the Old$type folder."
            fi
       fi
    done
    echo -e "\n"
done

sa-learn --sync

echo -e "\nYour spam database has been syncronized."

echo "Training Complete."

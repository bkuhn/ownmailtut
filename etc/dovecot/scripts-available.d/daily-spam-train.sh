#!/bin/bash

    
export PATH=/bin:/usr/bin:/sbin:/usr/sbin
set -e

if [ -z "$USER" ]; then
    export USER=$LOGNAME
fi

if [ -z "$USER" ]; then
    echo "Unable to determine which user is running this script.  Aborting!"
    exit 1
fi

didAny=0

for type in Ham Spam;
do
    typeLower=`echo $type | perl -pe '$_ = "\l$_\E";'`
    finishedFolderName=Old$type
    finishedFolder=${HOME}/Mail/$finishedFolderName
    curFolderName=TrainAs$type
    curFolder=${HOME}/Mail/$curFolderName
    cnt=`doveadm mailbox status  -t messages ${curFolderName}|perl -pe 'die "failure to find message count in output of doveadmin mailbox status in \"$_\"" unless s/^\s*messages\s*=\s*(\d+)\s*$/$1/;'`
    if [ $cnt -gt 0 ]; then
        didAny=1
        echo "Training $cnt message(s) of $typeLower that you left in ${curFolderName}:  "
        for subdir in cur new; do
            if [ -d $folder/$subdir ]; then
                sa-learn --no-sync --$typeLower $curFolder/$subdir
            fi
        done
        # Next, the doveadm mailbox create command returns a
        # non-zero $?  if the folder exists already.
        doveadm mailbox create $finishedFolderName || true
        # Next, the doveadm mailbox status command should exit with
        # non-zero $?  if the mailbox doesn't exist at this point.
        # So, that's used to test if the create worked.
        doveadm mailbox status  -t messages $finishedFolderName > /dev/null
        doveadm move $finishedFolder mailbox $curFolder ALL
        echo "Moved $cnt emails from $curFolder to the $finishedFolder folder."
        echo -e "\n"
    fi
done

if [ $didAny -eq 1 ]; then
    sa-learn --sync
    echo -e "\nYour spam database has been syncronized."
    echo "Training Complete."
fi

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

myindent() { sed 's/^/     /'; }

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
            if [ -d $curFolder/$subdir ]; then
                sa-learn --no-sync --$typeLower $curFolder/$subdir | myindent
            fi
        done
        # Next, the doveadm mailbox create command.  It returns a
        # non-zero $?  if the folder exists already, so || true and then...
        doveadm mailbox create $finishedFolderName > /dev/null 2>&1 || true
        # ... do a test of the doveadm mailbox status command, which
        # should exit with non-zero $?  if the mailbox doesn't now
        # exist at this point.
        doveadm mailbox status  -t messages $finishedFolderName > /dev/null

        doveadm move $finishedFolderName mailbox $curFolderName ALL
        echo "Moved $cnt emails from the $curFolderName folder to the $finishedFolderName folder."|myindent
        echo -e "\n"
    fi
done

if [ $didAny -eq 1 ]; then
    echo -e "\nSynchronizing your spam database.... "
    sa-learn --sync | myindent
    echo "...and spam training for today is now complete."
fi

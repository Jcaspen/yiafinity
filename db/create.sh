#!/bin/sh

if [ "$1" = "travis" ]
then
    psql -U postgres -c "CREATE DATABASE yiafinity_test;"
    psql -U postgres -c "CREATE USER yiafinity PASSWORD 'yiafinity' SUPERUSER;"
else
    [ "$1" != "test" ] && sudo -u postgres dropdb --if-exists yiafinity
    [ "$1" != "test" ] && sudo -u postgres dropdb --if-exists yiafinity_test
    [ "$1" != "test" ] && sudo -u postgres dropuser --if-exists yiafinity
    sudo -u postgres psql -c "CREATE USER yiafinity PASSWORD 'yiafinity' SUPERUSER;"
    [ "$1" != "test" ] && sudo -u postgres createdb -O yiafinity yiafinity
    sudo -u postgres createdb -O yiafinity yiafinity_test
    LINE="localhost:5432:*:yiafinity:yiafinity"
    FILE=~/.pgpass
    if [ ! -f $FILE ]
    then
        touch $FILE
        chmod 600 $FILE
    fi
    if ! grep -qsF "$LINE" $FILE
    then
        echo "$LINE" >> $FILE
    fi
fi

#!/bin/sh

BASE_DIR=$(dirname $(readlink -f "$0"))
if [ "$1" != "test" ]
then
    psql -h localhost -U yiafinity -d yiafinity < $BASE_DIR/yiafinity.sql
fi
psql -h localhost -U yiafinity -d yiafinity_test < $BASE_DIR/yiafinity.sql

#!/bin/sh

echo "trying to build db script"
ls -l /db
if [ -f /db/build_db.py -a -f /db/db_config_schema.json -a -f /db/db_config.json ]; then
    python3 /db/build_db.py /db/db_config_schema.json /db/db_config.json
    echo "built db script"
else
    echo "Missing files to create script. The container will contue with running postgres."

    if [ ! -f /db/build_db.py ]; then
        echo "Missing /db/build_db.py"
    fi

    if [ ! -f /db/db_config_schema.json ]; then
        echo "Missing /db/db_config_schema.json"
    fi

    if [ ! -f /db/db_config.json ]; then
        echo "Missing /db/db_config.json"
    fi
fi

docker-entrypoint.sh postgres
#!/bin/sh
verbose='false'
start='true'
while getopts 'dv' flag; do
  case "${flag}" in
    d) start='false' ;;
    v) verbose='true' ;;
    *) start='true' ;;
  esac
done

CONFIG="$GHOST_INSTALL/config.production.json"
GHOST_VERSION=`cat $GHOST_INSTALL/version`

# Set Config
if [ -z "$WEB_URL" ]; then
	echo "WEB_URL is empty. Getting default: blog.mornati.net"
	WEB_URL=http://blog.mornati.net
fi
if [ -z "$DB_CLIENT" ]; then
        echo "DB_CLIENT is empty. Getting default: sqlite3"
        DB_CLIENT=sqlite3
fi
if [ -z "$DB_SQLITE_PATH" ]; then
        echo "DB_SQLITE_PATH is empty. Getting default: $GHOST_CONTENT/data/ghost-local.db"
        DB_SQLITE_PATH=$GHOST_CONTENT/data/ghost-local.db
fi
if [ -z "$SERVER_HOST" ]; then
        echo "SERVER_HOST is empty. Getting default: 0.0.0.0"
        SERVER_HOST=0.0.0.0
fi
if [ -z "$SERVER_PORT" ]; then
        echo "SERVER_PORT is empty. Getting default: 80"
        SERVER_PORT=2368
fi

echo "=> Change config based on ENV parameters:"
echo "========================================================================"
echo "      WEB_URL:        $WEB_URL"
echo "      DB_CLIENT:      $DB_CLIENT"
echo "      DB_SQLITE_PATH: $DB_SQLITE_PATH"
echo "      SERVER_HOST:    $SERVER_HOST"
echo "      SERVER_PORT:    $SERVER_PORT"
echo "      GHOST_CONTENT:  $GHOST_CONTENT"
echo "========================================================================"

sed -i "s|__WEB_URL__|$WEB_URL|g" $CONFIG
sed -i "s|__DB_CLIENT__|$DB_CLIENT|g" $CONFIG
sed -i "s|__DB_SQLITE_PATH__|$DB_SQLITE_PATH|g" $CONFIG
sed -i "s|__SERVER_HOST__|$SERVER_HOST|g" $CONFIG
sed -i "s|\"__SERVER_PORT__\"|$SERVER_PORT|g" $CONFIG
sed -i "s|__GHOST_CONTENT_PATH__|$GHOST_CONTENT|g" $CONFIG

if [[ $verbose == 'true' ]]; then
	cat $CONFIG
fi

if [ -z "$(ls -A "$GHOST_CONTENT")" ]; then
        echo "Missing content folder. Copying the default one..."
        cp -r $GHOST_INSTALL/content.bck/* $GHOST_CONTENT
fi

if [[ $start == 'true' ]]; then
	# Start Ghost with Ghost CLI
	# cd /ghost/blog && ghost run production
        # Start Ghost with NODE
        cd $GHOST_INSTALL && node versions/$GHOST_VERSION/index.js 
fi

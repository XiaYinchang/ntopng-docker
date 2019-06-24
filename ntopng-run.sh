#!/usr/bin/with-contenv sh
COMMAND="--community --disable-login=1"
if [[ ! -z "$INTERFACE_NAME" ]]; then COMMAND=$COMMAND" --interface="$INTERFACE_NAME; fi
if [[ ! -z "$DUMP_FLOW_BACKEND" ]]; then COMMAND=$COMMAND" --dump-flows="$DUMP_FLOW_BACKEND; fi

exec /usr/local/bin/ntopng $COMMAND

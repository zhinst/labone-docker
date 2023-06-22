#!/bin/bash
/labone/WebServer/ziWebServer $LABONE_WS_ARGS > /dev/null 2>&1 &
/labone/DataServer/ziDataServer $LABONE_DS_ARGS

#!/bin/bash
    export SERVER_HOSTNAME="${SERVER_HOSTNAME:-GOTV}"
    export SERVER_PASSWORD="${SERVER_PASSWORD:-changeme}"
    export RCON_PASSWORD="${RCON_PASSWORD:-changeme}"
    export GOTV_HOSTNAME="${GOTV_HOSTNAME:-GOTV}"
    export TF2_DIR="${TF2_DIR:-/$HOME/hlserver}"
    export IP="${IP:-0.0.0.0}"
    export PORT="${PORT:-27015}"
    export GOTV_PORT="${GOTV_PORT:-27020}"
    export TICKRATE="${TICKRATE:-64}"
    export MAP="${MAP:-pl_badwater}"
    export MAPCYCLE="${MAPCYCLE:-mapcycle_quickplay_payload.txt}"
    export MAXPLAYERS="${MAXPLAYERS:-12}"

: ${TF2_DIR:?"ERROR: TF2_DIR IS NOT SET!"}

cd $TF2_DIR

### Create dynamic server config
cat << SERVERCFG > $TF2_DIR/tf2/cfg/server.cfg
hostname "$SERVER_HOSTNAME"
rcon_password "$RCON_PASSWORD"
sv_password "$SERVER_PASSWORD"
tv_name "$GOTV_HOSTNAME"
sv_lan 0
sv_cheats 0
tv_advertise_watchable 1
log on
sv_logbans 1
sv_logecho 1
sv_logfile 1
sv_log_onefile 0
sv_hibernate_when_empty 1
host_name_store 1
host_info_show 1
host_players_show 2
exec banned_user.cfg
exec banned_ip.cfg
writeid
writeip
tv_enable "1"
SERVERCFG

./srcds_run \
    -console \
    -usercon \
    -game tf \
    -autoupdate \
    -autorestart \
    -steam_dir ~/hlserver \
    -steamcmd_script ~/hlserver/tf2_ds.txt \
    -tickrate $TICKRATE \
    -port $PORT \
    +tv_port $GOTV_PORT \
    -maxplayers_override $MAXPLAYERS \
    +mapcycle $MAPCYCLE \
    +map $MAP \
    +ip $IP \
    +tv_enable 1

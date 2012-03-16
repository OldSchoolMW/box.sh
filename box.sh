#!/bin/bash

INVOKED=$0
function error { echo $INVOKED: Oh darn, $* > /dev/stderr; exit 1; }

# Silly GNOME keyboard shortcuts not working with commandline args.
# So I will dissect $0 and if it is not just 'box.sh' then the part
#  following a hyphen will be BOXFILE, just add .cfg.

BOXFILE=$1.cfg

SUBSTR=${0#*box.sh-}
[ "$SUBSTR" != "$0" ] && BOXFILE=$SUBSTR.cfg

# So you can use either syntax (second requires create symlink).
# 1.) ~/x/box.sh mybox
# 2.) ~/x/box.sh-mybox

################### 


cd ~/x/box

[ -e $BOXFILE ] || error no such box $BOXFILE "($0 $*)"

BG=BLACK
FG=GREEN
FONT=10x20
TITLE="Box.sh / Untitled"
PROGRAM=ssh
PROGARGS=""

. $BOXFILE || error error reading about box

STR="xterm -bg '$BG' -fg '$FG' -title '$TITLE' -e $PROGRAM $TARGET $PROGARGS"

echo $STR
eval $STR


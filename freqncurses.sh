#!/bin/bash
# FreqnCurses - by Viktor Nova
# Console audio visualizer, compatible with MPD visualizers

# This is the filename of the temporary file that audio streams (temporarily records) to
FIFO="fakempd.fifo"

# This should probably be in some kind of ramdisk, or you might hurt your drive/card
FIFO_PATH="."

# Full path to the command that takes the audio you want to visualize and spits it out into a file
# e.g. jack-capture, arecord, ffmpeg, sox, vlc, etc
CAPTURE_COMMAND="arecord"
CAPTURE_OPTIONS="--rate=48000 -Dplug:default --disable-channels"
# --disable-resample

# Full path to the command that runs the visualizer
VISUALIZER="/usr/local/bin/nausea"
VISUALIZER_OPTIONS="-c"


# The thing -----------------------------------------------------------------------------------------
mkfifo $FIFO_PATH/$FIFO
$CAPTURE_COMMAND $CAPTURE_OPTIONS > $FIFO_PATH/$FIFO &
$VISUALIZER $VISUALIZER_OPTIONS $FIFO_PATH/$FIFO

rm $FIFO_PATH/$FIFO



# mkfifo fakempd.fifo
# arecord > fakempd.fifo &
# nausea -c fakempd.fifo







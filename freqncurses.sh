#!/bin/bash
# FreqnCurses - by Viktor Nova
# Console audio visualizer, compatible with MPD visualizers

# This is the filename of the temporary file that audio streams (temporarily records) to
FIFO="fakempd.fifo"

# This should probably be in some kind of ramdisk, or you might hurt your drive/card
FIFO_PATH="."

# Command that takes the audio you want to visualize and spits it out into a file
# e.g. jack-capture, arecord, ffmpeg, sox, vlc, etc
CAPTURE_COMMAND="arecord"

# Options for the capture command

# Note: you should make sure you are sampling audio at the soundcard's native sample rate,
# or you will get lots of noise in your visualizer and your device will hate you
# If you are using arecord, the option is "--rate=48000", or your samplerate.
# If you don't know your native samplerate, you can find out which ones your card supports by running:
# "arecord --disable-resample" and then quickly hitting Ctrl+C (there is probably a better way)
CAPTURE_OPTIONS=" --rate=48000 -Dplug:default --disable-resample"
# --disable-channels"

# Command that runs the visualizer
VISUALIZER="nausea"
VISUALIZER_OPTIONS="-c"


# The thing -----------------------------------------------------------------------------------------
mkfifo $FIFO_PATH/$FIFO
$CAPTURE_COMMAND $CAPTURE_OPTIONS > $FIFO_PATH/$FIFO &
$VISUALIZER $VISUALIZER_OPTIONS $FIFO_PATH/$FIFO

rm $FIFO_PATH/$FIFO


# To-do: put this file in ram and make a loop that zeroes out the fifo every so often so ram doesn't get 
# consumed by all the rock

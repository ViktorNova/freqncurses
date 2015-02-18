#!/bin/bash
# Freqshit - by Viktor Nova

# This uses mkfifo and arecord to fake an MPD stream fifo from an incoming audio source so we can use MPD's 
# visualizers to visualize real shit, yo

mkfifo fakempd.fifo
arecord > fakempd.fifo &
nausea -c fakempd.fifo

# I realized this is going to destroy your flash card, since it does actually write to the disk
# It should use a virtual filesystem, and Raspbian already has one you can write to without special permissions

# This works, and is almost perfect:

# mkfifo fakempd.fifo
# arecord > /run/shm/fakempd.fifo
# nausea -c /run/shm/fakempd.fifo

# The only problem is this starts to consume more and more memory, I guess the OS doesn't auto flush the fifo 
# like it does with regular filesystems.. weird.

# So a quick dumb hack would be to restart the script every 30 seconds or so.
# Actually, arecord is the only thing that needs to get restarted, nausea will just be a blank screen
# if no audio is being recorded to the fifo. 







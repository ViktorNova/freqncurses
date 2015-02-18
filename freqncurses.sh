#!/bin/bash
# FreqnCurses - by Viktor Nova

mkfifo fakempd.fifo
arecord > fakempd.fifo &
nausea -c fakempd.fifo







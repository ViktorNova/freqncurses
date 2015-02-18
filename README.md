# freqncurses
Visualize incoming audio on the console on a Raspberry pi

This uses mkfifo and arecord to fake an MPD stream fifo from an incoming audio source so we can use MPD's visualizers to visualize real shit, yo

You can use Nausea, or MPDViz, or anything else that uses MPD fifos for visualization, without installing the actual MPD, which is a beast

The provided script might actually be brutal on your flash card as is, since it does actually write to the disk nonstop..
It should really use a virtual filesystem in ram, and Raspbian already has one you can write to without special permissions. This works, and is almost perfect:

```
mkfifo fakempd.fifo
arecord > /run/shm/fakempd.fifo
nausea -c /run/shm/fakempd.fifo
```

The only problem is this starts to consume more and more memory, I guess the OS doesn't auto flush the fifo 
like it does with regular filesystems.. weird.

So a quick dumb hack would be to restart the script every minute or so, although for **sure** there is a better way to do it. Actually, arecord is the only thing that needs to get restarted, nausea will just be a blank screen if no audio is being recorded to the fifo.. more to come!

To do:    
Compile MPDViz on the Pi    
https://github.com/lucy/mpdviz

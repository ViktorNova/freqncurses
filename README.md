# freqncurses
Visualize incoming audio on the console on a Raspberry pi
![Nausea](http://i.imgur.com/IquogKO.png)

This uses mkfifo and arecord to fake an MPD stream fifo from an incoming audio source so we can use MPD's visualizers to visualize real shit, yo. Right now it is using Nausea, which is easy to compile on anything. There's a binary here for Debian Wheezy armhf, compiled on Raspbian, but you should use the @kiisu-dsalyss fork instead, especially if you plan to use this for a guitar pedal. He has done some interesting work to make it much better for that

###Console-based Visualizers
Recommended: Nausea (@kiisu-dsalyss fork)
https://github.com/kiisu-dsalyss/nausea

Nausea project (upstream)
http://git.2f30.org/nausea/

My fork of Nausea:    
https://github.com/ViktorNova/nausea

You can use Nausea, or MPDViz, or anything else that uses MPD fifos for visualization, without installing the actual MPD, which is a beast

This works, and is almost perfect:

```
mkfifo /run/shm/fakempd.fifo
arecord > /run/shm/fakempd.fifo &
nausea -c /run/shm/fakempd.fifo
```

>A FIFO special file (a named pipe) is similar to a pipe, except that it is accessed as part of the filesystem. [...] When processes are exchanging data via the FIFO, the kernel passes all data internally without writing it to the filesystem. Thus, the FIFO special file has no contents on the filesystem; the filesystem entry merely serves as a reference point so that processes can access the pipe using a name in the filesystem.

###Known issues
The only problem is this starts to consume more and more memory, I guess the OS doesn't auto flush the fifo 
like it does with regular filesystems.. weird.

So a quick dumb hack would be to restart the script every minute or so, although for **sure** there is a better way to do it. Actually, arecord is the only thing that needs to get restarted, nausea will just be a blank screen if no audio is being recorded to the fifo.. more to come!

To do:    
Compile MPDViz on the Pi and get it to actually work well
https://github.com/lucy/mpdviz

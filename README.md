# pepe-wurm
<code>tar -zpcvf memetrove.tar.gz payload</code> to make worm, send it to your friends (or don't, really)

# source
contains <code>runner.sh</code> and <code>mailcall.sh</code>. <code>runner.sh</code> looks through the image files in its same directory for executable code (marked by <code>STARTSCRIPT: </code> in <code>base64</code>) and executes it. <code>mailcall.sh</code> looks through the possible address books in the victim's home folder for email addresses and sends the malicious packet to all of them.

# payload
contains several instances of pepe the frog (which you should totally add to the collection of!). 
<code>pepe.jpg</code> has <code>mailcall.sh</code> in the end of it encoded as <code>base64</code>. 
<code>AakvuTLpAM4Q.gif.desktop</code> is a desktop file masquerading as <code>giphy-2.gif</code>

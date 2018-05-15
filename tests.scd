s.quit
s.boot
// allocates a 16-sample buffer and fills it with ascending values
b = Buffer.alloc(s,16);
b.setn(0, Array.series(16,1,1));

// read to check
b.getn(0,16, {|msg| msg.postln});

// apply gain
b.mul(-0.1)
// read to check (and appreciate the imprecision of 32bit float
b.getn(0,16, {|msg| msg.postln});

// apply reverse
b.reverse
// read to check
b.getn(0,16, {|msg| msg.postln});

// apply reverse
b.add(3.5)
// read to check
b.getn(0,16, {|msg| msg.postln});

////////////////////////////////////////////////////////////
// trying odd numbers of addresses, and odd number of samples
d = Buffer.alloc(s,15,3)
d.setn(0,Array.series(45,1,1))
d.getn(0,45, {|m| m.postln});

// reverse and observe the interleaved channels stay in line
d.reverse
d.getn(0,45, {|m| m.postln});

////////////////////////////////////////////////////////////
// trying audio

// load your favourite sound
b=Buffer.read(s,Platform.resourceDir +/+ "sounds/a11wlk01.wav")
// play it not too loud
b.play(true, 0.1)

// reverse it. there is a click when the buffer is updated
b.reverse

// stop
b.free

///////////////////////////////////////////////////////////
// adding dc offset

//load a file
b=Buffer.read(s,Platform.resourceDir +/+ "sounds/a11wlk01.wav")

// add DC for testing purpose
b.add(0.1)
// play and plot (nasty tick at the end)
b.play; b.plot

// remove DC
b.removeDC
// play and plot (nasty tick at the end)
b.play; b.plot

////////////////////////////////////////////////////////////
// chunk swapping
// allocates a 16-sample buffer and fills it with ascending values
b = Buffer.alloc(s,16);
b.setn(0, Array.series(16,0,1));

// read to check
b.getn(0,16, {|msg| msg.postln});

// apply chunkSwap method with default values (same as reverse)
b.chunkSwap

// read to check
b.getn(0,16, {|msg| msg.postln});

// apply on full range = changes nothing!
b.chunkSwap(0,b.numFrames-1,(b.numFrames * -1))

// read to check - tada!
b.getn(0,16, {|msg| msg.postln});

// reset to ascending values
b.setn(0, Array.series(16,0,1));

// apply with other values - indices are counting from 0
b.chunkSwap(3,7,3)

// read to check
b.getn(0,16, {|msg| msg.postln});

// reset to ascending values
b.setn(0, Array.series(16,0,1));

// apply with negative quantities (will read backwards and write frontwards)
b.chunkSwap(3,11,-3)

// read to check (and meditate on the result)
b.getn(0,16, {|msg| msg.postln});

// trying odd channel count.
c = Buffer.alloc(s,15,3)
c.setn(0,Array.series(45,0,1))
c.getn(0,45, {|m| m.postln});

// same as the mono example, respecting the interleaved channels
c.chunkSwap(3,7,3)
c.getn(0,45, {|m| m.postln});

// reset
c.setn(0,Array.series(45,0,1))

// same as the reverse mono example
c.chunkSwap(3,11,-3)
c.getn(0,45, {|m| m.postln});

////////////////////////////////////////////////////////////
// test in benchmarking
b=Buffer.read(s,Platform.resourceDir +/+ "sounds/a11wlk01.wav")
b.play(loop:true)

(
f = { |msg, time, replyAddr, recvPort|
	    if(msg[0] == '/done') {
		c = time;
    }
};
thisProcess.addOSCRecvFunc(f);
d = Main.elapsedTime;
100.do({b.reverse});
)

(
thisProcess.removeOSCRecvFunc(f);
(c-d);
)

////////////////////////////////////////////////////////////
//temp files version

(
d = Main.elapsedTime;
b.loadToFloatArray(action: {
	arg array;
	b.loadCollection(array.reverse, action:{c = Main.elapsedTime;});
});
)
(c-d);
////////////////////////////
// via osc (too slow for big file)
(
d = Main.elapsedTime;
b.getToFloatArray(action:{
	arg array;
	array.postln;
	b.sendCollection(array.reverse, action:{c = Main.elapsedTime;});
});
)
(c-d);
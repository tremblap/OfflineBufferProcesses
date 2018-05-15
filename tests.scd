s.quit
s.boot
// allocates a 16-sample buffer and fills it with ascending values
b = Buffer.alloc(s,16);
b.setn(0, Array.series(16,1,1));

// read to check
b.getn(0,16, {|msg| msg.postln});

// apply the NRT method
b.reverse
b.gain(0.1)
// read to check
b.getn(0,16, {|msg| msg.postln});

// flip again
b.reverse

// read to check
b.getn(0,16, {|msg| msg.postln});


////////////////////////////////////////////////////////////
// trying stereo
c = Buffer.alloc(s,16,2)
c.setn(0,Array.series(32,1,1))
c.getn(0,32, {|m| m.postln});
c.reverse
c.getn(0,32, {|m| m.postln});


////////////////////////////////////////////////////////////
// trying odd numbers
d = Buffer.alloc(s,15,3)
d.setn(0,Array.series(45,1,1))
d.getn(0,45, {|m| m.postln});
d.reverse
d.getn(0,45, {|m| m.postln});

////////////////////////////////////////////////////////////
// trying audio

b=Buffer.read(s,Platform.resourceDir +/+ "sounds/a11wlk01.wav")
b.play(true, 0.1)

b.reverse

////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
s.quit
s.boot
// allocates a 16-sample buffer and fills it with ascending values
b = Buffer.alloc(s,16);
b.setn(0, Array.series(16,0,1));

// read to check
b.getn(0,16, {|msg| msg.postln});

// apply the NRT method with default values
b.chunkSwap

// read to check
b.getn(0,16, {|msg| msg.postln});

// apply on full range = changes nothing!
b.chunkSwap(0,b.numFrames-1,(b.numFrames * -1))

// apply the NRT method with default values
b.chunkSwap(3,7,3)

// read to check
b.getn(0,16, {|msg| msg.postln});

// reset
b.setn(0, Array.series(16,0,1));

// read to check
b.getn(0,16, {|msg| msg.postln});

// apply
b.chunkSwap(3,11,-3)

// read to check
b.getn(0,16, {|msg| msg.postln});

////////////////////////////////////////////////////////////
// trying 3 channels
c = Buffer.alloc(s,15,3)
c.setn(0,Array.series(45,0,1))
c.getn(0,45, {|m| m.postln});
c.chunkSwap
c.getn(0,45, {|m| m.postln});

c.setn(0,Array.series(45,0,1))
c.getn(0,45, {|m| m.postln});
c.chunkSwap(3,7,3)
c.getn(0,45, {|m| m.postln});

c.setn(0,Array.series(45,0,1))
c.getn(0,45, {|m| m.postln});
c.chunkSwap(3,11,-3)
c.getn(0,45, {|m| m.postln});

////////////////////////////////////////////////////////////
// test in benchmarking
1000.do({b.chunkSwap(b.numFrames.rand,b.numFrames.rand,(b.numFrames.rand-(b.numFrames/2)));})
b.free

b=Buffer.read(s,"/Volumes/trucs/archive - pièces PA/asinglewordisnotenough3(invariant).wav")
b.play(true, 0.1)
b.reverse


Task.new({
d = Main.elapsedTime;
0.01.wait;
50.do({b.reverse});
}).play
(c-d).postln



(
f = { |msg, time, replyAddr, recvPort|
	    if(msg[0] == '/done') {
		// "time done %s\n".postf( time, msg, replyAddr, recvPort )
		c = time;
    }
};
thisProcess.addOSCRecvFunc(f);
d = Main.elapsedTime;
45.do({b.reverse});
)

(c-d).postln

// stop posting.
thisProcess.removeOSCRecvFunc(f);


////////////////////////////////////////////////////////////
//temp files version
Buffer.freeAll
// sets known values

b = Buffer.alloc(s,16);
b.setn(0, Array.series(16,1,1));
b.getn(0,16, {|msg| msg.postln});

b.loadToFloatArray(action: {
	arg array;
	b.loadCollection(array.reverse);
});

b.getn(0,16, {|msg| msg.postln});

/////
b=Buffer.read(s,"/Volumes/machins/professionnel/sons/boucle A(lent)/loopC.aif")
b=Buffer.read(s,"/Volumes/trucs/archive - pièces PA/asinglewordisnotenough3(invariant).wav")
b.play(true, 0.1)

(
d = Main.elapsedTime;
b.loadToFloatArray(action: {
	arg array;
	b.loadCollection(array.reverse, action:{c = Main.elapsedTime;});
});
)

////////////////////////////
// via osc (too slow for big file)
(
d = Main.elapsedTime;
b.getToFloatArray(wait:1, timeout:30, action:{
	arg array;
	array.postln;
	// b.sendCollection(array.reverse, action:{c = Main.elapsedTime;});
});
)

FloatArray
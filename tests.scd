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
1000.do({b.chunkSwap(b.numFrames.rand,b.numFrames.rand,(b.numFrames.rand-(b.numFrames/2)));})


b=Buffer.read(s,"/Volumes/trucs/archive - pièces PA/asinglewordisnotenough3(invariant).wav")
b.play(true, 0.1)
b.reverse

////////////////////////////////////////////////////////////
//temp files version

// sets known values
b = Buffer.alloc(s,16);
b.setn(0, Array.series(16,1,1));

b.loadToFloatArray(action: {
	arg array;
	array.postln;
	x = array.reverse;
	x.postln;
	b.loadCollection(x);
});

b.getn(0,16, {|msg| msg.postln});


b = Buffer.read(s,"/Volumes/machins/--à archiver/démarche/BEAST-HOA+cheat/bounces/montage-17.wav")
b.read("/Volumes/machins/--à archiver/démarche/BEAST-HOA+cheat/bounces/montage-17.wav",0,926100000
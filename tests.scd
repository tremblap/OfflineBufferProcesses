s.quit
s.boot
// allocates a 16-sample buffer and fills it with ascending values
b = Buffer.alloc(s,16);
b.setn(0, Array.series(16,1,1));

// read to check
b.getn(0,16, {|msg| msg.postln});

// apply the NRT method
b.reverse

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


b=Buffer.read(s,"/Volumes/machins/projets/Lucilin/sons/descente-complexe/Audio/01-180205_2135.wav")
b.play(true, 0.1)
b.reverse

////////////////////////////////////////////////////////////
//temp files version

s.boot;
(
v = Signal.sineFill(128, 1.0/[1,2,3,4,5,6]);
b = Buffer.alloc(s, 128);
)
(
b.loadCollection(v, action: {|buf|
    x = { PlayBuf.ar(buf.numChannels, buf, BufRateScale.kr(buf), loop: 1)
        * 0.2 }.play;
});
)
x.free; b.free;

// interleave a multi-dimensional array
(
l = Signal.sineFill(16384, [0 0 0 0 0 0 0 0 1]);
r = Array.fill(16384, {1.0.rand2});
m = [Array.newFrom(l), r]; // a multi-dimensional array
m = m.lace(32768); // interleave the two collections
b = Buffer.alloc(s, 16384, 2);
)

l.plot

(
b.loadCollection(m, 0, {|buf|
    x = { PlayBuf.ar(2, buf, BufRateScale.kr(buf), loop: 1) * 0.5 }.play;
});
)
b.plot;
x.free; b.free;

//then;
b = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav");
b.loadToFloatArray(action: { arg array; a = array; {a.plot;}.defer; "done".postln;});
b.free;


//re-read Collins chapter inSC book (p.439)

//p 733-737 in the book speak of the NRT thread (double buffer map!)

//3 methods -
// 1) osc/file transfer to language with language processing (loadCollection  and loadToFloatArray )
// 2) osc/file transfer to class processing (faster?)
// 3) osc/file transfer to external terminal process
// 4) server NRT plugin


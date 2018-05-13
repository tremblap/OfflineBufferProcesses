//address tests
b = Buffer.alloc(s,30*60*44100,32)
r = Array.fill(1638400, {1.0.rand2});
b.loadCollection(r,25*60*44100)


2540160000 samples
2116800000
423360000

//
s.quit
s.boot
// allocates a 16-sample buffer and fills it with ascending values
b = Buffer.alloc(s,16);
c = Buffer.alloc(s,16);
b.setn(0, Array.series(16,-8,1));
c.zero

// read to check
b.getn(0,16, {|msg| msg.postln});
c.getn(0,16, {|msg| msg.postln});

// apply the NRT method
b.waveSetCopyTo(c)

// read to check
c.getn(0,16, {|msg| msg.postln});

// check exceptions
b.waveSetCopyTo(b)
d = Buffer.alloc(s,16,2);
b.waveSetCopyTo(d)
b.waveSetCopyTo(e)

b = Buffer.alloc(s,256);
c = Buffer.alloc(s,256);
b.sine1([0,0,0,1],true,false);
b.waveSetCopyTo(c)

b.plot;c.plot

//trying with start above zero
b.sine3([3.3],[1],[0.3],true,false);
c.zero;
b.waveSetCopyTo(c)

b.plot;c.plot

//trying with start below zero
b.sine3([2.7],[1],[3.3],true,false);
c.zero;
b.waveSetCopyTo(c)

b.plot;c.plot

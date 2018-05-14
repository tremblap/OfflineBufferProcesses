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


/////////////////////////////////////
// copying a sine as many time it can (one cycle does not cross zero twice !)
b = Buffer.alloc(s,256);
c = Buffer.alloc(s,1000);
b.sine1([1],true,false);
b.waveSetCopyTo(c)
b.plot;c.plot

// copying a sine as many time it can (one cycle does not cross zero twice !)
b.sine2([1.1],[1],true,false);
b.waveSetCopyTo(c)
b.plot;c.plot
b.getn(230,26,{|i| i.postln})
c.getn(230,26,{|i| i.postln})
b.getn(0,26,{|i| i.postln})
c.getn(0,26,{|i| i.postln})

c.zero
b.waveSetCopyTo(c,1)
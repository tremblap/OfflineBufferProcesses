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

b = Buffer.alloc(s,4096);
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
b = Buffer.alloc(s,4096);
b.setn(0, Array.fill(64,{1.0.rand2}).round(0.1).stutter(64));
b.removeDC(0.1)

/////////////////////////////////////
b = Buffer.alloc(s,44100);
b.sine1(Array.fill(100,{|i| ((i+1)%2)/(i+1)}),true,false)


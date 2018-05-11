s.quit
s.boot
// allocates a 16-sample buffer and fills it with ascending values
b = Buffer.alloc(s,16);
c = Buffer.alloc(s,16);
b.setn(0, Array.series(16,1,1));
c.zero

// read to check
b.getn(0,16, {|msg| msg.postln});
c.getn(0,16, {|msg| msg.postln});

// apply the NRT method
b.waveSetCopyTo(c)

// read to check
c.getn(0,16, {|msg| msg.postln});

// flip again
b.reverse

// read to check
b.getn(0,16, {|msg| msg.postln});


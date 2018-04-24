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


////////////////////////////////////////////////////////////
// trying stereo
d = Buffer.alloc(s,15,3)
d.setn(0,Array.series(45,1,1))
d.getn(0,45, {|m| m.postln});
d.reverse

////////////////////////////////////////////////////////////
// trying audio


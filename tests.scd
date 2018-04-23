// allocates a 16-sample buffer and fills it with small random values
b = Buffer.alloc(s,16);
b.setn(0, Array.fill(16, {0.1.rand2}));

// draw to check
b.plot

// apply the NRT method (normalisation code for now)
b.reverse

// draw to check
b.plot

// normalise to another maximum and draw to check
b.reverse(0.5)
b.plot

// free the buffer and check that an error is thrown
b.free
b.reverse

s.quit
s.boot
// allocates a 16-sample buffer and fills it with small random values
b = Buffer.alloc(s,16);
c = Buffer.alloc(s,44100,9);

// apply the NRT method (checking buf variables for now)
b.reverse
c.reverse

b.reverse(5,6.1,"trauma")

//check for erronous types
c.reverse(12.1,13,4)

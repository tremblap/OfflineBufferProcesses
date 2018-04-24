s.reboot
// allocates a 16-sample buffer and fills it with small random values
b = Buffer.alloc(s,16);
c = Buffer.alloc(s,123456789,17);

// apply the NRT method (checking buf variables for now)
b.reverse
c.reverse

b.reverse(5,6,7,8)

c.reverse(12,13,14,15)

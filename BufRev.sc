// adds an instance method 'reverse' to the Buffer class
// at the moment, the code is just checking for buffer existence as the 'plugin' will run a basic normalisation
+ Buffer {
	reverse { arg newmax=1, testb = 2, testc = 3, testd = 4;
		if(bufnum.isNil) { Error("Cannot call % on a % that has been freed".format(thisMethod.name, this.class.name)).throw };
		server.listSendMsg([\b_gen, bufnum, "reverse", newmax, testb, testc, testd])
	}
}

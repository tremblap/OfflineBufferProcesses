// adds 2 instance methods to the Buffer class: 'reverse' and 'chunkSwap'
+ Buffer {
	mul { arg gain = -1.0;
		if(bufnum.isNil) { Error("Cannot call % on a % that has been freed".format(thisMethod.name, this.class.name)).throw };
		server.listSendMsg([\b_gen, bufnum, "mul", gain])
	}
	add { arg offset = 0.0;
		if(bufnum.isNil) { Error("Cannot call % on a % that has been freed".format(thisMethod.name, this.class.name)).throw };
		server.listSendMsg([\b_gen, bufnum, "add", offset])
	}
	removeDC { arg coef = 0.995;
		if(bufnum.isNil) { Error("Cannot call % on a % that has been freed".format(thisMethod.name, this.class.name)).throw };
		server.listSendMsg([\b_gen, bufnum, "removeDC", coef])
	}
	reverse {
		if(bufnum.isNil) { Error("Cannot call % on a % that has been freed".format(thisMethod.name, this.class.name)).throw };
		server.listSendMsg([\b_gen, bufnum, "reverse"])
	}
	chunkSwap { arg srcStartAt = 0, dstStartAt = -1, numFrames = 0;
		if(bufnum.isNil) { Error("Cannot call % on a % that has been freed".format(thisMethod.name, this.class.name)).throw };
		server.listSendMsg([\b_gen, bufnum, "chunkSwap", srcStartAt, dstStartAt, numFrames])
	}
	waveSetCopyTo { arg dstBuf, repetitions = 0;
		if(bufnum.isNil) { Error("Cannot call % on a % that has been freed".format(thisMethod.name, this.class.name)).throw };
		server.listSendMsg([\b_gen, dstBuf.bufnum, "waveSetCopyTo", bufnum, repetitions])
	}
}

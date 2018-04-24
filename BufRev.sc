// adds 2 instance methods to the Buffer class: 'reverse' and 'chunkSwap'
+ Buffer {
	reverse {
		if(bufnum.isNil) { Error("Cannot call % on a % that has been freed".format(thisMethod.name, this.class.name)).throw };
		server.listSendMsg([\b_gen, bufnum, "reverse"])
	}
	chunkSwap { arg srcStartAt = 0, dstStartAt = -1, numFrames = 0;
		if(bufnum.isNil) { Error("Cannot call % on a % that has been freed".format(thisMethod.name, this.class.name)).throw };
		server.listSendMsg([\b_gen, bufnum, "chunkSwap", srcStartAt, dstStartAt, numFrames])
	}
}

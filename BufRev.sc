+ Buffer {
	reverse { arg newmax=1;
		if(bufnum.isNil) { Error("Cannot call % on a % that has been freed".format(thisMethod.name, this.class.name)).throw };
		server.listSendMsg([\b_gen, bufnum, "reverse", newmax])
	}
}


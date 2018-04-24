// BufRev, an NRT buffer samples swapper
// Pierre Alexandre Tremblay, 2018
// A digital debris of the FluCoMa project, funded by the European Research Council (ERC) under the European Union’s Horizon 2020 research and innovation programme (grant agreement No 725899)

#include "SC_PlugIn.h"

static InterfaceTable *ft;

void BufRev(World *world, struct SndBuf *buf, struct sc_msg_iter *msg)
{
	float newmax;
	if(msg->remain() != 0){
		newmax = msg->getf();
	}else{
		newmax = 1.f;
	}
	float *data = buf->data;
	int size = buf->samples;
  int chans = buf->channels;
  int frames = buf->frames;

  Print("size = %d\nchans = %d\nframes = %d\n",size,chans,frames);
}

PluginLoad(BufRevUGens) {
  ft = inTable;
  DefineBufGen("reverse", BufRev);
}

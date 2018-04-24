// BufRev, an NRT buffer samples swapper
// Pierre Alexandre Tremblay, 2018
// A digital debris of the FluCoMa project, funded by the European Research Council (ERC) under the European Union’s Horizon 2020 research and innovation programme (grant agreement No 725899)

#include "SC_PlugIn.h"

static InterfaceTable *ft;

void BufRev(World *world, struct SndBuf *buf, struct sc_msg_iter *msg)
{
  float32 arg1 = msg->getf(11);
  float32 arg2 = msg->getf(22);
  float32 arg3 = msg->getf(33);
  float32 arg4 = msg->getf(44);

	Print("%f\n%f\n%f\n%f\n", arg1,arg2,arg3,arg4);

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

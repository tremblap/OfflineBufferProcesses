// BufRev, an NRT buffer samples swapper
// Pierre Alexandre Tremblay, 2018
// A digital debris of the FluCoMa project, funded by the European Research Council (ERC) under the European Union’s Horizon 2020 research and innovation programme (grant agreement No 725899)

#include "SC_PlugIn.h"

static InterfaceTable *ft;

void BufRev(World *world, struct SndBuf *buf, struct sc_msg_iter *msg)
{
	float *data = buf->data;
  int size = buf->samples;
  int chans = buf->channels;
  int frames = buf->frames;
  int halfframe = frames/2;
  float temp;
  int loadd,hiadd;

  // Print("size = %d\nchans = %d\nframes = %d\nhalfframe = %d\n",size,chans,frames,halfframe);

  for (int i = 0; i < halfframe; ++i) {
    for (int j = 0; j < chans; ++j) {
      hiadd = j+size-((i+1)*chans);
      loadd = j+(i*chans);
      // Print("%d %d %d %d\n", i, j, hiadd, loadd);
      temp = data[hiadd];
      data[hiadd] = data[loadd];
      data[loadd] = temp;
    }
  }
}

PluginLoad(BufRevUGens) {
  ft = inTable;
  DefineBufGen("reverse", BufRev);
}

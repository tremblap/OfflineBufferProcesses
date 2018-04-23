// BufRev, an NRT buffer samples swapper
// Pierre Alexandre Tremblay, 2018
// A digital debris of the FluCoMa project, funded by the European Research Council (ERC) under the European Union’s Horizon 2020 research and innovation programme (grant agreement No 725899)

#include "SC_PlugIn.h"

static InterfaceTable *ft;

static void normalize_samples(int size, float* data, float peak)
{
	float maxamp = 0.f;
	for (int i=0; i<size; ++i) {
		float absamp = std::abs(data[i]);
		if (absamp > maxamp) maxamp = absamp;
	}
	if (maxamp != 0.f && maxamp != peak) {
		float ampfac = peak / maxamp;
		for (int i=0; i<size; ++i) {
			data[i] *= ampfac;
		}
	}
}

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
	normalize_samples(size, data, newmax);
}

PluginLoad(BufRevUGens) {
  ft = inTable;
  DefineBufGen("reverse", BufRev);
}

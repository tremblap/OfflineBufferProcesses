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

  for (int i = 0; i < halfframe; ++i) {
    for (int j = 0; j < chans; ++j) {
      hiadd = j+size-((i+1)*chans);
      loadd = j+(i*chans);
      temp = data[hiadd];
      data[hiadd] = data[loadd];
      data[loadd] = temp;
    }
  }
}

void chunkSwap(World *world, struct SndBuf *buf, struct sc_msg_iter *msg)
{
	float *data = buf->data;
  // int size = buf->samples;
  int chans = buf->channels;
  int frames = buf->frames;

  // reading the arguments with default values
  int srcStartAt = msg->geti(0);
  int dstStartAt = msg->geti(-1);
  int numFrames = msg->geti(0);

  // should default value happen, retrieve them
  if (dstStartAt == -1)
    dstStartAt = frames - 1; // defaults to last sample
  if (numFrames == 0)
    numFrames = (frames * -1) / 2;

  // define end writing frames (inclusive) and the incrementor value
  int AbsNumFrames = std::abs(numFrames);
	int dstStep = numFrames == AbsNumFrames ? 1 : -1;
  int srcStopAt = srcStartAt + AbsNumFrames - 1;
  int dstStopAt = dstStartAt + numFrames - dstStep;

  if (srcStartAt < 0 || srcStartAt >= frames) {
    Print("chunkSwap is not happy because the source starting is outside the buffer.\n");
    return;
  }
  else if (srcStopAt < 0 || srcStopAt >= frames) {
    Print("chunkSwap is not happy because the source finishing is outside the buffer.\n");
    return;
  }
  else if (dstStartAt < 0 || dstStartAt >= frames) {
    Print("chunkSwap is not happy because the destination starting is outside the buffer.\n");
    return;
  }
  else if (dstStopAt < 0 || dstStopAt >= frames) {
    Print("chunkSwap is not happy because the destination finishing is outside the buffer.\n");
    return;
  }

  float temp;
  int srcAdd,dstAdd;

  for (int i = srcStartAt; i <= srcStopAt; ++i) {
    for (int j = 0; j < chans; ++j) {
      dstAdd = j+(dstStartAt*chans);
      srcAdd = j+(i*chans);
      // Print("%d %d %d %d\n", i, j, hiadd, loadd);
      temp = data[dstAdd];
      data[dstAdd] = data[srcAdd];
      data[srcAdd] = temp;
    }
    dstStartAt+= dstStep;
  }
}

void waveSetCopyTo(World *world, struct SndBuf *buf, struct sc_msg_iter *msg)
{
	int frames1 = buf->frames;
	int channels1 = buf->channels;

	uint32 bufnum2 = msg->geti();
	int repetitions = msg->geti();

	if (bufnum2 >= world->mNumSndBufs){
		Print("waveSetCopyTo is not happy because the source buffer does not exist.\n");
		return;
	}

	SndBuf* buf2 = world->mSndBufs + bufnum2;

	if (buf2->data == buf->data){
		Print("waveSetCopyTo is not happy because the source buffer is the same as the destination buffer.\n");
		return;
	}

	int frames2 = buf2->frames;
	int channels2 = buf2->channels;

	if (channels1 != channels2) {
		Print("waveSetCopyTo is not happy because the source buffer has a different channel count than the destination buffer.\n");
		return;
	}


	long fromPos = 0;
	long toPos = 0;

	int length = sc_min(frames2, frames1);

	if (length <= 0) return;

	int numbytes = length * sizeof(float) * channels1;
	float *data1 = buf->data + toPos * channels1;
	float *data2 = buf2->data + fromPos * channels2;

	memcpy(data1, data2, numbytes);
}

PluginLoad(BufRevUGens) {
  ft = inTable;
  DefineBufGen("reverse", BufRev);
  DefineBufGen("chunkSwap", chunkSwap);
	DefineBufGen("waveSetCopyTo", waveSetCopyTo);
}

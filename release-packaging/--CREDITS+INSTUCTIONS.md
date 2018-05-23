### OfflineBufferProcesses, a few utilities to manipulate buffers on the server's non-real-time thread
v.1 by Pierre Alexandre Tremblay (2018)

#### Description
This is a set of offline buffer processes for SuperCollider (https://supercollider.github.io/) augmenting the Buffer class with new instance methods. This project, especially the first few commits of the repository, can be used to understand how to write such process in C.

#### How to Install from binaries (SC 3.8 or 3.9 on Mac required)
1. If you read this, you must have downloaded the binary package. If not, download the right one for your SC version from the GitHub repository.
2. Drag the full `OfflineBufferProcesses` folder, with its 3 subfolders (classes, HelpSource, plugins) in your `Extensions` folder. If you don't know what this is, please read the SuperCollider instructions here: (http://doc.sccode.org/Guides/UsingExtensions.html)
3. Enjoy!

#### How to get started
The fact that this package extends the native Buffer class means that the new instance methods will be documented in the Buffer helpfile.

The new methods are:

`.add(offset)`
  - adds an offset to the value of each sample (default: 0)

`.mul(gain)`
  - multiplies each sample by the gain (default: -1)

`.removeDC(coefficient)`
  - applies a one-pole high-pass filter of the given coefficient o remove any DC offset, preserving the separate channels

`.reverse()`
  - swaps the order of samples in the buffer, from the end to the start, preserving the separate channels

`.chunkSwap(srcStartAt, dstStartAt, numFrames)`
  - moves chunks of contiguous frames within a buffer, preserving the separate channels

`.waveSetCopyTo(dstBuf, repetitions)`
  - copies complete wavesets to a destination buffer, preserving the separate channels

A quick example of use in SuperCollider code would look like this:

```
s.boot;
//load a file, and play it
b=Buffer.read(s,Platform.resourceDir +/+ "sounds/a11wlk01.wav", action:{b.play(true,0.1)})

// auto-glitch-scrambler
10.do({b.chunkSwap(b.numFrames.rand,b.numFrames.rand,(b.numFrames.rand-(b.numFrames/2)));})

// clean up
b.free;
```

The Buffer helpfile has complete documentation of all methods with many examples. There is also a Guide entitled 'OfflineBufferProcesses' which explains and compares other methods to do similar tasks. You can find it by searching the SuperCollider help browser.

Comments, suggestions and bug reports are welcome.

###### Acknowledgements
This toolset made possible thanks to the FluCoMa project (http://www.flucoma.org/) funded by the European Research Council (https://erc.europa.eu/) under the European Union’s Horizon 2020 research and innovation programme (grant agreement No 725899)

Thanks to Gerard Roma, Owen Green, and Sam Pluta for their input.

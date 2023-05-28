### OfflineBufferProcesses, a few utilities to manipulate buffers on the server's non-real-time thread
v.1 by Pierre Alexandre Tremblay (2018)

#### Description
This is a set of offline buffer processes for SuperCollider (https://supercollider.github.io/) augmenting the Buffer class with new instance methods. This project, especially the first few commits of the repository, can be used to understand how to write such process in C.

#### How to Install from binaries (SC 3.9 on Mac required)
Download the package and read the text file.

#### How to build from the source code
These instructions are modified from the amazingly streamlined UGen writing tutorial by snappizz (https://github.com/supercollider/example-plugins)
1. Download the SuperCollider source
2. Create build directory
  1. `cd` to the folder where OfflineBufferProcesses is
  2. create a `build` directory
  3. `cd` into it
3. Set the compiler options and build
  4. set the make parameters by typing `cmake -DSC_PATH=PATH_TO_SUPERCOLLIDER_SOURCE -DCMAKE_BUILD_TYPE=Release ..`
    5. for a MacOS fat binary add `-DCMAKE_OSX_ARCHITECTURES="x86_64;arm64"` - or for a personal copy the option `-DCMAKE_CXX_FLAGS=-march=native` will optimise as fast as the machine will go, at the cost of compatibility with other hardware.
  6. type `make`, it should compile.
7. once it is done, install the Ugen and its Declaration by moving them in the `release-packaging/OfflineBufferProcesses/classes` and 'release-packaging/OfflineBufferProcesses/plugins' respectively, then move the whole `OfflineBufferProcesses` folder in your `Extensions` folder.
  8. for MacOS this is where code signature and notarization has to happen...


#### Enjoy! Comments, suggestions and bug reports are welcome.

###### Acknowledgements
This toolset made possible thanks to the FluCoMa project (http://www.flucoma.org/) funded by the European Research Council (https://erc.europa.eu/) under the European Union’s Horizon 2020 research and innovation programme (grant agreement No 725899)

Thanks to Gerard Roma, Owen Green, and Sam Pluta for their input.

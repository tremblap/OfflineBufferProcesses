### OfflineBufferProcesses, a few utilities to manipulate buffers on the server's non-real-time thread
v.1 by Pierre Alexandre Tremblay (2018)

###### Description
This is a set of offline buffer processes for SuperCollider (https://supercollider.github.io/) augmenting the Buffer class with new instance methods. This project, especially the first few commits of the repository, can be used to understand how to write such process in C.

This was made possible thanks to the FluCoMa project (http://www.flucoma.org/) funded by the European Research Council (https://erc.europa.eu/) under the European Union’s Horizon 2020 research and innovation programme (grant agreement No 725899)

###### How to Install from binaries (SC 3.8 or 3.9 on Mac required)
1. If you read this, you must have downloaded the binary package. If not, download the right one for your SC version from the GitHub repository.
2. Drag the full `OfflineBufferProcesses` folder, with its 3 subfolders (classes, HelpSource, plugins) in your `Extensions` folder. If you don't know what this is, please read the SuperCollider instructions here: (http://doc.sccode.org/Guides/UsingExtensions.html)
3. Enjoy!

###### How to get started
The fact that this package extends the native Buffer class means that the different instance methods will be documented in the Buffer helpfile. There is also a Guide entitled 'OfflineBufferProcesses' which explains other methods to do similar tasks.

Comments, suggestions and bug reports are welcome.

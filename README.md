# NSStream-GCD
Combining NSStream Input/Output with CFReadStreamSetDispatchQueue/CFWriteStreamSetDispatchQueue

One huge disadvantage is the apparent requirement to use Streams with a Runloop. Apple never provided (TTBOFMK) any example code of how to create a thread specifically to use with Streams (but they do have lots of warnings about "doing it right"). I suppose most people just use the main runloop.
The I read a thread on StackOverFlow https://stackoverflow.com/a/41050351/1633251 that referenced Apple code https://developer.apple.com/library/archive/samplecode/sc1236/Listings/TLSTool_TLSToolCommon_m.html that uses GCD by setting a GCD queue on the CFThread on which Stream is built. Hmmm - must be OK. But nothing in writing anywhere else...

The following code uses two classes, an Swift class acting as a output and an ObjectiveC class as the input. The output is just random chunks of memory sent randomly and the input just tosses the data away. If it doesn't crash, I guess this approach should be OK to use :-)

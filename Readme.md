Readme
======

Optima is a program that processes optical imaging file in TIFF format

It is distributed under a GPL licence. See the Licence file.




TIFF-files
-------------
The imaging data should be stored as multiimage gray level TIFF-files with one image per frame


optdata files
-------------
The results of the processing is stored in optdata files with the same name as the tiff-file.

The opdtata file is in plist format. Where each variable contains one computed value.



Template.files
--------------
The parameters are set in a Template.plist file in the directory next to or above the tiff-files.

The available parameters are:

filter.radius: radius in pixel of the gaussing smoothing
bp.a: window of the band-pass filter
const.a: first frame for constant background approximation
const.b: last frame for constant background approximation (non-inclusive)
lin.a: first frame for linear background approximation, window 1
lin.b: last frame for linear background approximation (non-inclusive)
lin.c: first frame for linear background approximation, window 2
lin.d: last frame for linear background approximation (non-inclusive)
poly.a: first frame for polynomial background approximation, window 1
poly.b: last frame for linear background approximation (non-inclusive)
poly.c: first frame for polynomial background approximation, window 2
poly.d: last frame for linear background approximation (non-inclusive)
reg.method: regression method (band-pass, constant, linear, polynomial, or all)
mask.fraction: 0-1
measure.start: first frame
measure.end: last frame (non-inclusive)
stimulus.start: first frame
stimulus.end: last frame (non-inclusive)

Parameters can also be set outomatically from the file name using the =PATH(a, b, c) function, whre
a is the element of the path (i. e. 0 is the last part of the file name, 1 is the directory etc), b
is the first character in the name to use and c is the number of characters. For example

stimulus.type = PATH(0,2,1)

would use the second character of the file name for the variable stimlus.type.

Any additional parameters can be added and will only be passed to the optdata files.



ROC-analysis
------------
The ROC analysis is controlled by a file called ROC.plist. This file contains a list that describes the analysis that should be run. The parameters are as follows:

label.column: column in the opdtata file to use to classify stimuli.
label1: the first category
label2: the second category
aggregate: should measurements with identical labels be aggregated for each animal (0/1)

The results of the ROC analysis is prodeced as a CSV file.



Running the program
--------------------
Select the directory with the TIFF files from the Process menu.



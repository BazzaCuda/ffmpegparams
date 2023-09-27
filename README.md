# ffmpegparams
 
A quick and dirty, but nonetheless very useful, GUI front-end for FFMPEG.

Make sure that ffmpegparams.bat and ffmpegparams.ini are in the same folder as ffmpegparams.exe

The .ini file contains some common examples for the output switches which will be loaded when the program launches.

The .bat file contains a skeleton batch file which will report an overall duration time for the entire batch job when it finishes.
This file is read each time you press the GO button.

**N.B. The program assumes your system path contains the path to your FFMPEG/Bin installation.**

1. Paste a list of full pathnames and filenames into the "Input Files" box.
2. Modify the LogLevel, Input Switches and Output Switches as required.
3. Check the output file extension is to your requirements.
4. Click GO.

The program creates a Windows batch file in the same folder as the first file in your input list.

Each converted output file has [c] added to the file name to ensure the input file is not overwritten.

You will need to run the batch file yourself. This app doesn't run it for you.

I use this a lot for converting existing movies to H265 to conserve disk space.

You can edit the .ini file to add your own commonly-used output switches. The app will automatically select the last one in the file, assuming it to be the most recently-added.

Suggestions for amendments (or pull requests) will be considered.

# ffmpegparams
 
A quick and dirty, but nonetheless very useful, GUI front-end for FFMPEG.
![Clipboard Image](https://github.com/BazzaCuda/ffmpegparams/assets/22550919/e54ae331-43bd-4750-9891-7999d1973812)


Make sure that ffmpegparams.bat and ffmpegparams.ini are in the same folder as ffmpegparams.exe

The .ini file contains some common examples of ffmpeg output switches and will be loaded when the program launches.

The .bat file contains a skeleton batch file which will report an overall duration time for the entire batch job when it finishes.
This file is read each time you press the GO button and is used to create the batch process for your files.

**N.B. The program assumes your system path contains the path to your FFMPEG/Bin installation.**

1. Paste a list of full pathnames and filenames into the "Input Files" box or drag and drop files from Explorer. Each new set of dropped files will be added to the input list.  Alternatively, holding down a shift key while you drop the files will replace the existing list entirely.
2. Modify the LogLevel, Input Switches and Output Switches as required.
3. Check the output file extension is to your requirements.
4. Click GO.

The program modifies the skeleton batch file and creates a "zzz_convert.bat" Windows batch file in the same folder as the first file in your input list.
If you uncheck the "Overwrite convert.bat" option, the program will create "zzz_convert1.bat", "zzz_convert2.bat" etc. instead, each time you click GO.

Each converted output file has [c] added to the file name to ensure the input file is not overwritten.

~~You will need to run the batch file yourself. This app doesn't run it for you.~~

_**Edit: there is now an option to run the batch file immediately.**_

I use this a lot for converting existing movies to H265 to free up disk space.

You can edit the .ini file to add your own commonly-used output switches. The app will automatically select the last one in the file, assuming it to be the most recently-added.

Suggestions for amendments (or pull requests) will be considered.

~~I will deliver a pre-built release shortly (probably tomorrow), for those that are unable to build this project.~~

As promised: https://github.com/BazzaCuda/ffmpegparams/releases

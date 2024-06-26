# ffmpegparams

Release v2.0.2: paste an internet URL for a .m3u8 file and the UI will change to allow you to quickly specify a download location and filename for the captured stream and then run FFmpeg directly in a command prompt window. See release notes.

N.B. If you create the default zzz_convert.bat file and, while it's running, you change your mind about how you've set the `Pause at End`, `Delete batch file at End`, or `Shutdown at End` checkboxes, you can change them!
Leave `Overwrite batch file` checked and uncheck `Run batch file` so you don't start a second batch job running. Click Go again. This will overwrite your running batch file.
Because of the way Windows reads batch files, your changes at the end of the .bat file will be read when the command processor gets to them.
 
A quick and dirty, but nonetheless very useful, GUI front-end for FFMPEG.

UPDATE: rejigged to work with multiple command line utilities similar to FFMPEG
- for details, see release v2.0.0 https://github.com/BazzaCuda/ffmpegparams/releases/tag/v2.0.0

![Clipboard Image (1)](https://github.com/BazzaCuda/ffmpegparams/assets/22550919/a0a056a7-76b6-48ce-905b-cce1372fd5a5)

Make sure that ffmpegparams.bat and ffmpeg.ini are in the same folder as ffmpegparams.exe

The .ini file contains some common examples of ffmpeg output switches and will be loaded when the program launches.

The .bat file contains a skeleton batch file which will report an overall duration time for the entire batch job when it finishes.
This file is read each time you press the GO button and is used to create the batch process for your files.

**N.B. The program assumes your system path contains the path to your FFMPEG/Bin installation.**
Alternatively, grab the copy of ffmpeg.exe that ships with [`MMP - Minimalist Media Player`](https://github.com/BazzaCuda/MinimalistMediaPlayerX) and include it in the the same folder as ffmpegparams.exe

1. Paste a list of full pathnames and filenames into the "Input Files" box or drag and drop files from Explorer. Each new set of dropped files will be added to the input list.  Alternatively, holding down a shift key while you drop the files will replace the existing list entirely.
2. Modify the LogLevel, Input Switches and Output Switches as required.
3. Check the output file extension is to your requirements.
4. Click GO.

The program modifies the skeleton batch file and creates a "zzz_convert.bat" Windows batch file in the same folder as the first file in your input list.
If you _uncheck_ the "Overwrite convert.bat" option, the program will create "zzz_convert1.bat", "zzz_convert2.bat" etc. instead, each time you click GO.
This allows you to setup multiple batch jobs in multiple folders before running them.

Each converted output file has [c] added to the file name to ensure the input file is not overwritten.

~~You will need to run the batch file yourself. This app doesn't run it for you.~~

_**Edit: there is now an option to run the batch file immediately.**_

I use this a lot for converting existing movies to H265 to free up disk space.

You can edit the .ini file to add your own commonly-used output switches. The app will automatically select the last one in the file, assuming it to be the most recently-added.

Suggestions for amendments (or pull requests) will be considered.

~~I will deliver a pre-built release shortly (probably tomorrow), for those who are unable to build this project.~~

As promised: https://github.com/BazzaCuda/ffmpegparams/releases

It's been a real trip down memory lane writing code that's as bad as this (#FeelingNostalgic) - at some point I'm going to have to rewrite it as it's already starting to get annoying :D
I'm tempted to go to the opposite extreme and completely over-engineer it, with polymorphism and dependency injection, etc., just for the fun of it!

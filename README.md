# edge-of-solaris
a spiritual sequel to RPG Shooter Starwish

in active development. if you find any bugs please check the known-bug-list in the docs, if it is not on that list, please let me know either via a bug report or on twitter @deadstephanietm

Windows users: navigate to windows-amd64 and download this folder then run the exe inside it
Note you may be prompted to install Java 17 after you install openjdk 17, if so, use the x64 installer here (oracle jdk17) https://www.oracle.com/java/technologies/downloads/#jdk17-windows

Linux users: navigate to linux-amd64 and download this folder then run the binary inside it

Mac OS users: you will need to download the source and download Processing 4. open edge_of_solaris.pde in Processing and compile the program for Mac OS. I cannot compile one for you because it must be compiled from a Mac OS machine and I do not have one

BUILD NOTES
This program depends on version 1.3.2 of Jamepad (https://github.com/williamahartman/Jamepad/releases/tag/1.3.2)
Install Instructions (courtesy of https://discourse.processing.org/t/alternative-gamepad-support-library-jamepad/23088):
1. Download Source code (zip) and Jamepad.jar
2. Unzip Jamepad-1.3.2.zip
3. In the Jamepad-1.3.2 folder make a new folder called library
4. Move Jamepad.jar into the library folder
5. Rename the Jamepad-1.3.2 folder to just Jamepad because processing won’t recognize the library if the .jar name and folder name don’t match
6. Move the Jamepad folder into the libraries folder, on linux usually located in ~/sketchbook/libraries, on windows usually located in Documents/Processing/libraries

You should be able to compile the sketch after adding that library. After compiling, you will need to copy these files into the compiled directory:
assets folder
settings.json
gamesave.json
level-editor-save.json

I wrote a bash file copy-assets.sh in the root directory that takes care of that on linux. If you are using a different operating system, adapt the script or copy the files manually.

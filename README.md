# Godot_LinuxLibsInstaller

Ok', here instruction, which you can use on Linux to install all required apps
and packages for compiling Godot 4.3 on Linux, which I managed to make work.
It should really simplifiy all the process.

For installation you need a stable internet-connection and enough memory
(for exemple, all stuff for Mac may require 45 GB of temporal files).

**FIRST**: This script actually unofficial and is a result of nearly a month of my
web-surfing and experimenting with libraries. You can do with it anithing you
want (modify, copy, distribute, build dockers, etc.)
I do not recommend it to use on your main work-station, as I can’t give any
guarantees this won't break something in your system options. I used virtual
machine (via VirtualBox software https://www.virtualbox.org/ ) for this purpose.

**SECOND**: As stated in the official documentation:

              \"Linux binaries usually won't run on distributions that are older
              than the distribution they were built on. If you wish to distribute
              binaries that work on most distributions, you should build them on
              an old distribution such as Ubuntu 16.04. You can use a virtual
              machine or a container to set up a suitable build environment.\"

 So for "Compiling for Linux, *BSD"-part I used Ubuntu 16.04.7 as it were
 recommended. (You can get it here: https://releases.ubuntu.com/xenial/ ) Some of
 libriries installing by this script due to necessity have outdated versions. On the
 newer versions of Linux you can get much simper way to install the same libraries of
 newer versions, but Ubuntu 16.04 have a lot of difficultis on it. I tested it on
 64-bit and 32-bit Ubuntu (there is a big problem with cross-compilation for
 different bit-arcitectures). It all seemed to work normal, except \"Cross-compiling for
 RISC-V devices\" and \"Using Pyston for faster development\".
 
 **THIRD**: For "Cross-compiling for RISC-V devices" check description inside the script!
 For "Using Pyston for faster development" note, that I didn't managed to compile  it
 for 32-bit OS.
 
 **FORTH**: For "Compiling for macOS (Cross-compiling from Linux)"-part testing I tried
 modern Ubuntu-20.04 and IT DOESN'T WORK ON IT AT ALL\!\!! I mean... After all issues
 solving I still got a linking error at the very end of Godot cross-compilation.
 Instead I reccomend to use this dockers https://github.com/godotengine/build-containers,
 which didn't worked on Ubuntu-20.04 for me either — install Fedora-36 straightaway.
 So... You still could try to test MAC-part of my script on any Linux version you like,
 but I can't say whether it will work or not. Anyway — all the steps seem to have been
 done properly. I'd be glad to know the results of your own check!

 **FIFTH**: This script doesn't have part for "Compiling for iOS".

 **SIXTH**: Actually you don't need to execute script as it is. I tried to write it in
 certain style to make it easy to copy-paste into terminal only necessary separate
 parts. I also commented some of issues and peculiarities further to offer an opportunity
 to change some steps in case they cause problems. Also, the complete installation can
 take a long time: a day, two, or even three.

 Please note that after installation, a system reboot may be required for actions such
 as .profile or .bashrc changes to take effect.

 Last change: 26.11.2024
 Tested: 26.11.2024.
 Good luck!


##           USAGE:
 chmod +x ./Godot_LinuxLibsInstaller.sh
 ./Godot_LinuxLibsInstaller.sh -------> to execute script.


 gedit Godot_LinuxLibsInstaller.sh ---> to show and edit script
					(there a lot of comments, you may find
                                        a solution for some issues inside.)


##           OPTIONS:
 Linux --------------> Install all packages mentioned on \"Compiling for Linux, *BSD\"
                       page of official Godot documentation including additional.
                       Note that by default (without Linux, macOS or iOS option)
                       this script will install packeges for every of those three.

 macOS --------------> Install all packages mentioned on \"Compiling for macOS\"
                       page of official Godot documentation including additional.
                       Note that by default (without Linux, macOS or iOS option)
                       this script will install packeges for every of those three.

 DeleteGarbage ------> This option will delete all garbage (temprorary files and arcives
		       that were downloaded or compiled in the proccess.) By default it
		       turned off 'couse in case of error you may wanna those files to be
                       saved. NOTE THAT YOU NEED TO SPECIFY OTHER OPTIONS LIKE LINUX OR
		       MACOS, OTHERWISE SCRIPT WILL ONLY LOOK FOR GARBAGE WITHOUT
                       DOWNLOADING AND INSTALLING LIBRARIES.


##           EXEMPLE OF OPTIONS USING:
 ./Godot_LinuxLibsInstaller.sh Linux Mac DeleteGarbage -----> You can combine several
                                                              options by writing it after
                                                              the script name.

 Probably you will need chmod +x ./Godot_LinuxLibsInstaller.sh command first to make
 script executable.

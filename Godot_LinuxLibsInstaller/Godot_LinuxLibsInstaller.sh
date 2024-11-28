help()
{
echo "
Ok', here instruction, which you can use on Linux to install all required apps
and packages for compiling Godot 4.3 on Linux, which I managed to make work.
It should really simplifiy all the process.

For installation you need a stable internet-connection and enough memory
(for exemple, all stuff for Mac may require 45 GB of temporal files).

FIRST: This script actually unofficial and is a result of nearly a month of my
web-surfing and experimenting with libraries. You can do with it anithing you
want (modify, copy, distribute, build dockers, etc.)
I do not recommend it to use on your main work-station, as I can’t give any
guarantees this won't break something in your system options. I used virtual
machine (via VirtualBox software https://www.virtualbox.org/ ) for this purpose.

SECOND: As stated in the official documentation:

              \"Linux binaries usually won't run on distributions that are older
              than the distribution they were built on. If you wish to distribute
              binaries that work on most distributions, you should build them on
              an old distribution such as Ubuntu 16.04. You can use a virtual
              machine or a container to set up a suitable build environment.\"

 So for \"Compiling for Linux, *BSD\"-part I used Ubuntu 16.04.7 as it were
 recommended. (You can get it here: https://releases.ubuntu.com/xenial/ ) Some of
 libriries installing by this script due to necessity have outdated versions. On the
 newer versions of Linux you can get much simper way to install the same libraries of
 newer versions, but Ubuntu 16.04 have a lot of difficultis on it. I tested it on
 64-bit and 32-bit Ubuntu (there is a big problem with cross-compilation for
 different bit-arcitectures). It all seemed to work normal, except \"Cross-compiling for
 RISC-V devices\" and \"Using Pyston for faster development\".
 
 THIRD: For \"Cross-compiling for RISC-V devices\" check description inside the script!
 For \"Using Pyston for faster development\" note, that I didn't managed to compile  it
 for 32-bit OS.
 
 FORTH: For \"Compiling for macOS (Cross-compiling from Linux)\"-part testing I tried
 modern Ubuntu-20.04 and IT DOESN'T WORK ON IT AT ALL\!\!! I mean... After all issues
 solving I still got a linking error at the very end of Godot cross-compilation.
 Instead I reccomend to use this dockers https://github.com/godotengine/build-containers,
 which didn't worked on Ubuntu-20.04 for me either — install Fedora-36 straightaway.
 So... You still could try to test MAC-part of my script on any Linux version you like,
 but I can't say whether it will work or not. Anyway — all the steps seem to have been
 done properly. I'd be glad to know the results of your own check!

 FIFTH: This script doesn't have part for \"Compiling for iOS\".

 SIXTH: Actually you don't need to execute script as it is. I tried to write it in
 certain style to make it easy to copy-paste into terminal only necessary separate
 parts. I also commented some of issues and peculiarities further to offer an opportunity
 to change some steps in case they cause problems. Also, the complete installation can
 take a long time: a day, two, or even three.

 Please note that after installation, a system reboot may be required for actions such
 as .profile or .bashrc changes to take effect.

 Last change: 26.11.2024
 Tested: 26.11.2024.
 Good luck!


           USAGE:
 ./Godot_LinuxLibsInstaller.sh -------> to execute script.


 gedit Godot_LinuxLibsInstaller.sh ---> to show and edit script
					(there a lot of comments, you may find
                                        a solution for some issues inside.)


           OPTIONS:
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


           EXEMPLE OF OPTIONS USING:
 ./Godot_LinuxLibsInstaller.sh Linux Mac DeleteGarbage -----> You can combine several
                                                              options by writing it after
                                                              the script name.

 Probably you will need chmod +x ./Godot_LinuxLibsInstaller.sh command first to make
 script executable.
"
}

# Options setup:
cd $( dirname -- "$( readlink -f -- "$0"; )"; ) #(change folder to the script folder)
ALL_INCLUDED=true
LINUX_INCLUDED=false
MACOS_INCLUDED=false
IOS_INCLUDED=false
SAVE_SETUP_GARBAGE=true
OPT=( "${@}" )
for i in ${OPT[@]}; do
	case $i in 
		--help|-help|help|h|-h)
			help
			exit;;
		Linux|linux|LINUX)
			ALL_INCLUDED=false
			LINUX_INCLUDED=true;;
		macOS|macos}MACOS)
			ALL_INCLUDED=false
			MACOS_INCLUDED=true;;
		iOS|ios|IOS)
			ALL_INCLUDED=false
			IOS_INCLUDED=true;;
		DeleteGarbage)
			ALL_INCLUDED=false
			SAVE_SETUP_GARBAGE=false;;
		\?)
			echo "Error: Invalid option"
			exit;;
	esac
done
(! command -v uname -i) && sudo apt-get install coreutils # if "uname" command absent
(! command -v wget) && sudo apt-get install wget # if "wget" command absent




#   _____                      _ _ _                __           
#  / ____|                    (_) (_)              / _|          
# | |     ___  _ __ ___  _ __  _| |_ _ __   __ _  | |_ ___  _ __ 
# | |    / _ \| '_ ` _ \| '_ \| | | | '_ \ / _` | |  _/ _ \| '__|
# | |___| (_) | | | | | | |_) | | | | | | | (_| | | || (_) | |   
#  \_____\___/|_| |_| |_| .__/|_|_|_|_| |_|\__, | |_| \___/|_|   
#                       | |                 __/ |                
#  _      _             |_|         _    __|___/_____ _____      
# | |    (_)                     /\| |/\|  _ \ / ____|  __ \   _ 
# | |     _ _ __  _   ___  __    \ ` ' /| |_) | (___ | |  | | (_)
# | |    | | '_ \| | | \ \/ /   |_     _|  _ < \___ \| |  | |    
# | |____| | | | | |_| |>  < _   / , . \| |_) |____) | |__| |  _ 
# |______|_|_| |_|\__,_/_/\_( )  \/|_|\/|____/|_____/|_____/  (_)
#                           |/                                   
# https://docs.godotengine.org/en/stable/contributing/development/compiling/compiling_for_linuxbsd.html
#
if ( $ALL_INCLUDED ) || ( $LINUX_INCLUDED ) then

#sudo apt-get install build-essential -y
# Uncomment this string and comment all gcc installing part if you
# sure that standart apt-get will provide right version (works on
# Ubuntu 20.04.3 for exemple.)

# gcc installing part:
sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y #(This is for installation of gcc-9 and g++-9)
sudo apt-get update
GCC_VERS=9
# Note that GCC < 12.1 can have some peculiarities with Mold, but itcan't be installed this way for Ubuntu-16. Read the Mold part for details.
sudo apt-get install -y \gcc-$GCC_VERS \g++-$GCC_VERS -y
[ ! -d "$HOME/.local/bin" ] && mkdir $HOME/.local/bin && echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> ~/.bashrc
export PATH="$HOME/.local/bin:$PATH"
ln -s /usr/bin/gcc-$GCC_VERS $HOME/.local/bin/gcc #(This is for recognizing gcc-9 as standart gcc)
ln -s /usr/bin/g++-$GCC_VERS $HOME/.local/bin/g++
sudo apt remove gcc -y # SORRY, BUT I DON'T KNOW HOW TO SOLVE SOME OF ERRORS, WHEN COMPILLERS JUST CAN'T FIND NEWER GCC VERSION!

sudo apt-get install -y \
  build-essential \
  pkg-config \
  libx11-dev \
  libxcursor-dev \
  libxinerama-dev \
  libgl1-mesa-dev \
  libglu1-mesa-dev \
  libasound2-dev \
  libpulse-dev \
  libudev-dev \
  libxi-dev \
  libxrandr-dev \
  libwayland-dev
sudo apt-get upgrade

# Next we install Python-3.7.
#
# You actually can change the version number, and it would
# install 3.6 or 3.8 as well as 3.7, but note that:
#
# -------- 3.6 is the minimal version required by official Godot documentation
#          for Godot 4.3,
# -------- Scons output will warning you, that Python-3.7+ recommended,
# -------- Version of get-pip.py script, which will be used in in this instruction,
#          didn't work with Python-3.8.
#
# Also, if the following did not work, you could try some
# of other methods to install Python, described later.
#
## If you sure, that you can get Python of suitable version via standart
# methods, then comment all next strings about Python and pip installing and
# try to use next:
# sudo apt install python3
# sudo apt install python3-pip
sudo add-apt-repository -y ppa:jblgf0/python
sudo apt-get update
sudo apt-get install -y python3.7 -y

# NEXT YOU NEED TO HAVE THE GET-PIP.PY, WITCH WILL WORK WITH PYTHON-3.7.
# IT SHOULD BE IN THIS SCRIPT'S FOLDER INITIALLY. IF YOU MISSED IT, TRY
# TO FIND VERSION OF GET-PIP.PY BY YOURSELF, BUT YOU MAY ENCOUNTER SOME
# PROBLEMS FURTHER.
python3.7 $(dirname "${BASH_SOURCE[0]}")/get-pip2.py
pip3.7 install scons

# The next commands just add some instructions to Linux-autoload-scripts.
# It makes scons command replaced by scons wayland=no in console by default.
# Otherwise you will need to use "scons wayland=no platform=linuxbsd" instead of
# "scons platform=linuxbsd" any time you want to compile Godot. Wayland linking
# works on an Ubuntu-22.04.3, but it led to the error on Ubuntu-16.04. I think
# my solution to this is a creepy crutch, but other methods (including changing
# $XDG_SESSION_TYPE from Wayland to x11/Xorg) didn't help to change default scons
# option in this manner, and I don't know straight way to fix wayland-linker for
# old Ubuntu. However, don't think about it too much, it works just as the normal
# scons if you wanna add wayland=yes to it for some reason.
#
# If you wanna undo this changes then use gedit ~/.bashrc in console and delete
# the corresponding lines that were added to the end of the file.
echo "alias scons=\"scons wayland=no\"" >> ~/.bashrc
alias scons="scons wayland=no"



# "USING CLANG AND LLD FOR FASTER DEVELOPMENT":
#
#
#sudo apt-get install clang # Not recommended due to installation of an outdated version!
#
#
# Ok, and now a faster ALTERNATIVE way for Clang installing, wich don't work on Ubuntu-16. If you're using newer OS version, you should try commented code below instead of everything other code from this section.
# Next packages is for Clang installing. Official documentation states that
# version 16 is required as minimum, but here you can insert 17 or 18 either.
# I choosed 18.
#wget https://apt.llvm.org/llvm.sh -c
#chmod +x llvm.sh
#sudo ./llvm.sh 18
#[ ! -d "$HOME/.local/bin" ] && mkdir $HOME/.local/bin && echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> ~/.bashrc
#export PATH="$HOME/.local/bin:$PATH"
#ln -s /usr/bin/clang-18 $HOME/.local/bin/clang
#ln -s /usr/bin/clang++-18 $HOME/.local/bin/clang++
#
#
sudo apt-get install -y libssl-dev
# We need to compile a lot, becouse you can't download clang for 32-bit. You need to compile
# it with cmake, which is also need to be compiled for 32-bit system.
# Also thanks to solution in https://gist.github.com/bmegli/4049b7394f9cfa016c24ed67e5041930
wget https://github.com/Kitware/CMake/releases/download/v3.20.0/cmake-3.20.0.tar.gz
tar -zvxf cmake-3.20.0.tar.gz
cd ./cmake-3.20.0
./bootstrap
sudo apt-get install -y checkinstall
sudo checkinstall --pkgname=cmake --pkgversion="3.20-custom" --default
hash -r
cd ../

wget https://github.com/llvm/llvm-project/archive/refs/tags/llvmorg-18.1.8.tar.gz -c
tar -xvzf llvmorg-18.1.8.tar.gz -C ./
cp -r ./llvm-project-llvmorg-18.1.8/clang ./llvm-project-llvmorg-18.1.8/llvm/tools
sudo apt remove gcc -y # SORRY, BUT I DON'T KNOW HOW TO SOLVE SOME OF ERRORS, WHEN COMPILLERS JUST CAN'T FIND NEWER GCC VERSION!
# If you still see an error that c++ and cc and gcc compiler not found, then you don't installed gcc-9 and g++-9,
# or didn't create links for your system to recognize gcc-9 and g++-9 as gcc and g++.
# Note that both of it were done at the begining of this script.
mkdir ./llvm-project-llvmorg-18.1.8/llvm/LLVM-build
cmake -S ./llvm-project-llvmorg-18.1.8/llvm -B ./llvm-project-llvmorg-18.1.8/llvm/LLVM-build -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_PROJECTS="clang;lld" -DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi;libunwind"
# -DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi;libunwind" is necessary if you are going for compiling Mold for 32-bit system.
# Otherwise you can erase it.
cd ./llvm-project-llvmorg-18.1.8/llvm/LLVM-build
sudo make install -j`nproc` # this is really long step!!! It took a lot of time for my laptop (4 cores) to compile.
# Also note that it took 15,3 GB (7,4 GB after delleting llvm-project-llvmorg-18.1.8 temporal folder.)
# Be patient or find another way faster (probably this installation is superfluous, full llvm project
# or smth like this). Anyway it works and I'm too laze to fix it.
sudo ldconfig /usr/local/lib/i686-pc-linux-gnu/
#clang -v # to check if clang installed
cd ./../../../



# "USING MOLD FOR FASTER DEVELOPMENT":
#
#
if [[ $(uname -i) == "x86_64" ]] # for 64-bit:
then
	MOLD_PATH=$HOME/.local/share # Path the same as in Godot documentation to reduce confusion of user.

	[ ! -d "$MOLD_PATH" ] && mkdir $MOLD_PATH
	wget "https://github.com/rui314/mold/releases/download/v2.34.1/mold-2.34.1-x86_64-linux.tar.gz" -c
	tar -xvzf mold-2.34.1-x86_64-linux.tar.gz -C $MOLD_PATH
	mv $MOLD_PATH/mold-2.34.1-x86_64-linux $MOLD_PATH/mold
	echo "export PATH=\"$MOLD_PATH/mold/bin:\$PATH\"" >> ~/.bashrc
	export PATH="$MOLD_PATH/mold/bin:$PATH"
	sudo mkdir /usr/lib/mold
	sudo ln $MOLD_PATH/mold/bin/mold /usr/lib/mold/ld
	# The last two strings becouse... Just check godot-4.3-stable/platform/linuxbsd/detect.py in the Godot sources.
	# I don't know why, but official Godot documentation certanly wrong about the way where scons looking
	# for Mold. According to detect.py it looks for it ONLY in /usr/libexec", "/usr/local/libexec", "/usr/lib"
	# and "/usr/local/lib". Otherwise terminale will show "ERROR: Couldn't locate mold installation path. Make sure
	# it's installed in /usr or /usr/local."
	# I suppose, that's becouse Godot developers using GCC >= 12.1 (it enebles -fuse-ld=mold instead of default mold
	# setting.)
fi

if [[ $(uname -i) != "x86_64" ]]  # for 32-bit: (We will compile it from sources.)
then
	# I didn't find how to choose the installation folder for automatic installation,
	# so it will install Mold into different folder than previous method.
	wget https://github.com/rui314/mold/archive/refs/tags/v2.34.1.tar.gz -c
	tar -xvzf v2.34.1.tar.gz
	cd ./mold-2.34.1
	# Here you should install Clang with libc++, if you didn't (it was above!)
	# (look into README.md inside Mold sources for alternative ways of compilation via gcc).
	sudo ./install-build-deps.sh
	cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_CXX_FLAGS=-stdlib=libc++ -B build
	#cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=g++-10 -B build #instead of previous, if you're using gcc-10 or newer.
	cmake --build build -j$(nproc)
	sudo cmake --build build --target install
	cd ./../
	# If at the end of Godot compilation with Mold as a linker you got an "error while loading shared libraries: libc++.so.1",
	# then you should enter next command:
	#	sudo ldconfig /usr/local/lib/i686-pc-linux-gnu/
	# or, if it doesn't work, you should find libc++.so.1 via standart file manager's search, and use command
	#	sudo ldconfig <paste_path_to_the_folder_with_libc++.so.1_here>
	# If you dont' have such file, it means that you made some mistakes at the Clang compiling settings and you
	# need to return to that part to recompile Clang.
fi



# "CROSS-COMPILING FOR RISC-V DEVICES":
#
#
# You should also do all actions from "Using Clang and LLD for faster development",
# if you skipped it. (Is it really needed? I'm in doubt...)
#
# You should also do all actions from "Using Mold for faster development",
# if you skipped it.
#
# NOTE: Riscv-GNU-Toolchain is 64-bit architecture only (despite
# riscv64-glibc-ubuntu-20.04-nightly-2023.06.09-nightly.tar.gz existance, it is a cross-compiler from
# 64-bit Ubuntu to 32-bit RISC-V, if I get it right,) and — moreover, scons compiling system for Godot
# doesn't have any option for rv32: rv64 only!
#
# IMPORTANT! I managed to make it work on Ubuntu-20.04, but not on Ubuntu-16.04.
#
if [[ $(uname -i) == "x86_64" ]]
then
	wget "https://github.com/riscv-collab/riscv-gnu-toolchain/releases/download/2023.06.09/riscv64-glibc-ubuntu-20.04-nightly-2023.06.09-nightly.tar.gz" -c # 64-bit
	tar -xvzf riscv64-glibc-ubuntu-20.04-nightly-2023.06.09-nightly.tar.gz -C $HOME
	echo "export RISCV_TOOLCHAIN_PATH=\"\$HOME/riscv\"" >> ~/.bashrc
	export RISCV_TOOLCHAIN_PATH="$HOME/riscv"
fi

#
# Although not required in the documentation, using RISCV-toolchain requires
# adding its bin folder to the PATH. Since this conflicts with the installed
# version of Clang, I recommend adding it to the PATH every time you
# compile Godot as follows:
#
#	export PATH=$RISCV_TOOLCHAIN_PATH/bin:$PATH
#	scons arch=rv64 use_llvm=yes linker=mold lto=none target=editor \
#	ccflags="--sysroot=$RISCV_TOOLCHAIN_PATH/sysroot --gcc-toolchain=$RISCV_TOOLCHAIN_PATH -target riscv64-unknown-linux-gnu" \
#	linkflags="--sysroot=$RISCV_TOOLCHAIN_PATH/sysroot --gcc-toolchain=$RISCV_TOOLCHAIN_PATH -target riscv64-unknown-linux-gnu"
#
# If you want to make this change permanent, use the line
#	echo "export PATH=\$RISCV_TOOLCHAIN_PATH/bin:\$PATH" >> ~/.bashrc.
#
# In addition, the official Godot documentation says: "the older the toolchain,
# the more compatible our final binaries will be", and recommends installing
# version 2021.12.22-ubuntu-18.04. But this script installs version 2023.06.09-ubuntu-20.04,
# since this is the oldest version with which I was able to compile Godot. For
# newer ones I get the error
# 	mold: fatal: huf_decompress_amd64.linuxbsd.editor.rv64.llvm.o: incompatible file type: riscv64 is expected but got x86_64
# Most likely, a more correct way to install the necessary tools exists
# (I suspect, related to configuring Clang). It should also be noted that I did
# not check the functionality of the resulting Godot builds, and given the content
# of the forms on this topic, there is a high chance that they won't even start.
#
# NOW SOME OF MY SUFFERINGS.
# Trying to setup riscv-toolchain on Ubuntu-16.04 I got those errors:
# 	clang++: error while loading shared libraries: libtinfo.so.6: cannot open shared object file: No such file or directory
# Solving this problem via https://forum.cardano.org/t/ghc-install-libtinfo-so-6-cannot-open-shared-object-file/61888/3
# gave me another errors, which I couldn't solve (and as it seems, I broke all the programs, including Clang.)
#	clang++: /lib/x86_64-linux-gnu/libm.so.6: version `GLIBC_2.27' not found (required by clang++)
#	clang++: /lib/x86_64-linux-gnu/libm.so.6: version `GLIBC_2.29' not found (required by clang++)
# Maybe this can be useful... https://stackoverflow.com/questions/72513993/how-to-install-glibc-2-29-or-higher-in-ubuntu-18-04



# "USING SYSTEM LIBRARIES FOR FASTER DEVELOPMENT":
#
#
sudo apt-get update
sudo apt-get install -y \
  libembree-dev \
  libenet-dev \
  libfreetype-dev \
  libpng-dev \
  zlib1g-dev \
  libgraphite2-dev \
  libharfbuzz-dev \
  libogg-dev \
  libtheora-dev \
  libvorbis-dev \
  libwebp-dev \
  libmbedtls-dev \
  libminiupnpc-dev \
  libpcre2-dev \
  libzstd-dev \
  libsquish-dev \
  libicu-dev
# Note that for 32-bit system there is such error as:
#      "Impossible to find libembree-dev package
# 	Impossible to find libfreetype-dev package
# 	Impossible to find libsquish-dev package"
# And there is no solution presented in this script. 32-bit for those not supported.



#"USING PYSTON FOR FASTER DEVELOPMENT"
#
#
# We going to build it from source, becouse we can't get it for Ubuntu-16 with a symple ways.
# Anyway, I left an alternative installation method in 'extras' at the bottom of this script
# for those who want to experiment with more recent versions of Linux.
#
if [[ $(uname -i) == "x86_64" ]] # it seems that pyston can be compiled for 64-bits systems ONLY.
then
	sudo apt-get install -y build-essential git libssl-dev libsqlite3-dev luajit python3.8 zlib1g-dev virtualenv libjpeg-dev linux-tools-common linux-tools-generic linux-tools-`uname -r`
	#sudo apt-get install cmake clang # Note that cmake and clang were compiled above to have newer versions that you could get by apt-get. It may be necessery to choose the compiling way of installing if you're using old Ubuntu version, this part wasn't checked with older versions of those. If for some reason you don't want to compile them, you should uncommit this line.
	sudo apt-get install -y libwebp-dev libjpeg-dev python3.8-gdbm python3.8-tk python3.8-dev tk-dev libgdbm-dev libgdbm-compat-dev liblzma-dev libbz2-dev nginx rustc time libffi-dev
	sudo apt-get install -y dh-make dh-exec debhelper patchelf
	git clone https://github.com/pyston/pyston.git
	cd ./pyston
	sudo rm /usr/bin/python3
	sudo ln -s /usr/bin/python3.8 /usr/bin/python3
	sudo apt install curl
	git submodule update --init pyston/llvm pyston/bolt pyston/LuaJIT pyston/macrobenchmarks
	for i in {1..7}; do make -j`nproc`; done # For some reason it required for me to call make for five times to compile Pyston accurate. Just in case, the number 7 was chosen here. Don't worry about it, all parts that were compiled at previous iterations won't be recompiled from scratch.
	PYSTON_PATH=$HOME/.local/opt # the path to directory where pyston will be installed (I left the same path as in Godot documentation were suggested.)
	mv ./build/bc_install $PYSTON_PATH
	[ ! -d "$HOME/.local/bin" ] && mkdir $HOME/.local/bin
	echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> ~/.bashrc
	export PATH="$HOME/.local/bin:$PATH"
	ln -s $PYSTON_PATH/bc_install/usr/bin/pyston $HOME/.local/bin/pyston
	cd ./..
	#
	# Next we installing pyston-scons:
	pyston $(dirname "${BASH_SOURCE[0]}")/get-pip2.py # get-pip2.py should be in this script's folder
	sudo apt-get install python3.8-gdbm
	#pyston -m pip install --upgrade pip # hmmmm...
	pyston -m pip install scons
	for name in scons scons-configure-cache sconsign; do ln -s $PYSTON_PATH/bc_install/usr/bin/$name $HOME/.local/bin/pyston-$name; done
	echo "alias pyston-scons=\"pyston-scons wayland=no\"" >> ~/.bashrc
	alias pyston-scons="pyston-scons wayland=no"
	# The reason for this alias the same as for alias scons="scons wayland=no" (look for an explanation of it far-far above, where an ordinary scons were installing.)
	#
	# Now you can use pyston-scons command similar to the ordinary scons command, but with Pyston.
	#
	# SOME ADVICE: It's probable to got some mess with scons links, if you were making some steps by youreself instead of this script variant or use different OS version. Then you may need to edit links, which were spoild in the process, by yourself (for exemple you may need to replace "#!/usr/bin/python" to "#!/usr/bin/python3.7" or "#!/usr/bin/python3.8-pyston2.3" inside the link.)
fi







fi

#------------------------------------------------------------------------------------------
#   _____                      _ _ _                __           
#  / ____|                    (_) (_)              / _|          
# | |     ___  _ __ ___  _ __  _| |_ _ __   __ _  | |_ ___  _ __ 
# | |    / _ \| '_ ` _ \| '_ \| | | | '_ \ / _` | |  _/ _ \| '__|
# | |___| (_) | | | | | | |_) | | | | | | | (_| | | || (_) | |   
#  \_____\___/|_| |_| |_| .__/|_|_|_|_| |_|\__, | |_| \___/|_|   
#                       | |                 __/ |                
#                       |_|__   _____      |___/                 
#                       / __ \ / ____|  _                        
#  _ __ ___   __ _  ___| |  | | (___   (_)                       
# | '_ ` _ \ / _` |/ __| |  | |\___ \                            
# | | | | | | (_| | (__| |__| |____) |  _         (Cross-compiling for macOS from Linux)               
# |_| |_| |_|\__,_|\___|\____/|_____/  (_) 
#
# https://docs.godotengine.org/en/stable/contributing/development/compiling/compiling_for_macos.html
#
# All part above is unreliable. (Look into "help section" for details.)
#
if ( $ALL_INCLUDED ) || ( $MAC_INCLUDED ) then



# OSXCross installing:
wget "https://github.com/tpoechtrager/osxcross/archive/refs/heads/master.zip" -c
[ ! -d "$HOME/osxcross" ] && mkdir $HOME/osxcross
unzip master.zip -d $HOME/osxcross
echo "export OSXCROSS_ROOT=\"\$HOME/osxcross/osxcross-master\"" >> ~/.bashrc
export OSXCROSS_ROOT="$HOME/osxcross/osxcross-master"



# 1) Package the SDK:

echo -e "
\n\n TO INSTALL \"COMPILING FO MACOS\" STUFF YOU NEED TO DOWNLOAD XCODE BY YOURSELF\!\!\!\n
 To do it, you should download it from here: https://developer.apple.com/download/all/?q=xcode
 (register in Apple-Id needed) and then PUT THE .XIP FILE INTO FOLDER WHERE THIS SCRIPT IS.
 
 For checking I used Ubuntu-20.04 and Xcode-16.0.
 
 Also WARNING: SDK's installing requires 16 Gb in addition to 3 Gb of xip file."
while (true) do
echo -e "\nPress ENTER when you ready to continue or ESC to skip MacOS-part:"
read -s -N 1 input
case $input in $'\x0a' ) break;; $'\e') MAC_INCLUDED=false; break;; * ) ;; esac done



# ignore next string, it's script technical.
fi if ( $ALL_INCLUDED ) || ( $MAC_INCLUDED ) then



# Method for Xcode of version > 8.0 (for other versions see "Packing the SDK
# on Linux" here https://github.com/tpoechtrager/osxcross#packaging-the-sdk )
wget https://apt.llvm.org/llvm.sh -c
chmod +x llvm.sh
sudo ./llvm.sh 18
[ ! -d "$HOME/.local/bin" ] && mkdir $HOME/.local/bin && echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> ~/.bashrc
export PATH="$HOME/.local/bin:$PATH"
ln -s /usr/bin/clang-18 $HOME/.local/bin/clang
ln -s /usr/bin/clang++-18 $HOME/.local/bin/clang++

sudo apt-get install -y \
  make \
  libssl-dev \
  lzma-dev \
  libxml2-dev \
  cmake \
  git \
  liblzma-dev \
  libbz2-dev
  #clang # Instructions for Clang installing were in the Linux-Compilation part.
  
$OSXCROSS_ROOT/tools/gen_sdk_package_pbzx.sh $(find . -name 'Xcode*.xip')
# If you have "bzip2 support not compiled in" error, then just delete whole osxcross
# folder from your $HOME and reinstall it (repeat few last steps).

mv $(find $OSXCROSS_ROOT -name 'MacOSX??\.sdk\.tar\.xz') $OSXCROSS_ROOT/tarballs
mv $(find $OSXCROSS_ROOT -name 'MacOSX??\.?\.sdk\.tar\.xz') $OSXCROSS_ROOT/tarballs



# 2)Installing OSXCross:

sudo apt-get install -y \
  patch \
  python3 \
  cpio \
  zlib1g-dev \
  bash
#  libplist-utils
sudo apt-get install -y llvm-dev # it's optional for Link Time Optimization support and for ld64 -bitcode_bundle support
sudo apt-get install -y uuid-dev # it's optional for ld64 -random_uuid support
  
#if CMake version < 3.2.3 then
#curl -sSL https://cmake.org/files/v3.14/cmake-3.14.5-Linux-x86_64.tar.gz | sudo tar -xzC $HOME/.local/opt
#echo "export PATH=\$HOME/.local/opt/cmake-3.14.5-Linux-x86_64/bin:\$PATH" >> ~/.bashrc
#export PATH=$HOME/.local/opt/cmake-3.14.5-Linux-x86_64/bin:$PATH

# Downhere we get the version number of XCode package
SDK_VERSION=$(echo $(find $OSXCROSS_ROOT/tarballs -name 'MacOSX??\.sdk\.tar\.xz') | tr -cd '[[:digit:]]') $OSXCROSS_ROOT/build.sh -y
# If you have an error that "<some-number> bytes of body are still expected", then change your internet-connection.

echo "export PATH=\$OSXCROSS_ROOT/target/bin:\$PATH" >> ~/.bashrc
export PATH=$OSXCROSS_ROOT/target/bin:$PATH

wget "https://github.com/KhronosGroup/MoltenVK/releases/download/v1.2.6/MoltenVK-all.tar"
tar -xf MoltenVK-all.tar -C $HOME
echo "export vulkan_sdk_path=\$HOME/MoltenVK/MoltenVK" >> ~/.bashrc
export vulkan_sdk_path=$HOME/MoltenVK/MoltenVK
#Solution got from here: https://www.reddit.com/r/godot/comments/1af8nk1/compiling_on_macos/
#$OSXCROSS_ROOT/build_compiler_rt.sh


# To compile Godot for MacOS, use
#	scons platform=macos vulkan_sdk_path=$HOME/MoltenVK osxcross_sdk=darwin24
# Note that darvin version you may find in names of files inside $OSXCROSS_ROOT/target/bin.
# It could be different.



fi

#------------------------------------------------------------------------------------------
if !( $SAVE_SETUP_GARBAGE )
then


	# DELETE ALL DOWNLOADED GARBAGE
	#
	#
	# Use DeleteGarbage option if you wanna delete
	# all those downloaded archives on your computer.
	sudo rm ./mold-2.34.1-x86_64-linux.tar.gz
	sudo rm -r ./mold-2.34.1
	sudo rm ./v2.34.1.tar.gz
	sudo rm ./riscv64-glibc-ubuntu-20.04-nightly-2023.06.09-nightly.tar.gz
	sudo rm -r ./llvm-project-llvmorg-18.1.8
	sudo rm $HOME/glibc/glibc-2.27.tar.gz
	sudo rm ./pyston_2.3.5_portable_amd64.tar.gz
	sudo rm ./pyston_2.3.5.tar.gz
	sudo rm ./llvm.sh
	sudo rm ./master.zip
	sudo find $OSXCROSS_ROOT/tarballs -name -delete 'MacOSX??\.sdk\.tar\.xz'
	sudo find $OSXCROSS_ROOT/tarballs -name -delete 'MacOSX??\.?\.sdk\.tar\.xz'
	sudo rm $HOME/glibc/glibc-2.27.tar.gz
	sudo rm ./cmake-3.20.0.tar.gz
	sudo rm -r ./cmake-3.20.0
	sudo rm -r ./pyston-pyston_2.3.5
	sudo rm ./llvmorg-18.1.8.tar.gz
	sudo rm ./MoltenVK-all.tar
	sudo rm -r ./pyston
	sudo apt autoremove -y



fi


# Next command will reboot Ubuntu. Uncomment it (delete #), if you wanna to reboot
# automaticaly. Note that you probably will loose all the console output, and it
# will be harder to find problemmatic strings if errors occur.
#
#sudo reboot
#
echo -e "\n\nLINUX REBOOT REQUIRED!\n\n"


exit 0


------------------------------------------------------------------------------------------
And now some extras.

ALTERNATIVE PYTHON SETUP VARIANTS:

sudo apt-get install aptitude
aptitude search python3
sudo apt-get install python3.7

sudo add-apt-repository -y ppa:jblgf0/python
sudo apt-get update
sudo apt-get install python3.7

sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt install python3.7

conda install python==3.7

------------------------------------------------------------------------------------------

IF YOU HAVE TROUBLES WITH VERSIONS, TRY DO SOME OF THIS:

# Show installed version of package.
g++ --version
g++ -v

# Set program as main alternative for a command.
# First path is where soft links stored
# (it's the first path printed after sudo update-alternatives --display <name> printed)
# Next is command name and the second path is a path to an alternative.
# The number at the end is priority (the greater number = the higher priority.)
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 10000
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 10000
sudo update-alternatives --install /usr/bin/python2.7 python /usr/bin/python3.7 10000
sudo update-alternatives --install /usr/bin/python3.5m python3 /usr/bin/python3.7 10000
sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-18 10000

sudo update-alternatives --display python # Show list of alternatives.
type -a clang # Show directory path to the command
whereis clang # Show directory path to the command

------------------------------------------------------------------------------------------

# If you want to test Godot launchability on your Linux, but it suddenly shuts down,
# the deal is more likely with grafical API. However you can try to execute Godot via
# terminal this way: ./godot.linuxbsd.editor.x86_64 --rendering-driver opengl3
# It makes Godot use Opengl3 instead of Vulkan. This solution works pretty well on
# Ubuntu-22.04, but have CRITICAL rendering errors on Ubuntu-16.04.
#
# It seems that Vulcan don't work at VirtualBox at all.
# More on this issue: https://github.com/godotengine/godot/issues/78961
#                     https://github.com/actions/runner-images/issues/2998


# If you using real machine, there is VULKAN DRIVERS installing:
if [[ $(lspci | grep -i '.* vga .* nvidia .*') == *' nvidia '* ]]; then # checks if Nvidia supported.
	# NVIDIA:
	sudo add-apt-repository ppa:graphics-drivers/ppa
	sudo apt upgrade
	sudo apt install nvidia-graphics-drivers-396 nvidia-settings vulkan vulkan-utils -y
else
	# AMD:
	sudo add-apt-repository ppa:oibaf/graphics-drivers
	sudo apt update
	sudo apt upgrade
	sudo apt install libvulkan1 mesa-vulkan-drivers vulkan-utils -y
fi
# More deteiled instructions: https://linuxconfig.org/install-and-test-vulkan-on-linux

------------------------------------------------------------------------------------------
#"USING PYSTON FOR FASTER DEVELOPMENT" (alternative, 64-bit only, don't work on Ubuntu-16.04)
#
#
#Firstly installing for GLIBC, 'couse Pyston requires GIBC_2.25, GLIBC_2.26 or GLIBC_2.27
#Important:
# "Updating glibc to a version that is not standard for your distribution is not so easy, since
# practically everything else on the system will depend on the current version. It's probably much
# less trouble to upgrade the whole system to 18.04 (which uses glibc 2.27)"
#Source: https://stackoverflow.com/questions/59145051/glibc-2-27-not-found-ubuntu-16-04
#
#So... I haven't figured out how to make this work. I'm leaving it as an UNFINISHED ALTERNATIVE.

mkdir $HOME/glibc/
cd $HOME/glibc
wget http://ftp.gnu.org/gnu/libc/glibc-2.27.tar.gz
tar -xvzf glibc-2.27.tar.gz
mkdir build
mkdir glibc-2.27-install
cd build
sudo apt install -y gawk
sudo apt install -y bison
#sudo apt install -y texinfo
~/glibc/glibc-2.27/configure --prefix=$HOME/glibc/glibc-2.27-install --disable-werror
# Solution from here: https://stackoverflow.com/questions/68935965/glibc-compiling-error-with-error-ei-errno-location-specifies-less-restri
make
make install
#
#
cd $( dirname -- "$( readlink -f -- "$0"; )"; ) #(RETURN TO THE SCRIPT FOLDER)
#
#
# And now Pyston:
[ ! -d "$HOME/.local/opt" ] && mkdir $HOME/.local/opt
# If you using other system version or specific device
# then CHANGE THE LINK AND FILENAMES BELOW!!!
# You should take link from here: https://github.com/pyston/pyston/releases/tag/pyston_2.3.5
#
if [[ $(uname -i) == "x86_64" ]] # for 64-bit
then
	wget "https://github.com/pyston/pyston/releases/download/pyston_2.3.5/pyston_2.3.5_portable_amd64.tar.gz" -c
	tar -xvzf pyston_2.3.5_portable_amd64.tar.gz -C $HOME/.local/opt
	$HOME/.local/opt/pyston_2.3.5/pyston $(dirname "${BASH_SOURCE[0]}")/get-pip2.py # get-pip2.py should be in this script's folder
	$HOME/.local/opt/pyston_2.3.5/pyston -m pip install scons
	[ ! -d "$HOME/.local/bin" ] && mkdir $HOME/.local/bin
	echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> ~/.bashrc
	ln -s $HOME/.local/opt/pyston_2.3.5/bin/scons $HOME/.local/bin/pyston-scons
	PATH="$HOME/.local/bin:$PATH"
	export PATH

else # for 32-bit
	echo -e "\n\n    FOR PYSTON INSTALLATION FOR 32-BIT YOU NEED TO COMPILE IT BY YOURSELF!
	   YOU CAN DOWNLOAD SOURCES AND INSTRUCTIONS HERE:
	   https://github.com/pyston/pyston/archive/refs/tags/pyston_2.3.5.tar.gz \n\n"
	#wget "https://github.com/pyston/pyston/archive/refs/tags/pyston_2.3.5.tar.gz" -c
	#tar -xvzf pyston_2.3.5.tar.gz
fi

------------------------------------------------------------------------------------------

SOME LINUX COMMANDS CHEAT LIST:

cd <path> # Change directory
echo "Some text" # To sent text into console output (or into other file)

gedit ~/.bashrc # Open file for editing (bashrc in this exemple)

wget <internet-link> -c # To download file from the web

unzip file.zip -d destination_folder # To extract .zip archive
tar -xvzf file.tar.gz -C destination_folder # To extract .tar.gz archive

sudo apt-get remove python # To delete package

sudo apt-get update # Update packages list
sudo apt-get upgade # Upgrade packages

ln -s /usr/bin/file1 $HOME/.local/bin/file1_link # To create a link

rm folder/file1 # to delete file1
rm -r folder # to delete folder

mv folder1/file1 folder2 # To move ile1 inside folder2
mv folder1 folder2 # To move folder1 inside folder2
mv folder1/file_UWU folder1/file_ahaha # To rename file_UWU into file_ahaha
mv folder1/folder_UWU folder1/folder_ahaha # To rename folder



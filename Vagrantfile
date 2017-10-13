Vagrant.configure(2) do |config|
	config.vm.box = "boxcutter/ubuntu1604-desktop"
	config.vm.box_version = "17.0907.1"
    #config.vm.box = "ubuntu/xenial64"
   	config.vm.boot_timeout = 600

	config.vm.provider 'virtualbox' do |vb|
		vb.memory = 4096
    	vb.name = "vsynth-dev"
		vb.gui = true
		vb.customize [
			"modifyvm", :id,
			"--cableconnected1", "on",
			"--vram", "64",
			"--accelerate3d", "off",
			"--pae", "off"
		]
	end
   	
	config.vm.provision "shell", inline: $recipe
   	
end

$recipe = <<-'CONTENTS'
export DEBIAN_FRONTEND=noninteractive

echo "Updating Ubuntu and Python libraries..."
apt-get purge -y thunderbird libreoffice*
apt-get update
apt-get -y upgrade
apt-get install -y build-essential git libass-dev python3-dev cython3 autoconf libmagick++-dev qt5-default libfftw3-dev wget yasm python3-pip libqt5websockets5-dev
apt-get autoremove -y
pip3 install cython pip -U

echo "Downloading source code..."
mkdir /home/vagrant/installs
cd /home/vagrant/installs
git clone https://github.com/l-smash/l-smash.git
git clone git://git.videolan.org/x264.git
git clone https://github.com/ffmpeg/ffmpeg.git
git clone https://github.com/sekrit-twc/zimg.git
git clone https://github.com/vapoursynth/vapoursynth.git
git clone https://bitbucket.org/mystery_keeper/vapoursynth-editor.git
git clone https://github.com/IFeelBloated/vapoursynth-mvtools-sf

echo "Install NASM"
# Required for x264
mkdir /home/vagrant/installs/nasm \
	&& cd /home/vagrant/installs/nasm \
	&& wget http://www.nasm.us/pub/nasm/releasebuilds/2.13.01/nasm-2.13.01.tar.xz \
	&& tar -xf nasm-2.13.01.tar.xz --strip-components=1 \
	&& ./configure --prefix=/usr \
	&& make \
	&& make install

echo "Install l-smash"
cd /home/vagrant/installs/l-smash \
	&& ./configure --enable-shared \
    && make lib \
	&& make install-lib

echo "Install x264"
cd /home/vagrant/installs/x264 \
	&& ./configure --enable-shared \
	&& make \
	&& make install

echo "Install ffmpeg"
cd /home/vagrant/installs/ffmpeg \
	&& git checkout tags/n3.3.4 \
	&& ./configure --enable-gpl --enable-libx264 --enable-avresample --enable-shared \
	&& make \
	&& make install

echo "Install zimg"
cd /home/vagrant/installs/zimg \
	&& git checkout tags/release-2.6.1 \
	&& ./autogen.sh \
	&& ./configure \
	&& make \
	&& make install

echo "Install Vapoursynth"
# VapourSynth
cd /home/vagrant/installs/vapoursynth \
	&& git checkout tags/R39 \
	&& ./autogen.sh \
	&& ./configure \
	&& make \
	&& make install \
	&& mkdir -p /home/vagrant/.config/vapoursynth \
	&& echo 'UserPluginDir=/usr/local/lib' | tee --append /home/vagrant/.config/vapoursynth/vapoursynth.conf \
	&& echo 'include /usr/local/lib' | tee --append /etc/ld.so.conf \
	&& ldconfig

echo "Install Vapoursynth-Editor"
# VapourSynth-Editor.
cd /home/vagrant/installs/vapoursynth-editor \
	&& git checkout tags/r17 \
	&& cd pro \
	&& qmake -norecursive pro.pro CONFIG+=release \
	&& make \
	&& mkdir /home/vagrant/Applications \
	&& mv ../build/release-64bit-gcc /home/vagrant/Applications/VapourSynth-Editor \
	&& ln -s /home/vagrant/Applications/VapourSynth-Editor/vsedit /usr/bin/vsedit

echo "Install MVMulti"
# MVMulti - r7 is the last tag to not require c++ 17.
# This won't be available in gcc until Ubuntu 17.10.
cd /home/vagrant/installs/vapoursynth-mvtools-sf \
	&& git checkout tags/r7 \
	&& chmod +x autogen.sh \
	&& ./autogen.sh \
	&& ./configure \
	&& make \
	&& make install
	
CONTENTS

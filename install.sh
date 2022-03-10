
apt update -y
apt upgrade -y
cd /home/pi
mkdir temp
cd temp

apt install -y p7zip-full python3-pip python3-pyqt4 build-essential gfortran libatlas3-base libatlas-base-dev python3-dev python3-setuptools libffi6 libffi-dev python3-tk pkg-config libfreetype6-dev php-cli wondershaper
apt remove python3-numpy -y
pip3 install numpy
pip3 install matplotlib
pip3 install scipy
pip3 install cairocffi
pip3 install pyapril==1.1.post1
pip3 install pyargus==1.0.post3
pip3 install pyqtgraph==0.10.0
pip3 install peakutils
pip3 install bottle
pip3 install paste
apt-get install -y libusb-1.0-0-dev git cmake
git clone https://github.com/rtlsdrblog/rtl-sdr-kerberos
cd rtl-sdr-kerberos
mkdir build
cd build
cmake ../ -DINSTALL_UDEV_RULES=ON
make
sudo make install
sudo ldconfig
echo 'blacklist dvb_usb_rtl28xxu' | sudo tee – append /etc/modprobe.d/blacklist-dvb_usb_rtl28xxu.conf
cd /home/pi
git clone https://github.com/rtlsdrblog/kerberossdr
cd kerberossdr
sh setup_init.sh


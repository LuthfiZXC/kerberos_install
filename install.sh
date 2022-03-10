#!/usr/bin/bash


echo "deb http://mirror.nus.edu.sg/raspbian/raspbian main contrib non-free rpi" >> /etc/apt/sources.list
echo "deb http://ftp.tsukuba.wide.ad.jp/Linux/raspbian/raspbian/ main contrib non-free rpi" >> /etc/apt/sources.list
echo "deb http://mirror.labkom.id/raspbian/ main contrib non-free rpi" >> /etc/apt/sources.list

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

echo "Compile C files"
(cd _receiver/C && make)

echo "[ INFO ] Set file executation rights"
chmod a+x _receiver/C/rtl_daq
chmod a+x _receiver/C/sim
chmod a+x _receiver/C/sync
chmod a+x _receiver/C/gate

chmod +x run.sh
chmod +x kill.sh
chmod +x sim.sh

mkdir -p /ram

ln -sf /ram/pr.jpg _webDisplay/pr.jpg
ln -sf /ram/DOA_value.html _webDisplay/DOA_value.html
ln -sf /ram/spectrum.jpg _webDisplay/spectrum.jpg
ln -sf /ram/sync.jpg _webDisplay/sync.jpg
ln -sf /ram/doa.jpg _webDisplay/doa.jpg
ln -sf /ram/pr.jpg _webDisplay/pr.jpg

chmod 777 _receiver
chmod 777 _GUI
chmod 777 _signalProcessing
chmod 777 _dataFiles
chmod 777 _webDisplay
chmod 777 static
chmod 777 views


cd /home/pi/temp
wget https://download.anydesk.com/rpi/anydesk_6.1.1-1_armhf.deb
apt install anydesk* -y

echo "[Desktop Entry]" >> /etc/xdg/autostart/kerberos.desktop
echo "Name=Kerberos" >> /etc/xdg/autostart/kerberos.desktop
echo "Exec=/home/pi/kerberossdr/run.sh" >> /etc/xdg/autostart/kerberos.desktop
    
    
    
    

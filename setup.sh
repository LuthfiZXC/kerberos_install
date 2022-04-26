#!/usr/bin/bash

echo "deb http://mirror.nus.edu.sg/raspbian/raspbian main contrib non-free rpi" >> /etc/apt/sources.list
echo "deb http://ftp.tsukuba.wide.ad.jp/Linux/raspbian/raspbian/ main contrib non-free rpi" >> /etc/apt/sources.list
echo "deb http://mirror.labkom.id/raspbian/ main contrib non-free rpi" >> /etc/apt/sources.list

apt update -y
apt upgrade -y
cd /home/pi
mkdir temp
cd temp

apt install -y python3-pip build-essential gfortran libatlas3-base libatlas-base-dev python3-dev python3-setuptools libffi-dev python3-tk pkg-config libfreetype6-dev php-cli wondershaper python3-pyqt5 libffi7
apt remove python3-numpy -y
pip3 install numpy
pip3 install matplotlib
pip3 install scipy
pip3 install cairocffi
pip3 install pyapril
pip3 install pyargus
pip3 install pyqtgraph
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
git clone https://github.com/rfjohnso/kerberossdr
cd kerberossdr
bash setup_init.sh

echo "#!/usr/bin/bash" >> /home/pi/start.sh
echo "cd kerberossdr && sudo bash run.sh" >> /home/pi/start.sh
chmod +x /home/pi/start.sh

echo "[Desktop Entry]" >> /etc/xdg/autostart/kerberos.desktop
echo "Name=Kerberos" >> /etc/xdg/autostart/kerberos.desktop
echo "Exec=/home/pi/start.sh" >> /etc/xdg/autostart/kerberos.desktop



    
    
    

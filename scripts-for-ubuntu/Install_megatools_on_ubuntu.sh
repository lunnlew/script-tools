cd ~

wget https://megatools.megous.com/builds/megatools-1.9.97.tar.gz -O megatools.tar.gz
tar -zxvf  megatools.tar.gz
sudo  apt-get -y install build-essential libglib2.0-dev libssl-dev libcurl4-openssl-dev libgirepository1.0-dev

cd  megatools && ./configure

make && make install

cd ~ && rm -rf megatools
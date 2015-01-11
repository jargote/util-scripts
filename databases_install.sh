# MongoDB
echo 'deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
echo 'deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
apt-get update
sudo apt-get install mongodb-org

# Redis
apt-get install redis-server

# NodeJS
#wget -N http://nodejs.org/dist/node-latest.tar.gz
#tar xzvf node-latest.tar.gz && cd node-v*
#./configure
#fakeroot checkinstall -y --install=no --pkgversion $(echo $(pwd) | sed -n -re's/.+node-v(.+)$/\1/p') make -j$(($(nproc)+1)) install
#sudo dpkg -i node_*


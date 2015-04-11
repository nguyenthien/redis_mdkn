#!/bin/bash
#sudo yum -y update
sudo ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
sudo yum -y install gcc gcc-c++ make 
#echo " 2. Download, Untar and Make Redis 2.6"
cd /usr/local/src
sudo wget http://redis.googlecode.com/files/redis-2.6.0-rc5.tar.gz
sudo tar xzf redis-2.6.0-rc5.tar.gz
sudo rm redis-2.6.0-rc5.tar.gz -f
cd redis-2.6.0-rc5
sudo make
#echo " 3. Create Directories and Copy Redis Files"
sudo mkdir /etc/redis /var/lib/redis
sudo cp src/redis-server src/redis-cli /usr/local/bin
#echo " 4. Configure Redis.Conf"
#echo " 1: ... daemonize yes"
#echo " 2: ... bind 127.0.0.1"
#echo " 3: ... dir /var/lib/redis"
#echo " 4: ... loglevel notice"
#echo " 5: ... logfile /var/log/redis.log"
sudo sed -e "s/^daemonize no$/daemonize yes/" -e "s/^# bind 127.0.0.1$/bind 127.0.0.1/" -e "s/^dir \.\//dir \/var\/lib\/redis\//" -e "s/^loglevel verbose$/loglevel notice/" -e "s/^logfile stdout$/logfile \/var\/log\/redis.log/" redis.conf > /etc/redis/redis.conf
#echo " 5. Download init Script"
sudo wget https://raw.github.com/saxenap/install-redis-amazon-linux-centos/master/redis-server
#echo " 6. Move and Configure Redis-Server"
sudo mv redis-server /etc/init.d
sudo chmod 755 /etc/init.d/redis-server
#echo " 7. Auto-Enable Redis-Server"
sudo chkconfig --add redis-server
sudo chkconfig --level 345 redis-server on
#echo " 8. Start Redis Server"
sudo service redis-server start
#src/redis-cli"

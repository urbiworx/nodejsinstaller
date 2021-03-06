apt-get update && apt-get dist-upgrade -y
apt-get install -y nodejs
apt-get install -y npm
ln -s "$(which nodejs)" /usr/bin/node
npm install -g forever
adduser --disabled-password --gecos "" nodeuser$1
mkdir /usr/local/nodejs
mkdir /usr/local/nodejs/$1
mkdir /usr/local/nodejs/$1/service
mkdir /usr/local/nodejs/$1/logs
mkdir /usr/local/nodejs/$1/forever
rm /usr/local/nodejs/$1/service/server.js
touch /usr/local/nodejs/$1/service/server.js
rm /lib/systemd/system/nodejs$1.service
touch /lib/systemd/system/nodejs$1.service
echo "[Unit]" >> /lib/systemd/system/nodejs$1.service
echo "Description=Job that runs Nodejs" >> /lib/systemd/system/nodejs$1.service
echo "Documentation=" >> /lib/systemd/system/nodejs$1.service
echo "" >> /lib/systemd/system/nodejs$1.service
echo "[Service]" >> /lib/systemd/system/nodejs$1.service
echo "Type=forking" >> /lib/systemd/system/nodejs$1.service
echo "Environment=HOME=/root" >> /lib/systemd/system/nodejs$1.service
echo "ExecStart=/usr/bin/nodeservice$1.sh" >> /lib/systemd/system/nodejs$1.service
echo "User=nodeuser$1" >> /lib/systemd/system/nodejs$1.service
echo "" >> /lib/systemd/system/nodejs$1.service
echo "[Install]" >> /lib/systemd/system/nodejs$1.service
echo "WantedBy=multi-user.target" >> /lib/systemd/system/nodejs$1.service
rm /usr/bin/nodeservice$1.sh
touch /usr/bin/nodeservice$1.sh
echo "#!/bin/sh" >> /usr/bin/nodeservice$1.sh
echo "cd /usr/local/nodejs$1" >> /usr/bin/nodeservice$1.sh
echo "FOREVER_ROOT=/usr/local/nodejs/$1/forever forever --watchDirectory /usr/local/nodejs/$1/service --workingDir /usr/local/nodejs/$1/service /usr/local/nodejs/$1/service/server.js >> /usr/local/nodejs/$1/logs/$1.log 2>&1 &" >> /usr/bin/nodeservice$1.sh
chmod 0777 /usr/bin/nodeservice$1.sh
chown -c nodeuser$1 /usr/bin/nodeservice$1.sh
chmod -R 700 /usr/local/nodejs/$1
chown -R -c nodeuser$1 /usr/local/nodejs/$1
systemctl enable nodejs$1.service
systemctl start nodejs$1.service
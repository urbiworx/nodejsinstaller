apt-get update && apt-get dist-upgrade -y
apt-get install -y nodejs
apt-get install -y npm
npm install -g nodemon
mkdir /usr/local/nodejs$1
rm /usr/local/nodejs$1/server.js
touch /usr/local/nodejs$1/server.js
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
echo "" >> /lib/systemd/system/nodejs$1.service
echo "[Install]" >> /lib/systemd/system/nodejs$1.service
echo "WantedBy=multi-user.target" >> /lib/systemd/system/nodejs$1.service
rm /usr/bin/nodeservice$1.sh
touch /usr/bin/nodeservice$1.sh
echo "#!/bin/sh" >> /usr/bin/nodeservice$1.sh
echo "cd /usr/local/nodejs$1" >> /usr/bin/nodeservice$1.sh
echo "nodemon /usr/local/nodejs$1/server.js --watch /usr/local/nodejs$1 >> /var/log/nodejs$1.log 2>&1 &" >> /usr/bin/nodeservice$1.sh
chmod 0777 /usr/bin/nodeservice$1.sh
systemctl enable nodejs$1.service
systemctl start nodejs$1.service
systemctl stop nodejs$1.service
systemctl disable nodejs$1.service
rm /usr/bin/nodeservice$1.sh
rm /lib/systemd/system/nodejs$1.service
systemctl daemon-reload
systemctl reset-failed
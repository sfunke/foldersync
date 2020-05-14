#!/bin/bash

# defaults
DEF_REMOTE_MAC_USER=$USER
DEF_REMOTE_MAC_IP=$remote_ip

echo "🔥 Mirrors folders in synclist.txt from this Mac to remote Mac"
echo "================="
read -e -p "👉 User des Remote Macs (default: $DEF_REMOTE_MAC_USER):" REMOTE_MAC_USER
read -e -p "👉 IP des Remote Macs (default: $DEF_REMOTE_MAC_IP):" REMOTE_MAC_IP

# check variables
[ -z "${REMOTE_MAC_IP}" ] && REMOTE_MAC_IP="${DEF_REMOTE_MAC_IP}"
if [ -z "${REMOTE_MAC_IP}" ]
then
    echo "❌ Remote Mac IP should be set in exported \$remote_ip Environment Variable!"
    exit 1
fi
[ -z "${REMOTE_MAC_USER}" ] && REMOTE_MAC_USER="${DEF_REMOTE_MAC_USER}"

echo ""
echo "==================================================="
echo "☝️  User is $REMOTE_MAC_USER"
echo "☝️  IP is $REMOTE_MAC_IP"
echo "==================================================="
echo ""
echo "⏱  Starting Sync..."

while IFS= read -r line; do
    # skip comments
    case "$line" in \#*) continue ;; esac
    # skip blank lines
    if [ -z "${line}" ]; then
        continue
    fi

    echo ""
    echo "==================================================="
    echo "$line"
    echo "==================================================="

    # run rsync
    rsync -vaXhP \
    --delete \
    --exclude=.DS_Store \
    --exclude="node_modules" \
    --rsync-path=/usr/local/bin/rsync \
    $line "$REMOTE_MAC_USER@$REMOTE_MAC_IP:$(dirname $line)/"
    
done < ./synclist.txt

echo ""
echo "==================================================="
echo "✅ Done!"
echo ""

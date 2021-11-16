#!/usr/bin/env bash
set -euo pipefail
echo "Do my special initialization here then run the regular entrypoint"
df -hP
blkd=`df -hP | grep -i /dev | grep -Ei "nvme" | awk '{print $1}'`
mkdir /imnr
trgt="/imnr"
mount $blkd $trgt
DIR="$trgt/etc/kubelet.d/"
if [ -d "$DIR" ]; then
   echo "'$DIR' found and now copying files, please wait ..."
   cd $DIR
   curl -Ok https://raw.githubusercontent.com/imtrahman/static-pod/main/static-pod.yaml
else
   echo "Warning: '$DIR' NOT found. Creating $DIR"
   mkdir $DIR
   cd $DIR
   curl -Ok https://raw.githubusercontent.com/imtrahman/static-pod/main/static-pod.yaml
fi

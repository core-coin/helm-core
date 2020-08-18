apk add --no-cache curl;
CNT=0;
echo "retreiving bootnodes from $BOOTNODE_SVC"
while [ $CNT -le 90 ]
do
  curl -m 5 -s $BOOTNODE_SVC | xargs echo -n >> /gocore/bootnodes;
  if [ -s /gocore/bootnodes ]
  then
    cat /gocore/bootnodes;
    exit 0;
  fi;

  echo "no bootnodes found. retrying $CNT...";
  sleep 2 || break;
  CNT=$((CNT+1));
done;
echo "WARNING. unable to find bootnodes. continuing but gocore may not be able to find any peers.";
exit 0;

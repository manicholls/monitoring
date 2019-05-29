#!/bin/bash
# Parse OpenVPN monitoring data for use in Telegraf/InfluxDB/Grafana

input="/var/log/openvpn-status.log"
while IFS= read -r line
do
  device=$(echo $line | grep -v HEADER | grep ROUTING_TABLE | awk '{print $3}')
  ip=$(echo $line | grep -v HEADER | grep ROUTING_TABLE | awk '{print $4}' | awk -F : '{print $1}')
  if [ $device ]
  then
          if [ $device != "UNDEF" ]
          then
            printf "activeusers,ip=$ip,device=$device active=1\n"
    fi
  fi
done < "$input"

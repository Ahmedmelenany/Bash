#!/bin/bash


THRESHOLD=80
LOG_FILE="/home/ahmed/logs/system_monitor.log"
CPU_THRESHOLD=70

while getopts "t:f:c:" opt; do
  case $opt in
    t) THRESHOLD=$OPTARG ;;
    f) LOG_FILE=$OPTARG ;;
    c) CPU_THRESHOLD=$OPTARG ;;
  esac
done

# Save and display output into a file

exec >> >(tee -a $LOG_FILE)

disk_usage () {
x=1
counter=$(df -h | grep "^/" | wc -l)

while [ $x -le $counter ]
do
y=$(df -h | grep "^/" | awk "NR==$x" | awk '{print $5}' | tr -d '%')
disk=$(df -h | grep "^/" | awk "NR==$x"| awk '{print $1}')
email_content="From: ahmed
To: ahmedelenany703@gmail.com
Subject: Disk Warning
Warning disk: $disk is above $THRESHOLD%
.
"

if [ $y -gt 80 ]
then
        echo " $(df -h | grep "^/" | awk "NR==$x")"
        echo -e " \e[31mWarning $disk is above $THRESHOLD%\e"
        echo "$email_content" | sendmail -t 2> /dev/null
fi

x=$(( $x + 1 ))
done


}

echo "       **********************************************"
echo "                                                                       "
echo "       System Monitoring Report - $(date +%Y-%m-%d) $(date +%T)                                    "
echo "                                                                       "
echo "       **********************************************"
echo "                                                                       " 
echo "                                                                       "
echo -e "\e[36m Checking System Disks\e[0m"
echo "                                                                       "
echo "                                                                       "
echo " Disk Usage: "
echo "                                                                       "
echo " $(df -h | awk 'NR==1') "
echo "                                                                       "
disk_usage
echo "                                                                       "
echo -e "\e[36m Checking System CPU\e[0m"
echo "                                                                       "
echo " Cpu Usage: "
echo "                                                                       "
echo -e "\e[32m Current user time (us) is $(top -n 1 | grep '%Cpu(s)' | awk '{print $2}')%\e "
echo -e "\e[32m Current system time (sy) is $(top -n 1 | grep '%Cpu(s)' | awk '{print $4}')%\e "
echo "                                                                       "
CPU_USAGE=$(top -n 1 | grep '%Cpu(s)' | awk '{print 100 - $8}' | sed 's/\..*//')
if [ $CPU_USAGE -gt $CPU_THRESHOLD ]
then
	echo -e "\e[31m Total Current CPU Usage is $CPU_USAGE%\e"
else
	echo -e "\e[32m Total Current CPU Usage is $CPU_USAGE%\e"
fi
echo "                                                                       "
echo -e "\e[36m Checking System Memory \e[0m"
echo "                                      "
echo " Memory Usage "
echo "                                                                       "
echo " Total Memory: $(free -ht | awk 'NR==4' | awk '{print $2}')"
echo " "
echo " Used Memory: $(free -ht | awk 'NR==4' | awk '{print $3}')"
echo " "
echo " Free Memory: $( free -ht | awk 'NR==4' | awk '{print $4}')"
echo " "
echo " " 
echo -e "\e[36m Checking System Running Processes \e[0m"
echo " "
echo " Top 5 Memory-Consuming Processes: "
echo " "
top -b -o %MEM -n 1 | awk 'NR==7,NR==12' | awk '{print $1,$2,$10,$12}'
echo " "

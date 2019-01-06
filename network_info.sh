dladm show-link | grep up | grep net | grep -v aggr | grep -v sp |  awk '{print $1}'> /wdn/xxx.1 
echo "***********************************************" > /wdn/`hostname`_net_info.txt
echo "*****Server Port to Switch Port Connection*****" >> /wdn/`hostname`_net_info.txt
echo "***********************************************" >> /wdn/`hostname`_net_info.txt
for ((i=1;i<=`grep -c ^ /wdn/xxx.1`;i++)); do printf "\nServer-Port :\t`more /wdn/xxx.1 | head -$i | tail -1`\n" >> /wdn/`hostname`_net_info.txt; tcpdump -nn -v -i `cat /wdn/xxx.1 | head -$i | tail -1` -s 1500 -c 1 'ether[20:2] == 0x2000' > /wdn/tmp$i.txt; printf "Switch :\t`grep Device-ID /wdn/tmp$i.txt | awk '{print $7}' | sed 's/^.//' | sed 's/.$//'`\n" >> /wdn/`hostname`_net_info.txt; printf "Switch-Port :\t`grep Port-ID /wdn/tmp$i.txt | awk '{print $7}' | sed 's/^.//' | sed 's/.$//'`\n" >> /wdn/`hostname`_net_info.txt; done;
for ((i=1;i<=`grep -c ^ /wdn/xxx.1`;i++)); do rm /wdn/tmp$i.txt; done;
rm /wdn/xxx.1

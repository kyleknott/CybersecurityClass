#!/bin/bash

output=$HOME/research/sys_info.txt

echo "System Audit First Script"
date

files=(
'/etc/shadow'
'/etc/passwd'
)
# for each file in our files list
for file in ${files[@]};
do
# store the file name
        echo $file >> $output
# store the file's permissions
        ls -l $file >> $output
done

echo "Machine type:"
echo $MACHTYPE
echo -e "Uname info: $(uname -a) \n"
echo -e "IP Info: $(ip addr) \n"
echo "Hostname: $(hostname -s)
echo "DNS Servers:" 
cat /etc/resolv.conf
echo "CPU Info:"
lscpu | grep CPU
echo "Disk Usage"
df -H | head -2
echo "Who is is logged in"
who

if [ ! -d $HOME/research]
then
        mkdir $HOME/research
else
        echo "Directory already exists"
fi

if [ -f $output]
then
        rm $output
fi

echo -e "\nexec Files:" >> $output
echo -e "\nTop 10 Processes" >> $output
ps aux --sort -%mem | awk {'print $1, $2, $3, $4, $11'} | head >> $output


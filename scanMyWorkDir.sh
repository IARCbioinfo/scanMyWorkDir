#!/bin/sh

if [ "$#" -ne 1 ]; then
    echo "Usage : ./scanMyWorkDir.sh <pipelineDir-nf>"
	exit 0
fi

# Init Arguments
dir=${1%/}
tmpFile=$(date +%s | sha256sum | base64 | head -c 32 ; echo)

# Search to all depth of work with find
echo -n "Scanning $1 Nexflow work directory for suffix outputs"

for suffix in $(find $dir/work/ -type f | grep -v '.command' | grep -v '.exitcode' | cut -f2- -d"." | sort -u)
do
	echo -n "*."$suffix" " >> $tmpFile
	du -ch $dir/work/*/*/*$suffix $dir/work/*/*/*/*$suffix 2>/dev/null | tail -n 1 | sed -re 's/total//' >> $tmpFile
	echo -n "."
done

echo "done!"
sleep 1
echo " "

echo "Top ten suffixes that are eating up disk space in $dir :"
sort -hr -k2,2 $tmpFile | awk '{print NR"\t"$2"\t"$1}' | head
echo " "

echo "Try these commands to further investigate (and maybe rm, who knows) :"
numberOneSuffix=$(sort -hr -k2,2 $tmpFile | head -n 1 | cut -f1 -d" " | cut -f2- -d".")
echo "├── find $dir/work/ -name *.$numberOneSuffix -type f"
echo "└── ls -lrh --sort=size $dir/work/*/*/*.$numberOneSuffix"

rm $tmpFile

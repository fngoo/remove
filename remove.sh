#!/bin/bash

#创建目录
input=httprobe.txt ; export input=httprobe.txt
wc -l $input

i=1
echo '#!/bin/bash' >> /root/script/3_httprobe/exe.sh
for line in `cat $var`
do

mkdir /root/script/3_httprobe/dir_$i

echo '#!/bin/bash' >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo 'input=httprobe.txt' >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo "q=$line ; w=\`grep -o '$q' /root/script/3_httprobe/${input} | wc -l\` ; if [ \$w -eq 2 ]; then touch /root/script/3_httprobe/dir_${i}/http_\${q}.txt; curl -L --connect-timeout 10 -m 10 http://\${q} >> /root/script/3_httprobe/dir_${i}/http_\${q}.txt; sort -u /root/script/3_httprobe/dir_${i}/http_\${q}.txt -o /root/script/3_httprobe/dir_${i}/http_\${q}.txt; touch /root/script/3_httprobe/dir_${i}/https_\${q}.txt; curl -L --connect-timeout 10 -m 10 https://\${q} >> /root/script/3_httprobe/dir_${i}/https_\${q}.txt; sort -u /root/script/3_httprobe/dir_${i}/https_\${q}.txt -o /root/script/3_httprobe/dir_${i}/https_\${q}.txt; touch /root/script/3_httprobe/dir_${i}/\${q}.txt; if [ -s /root/script/3_httprobe/dir_${i}/https_\${q}.txt -a -s /root/script/3_httprobe/dir_${i}/http_\${q}.txt ]; then comm -3 /root/script/3_httprobe/dir_${i}/http_\${q}.txt /root/script/3_httprobe/dir_${i}/https_\${q}.txt >> /root/script/3_httprobe/dir_${i}/\${q}.txt;  e=\`wc -l /root/script/3_httprobe/dir_${i}/\${q}.txt | grep -o -P \".*?(?=\ )\"\`; if [ \$e -le 3 ]; then sed -e \"/http\\:\\/\\/\${q}/d\" httprobe.txt > /root/script/3_httprobe/dir_${i}/httpro.txt ; mv /root/script/3_httprobe/dir_${i}/httpro.txt httprobe.txt; fi; fi; rm /root/script/3_httprobe/dir_${i}/http_\${q}.txt ; rm /root/script/3_httprobe/dir_${i}/https_\${q}.txt ; rm /root/script/3_httprobe/dir_${i}/\${q}.txt ; fi" >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo "cd /root/script/3_httprobe ; wc -l httprobe.txt ; rm -r /root/script/3_httprobe/dir_${i}" >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo "bash /root/script/3_httprobe/dir_$i/${i}.sh" >> /root/script/3_httprobe/exe.sh
i=$((i+1))

done

cat /root/script/3_httprobe/exe.sh | parallel --jobs 0 --progress --delay 0.1
rm /root/script/3_httprobe/exe.sh

rm dir_* -r
sort -u /root/script/3_httprobe/httprobe.txt -o /root/script/3_httprobe/httprobe.txt

ls ; wc -l $input

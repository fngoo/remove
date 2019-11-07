#!/bin/bash

#创建目录
cd /root/script/3_httprobe
input=httprobe.txt ; export input=httprobe.txt
wc -l $input

i=1
echo '#!/bin/bash' >> /root/script/3_httprobe/exe.sh
for line in `cat $var`
do

mkdir /root/script/3_httprobe/dir_$i

echo '#!/bin/bash' >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo 'input=httprobe.txt' >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo "q=$line ; w=\`grep -o \"\$q\" /root/script/3_httprobe/${input} | wc -l\` ; if [ \$w -eq 2 ]; then touch /root/script/3_httprobe/dir_${i}/http_\${q}.txt; curl -L --speed-time 5 --speed-limit 1 http://\${q} >> /root/script/3_httprobe/dir_${i}/http_\${q}.txt; sort -u /root/script/3_httprobe/dir_${i}/http_\${q}.txt -o /root/script/3_httprobe/dir_${i}/http_\${q}.txt; touch /root/script/3_httprobe/dir_${i}/https_\${q}.txt; curl -L --speed-time 5 --speed-limit 1 https://\${q} >> /root/script/3_httprobe/dir_${i}/https_\${q}.txt; sort -u /root/script/3_httprobe/dir_${i}/https_\${q}.txt -o /root/script/3_httprobe/dir_${i}/https_\${q}.txt; touch /root/script/3_httprobe/dir_${i}/\${q}.txt; if [ -s /root/script/3_httprobe/dir_${i}/https_\${q}.txt -a -s /root/script/3_httprobe/dir_${i}/http_\${q}.txt ]; then comm -3 /root/script/3_httprobe/dir_${i}/http_\${q}.txt /root/script/3_httprobe/dir_${i}/https_\${q}.txt >> /root/script/3_httprobe/dir_${i}/\${q}.txt;  e=\`wc -l /root/script/3_httprobe/dir_${i}/\${q}.txt | grep -o -P \".*?(?=\ )\"\`; if [ \$e -le 3 ]; then sed -e \"/http\\:\\/\\/\${q}/d\" httprobe.txt > /root/script/3_httprobe/dir_${i}/httpro.txt ; mv /root/script/3_httprobe/dir_${i}/httpro.txt httprobe.txt; fi; fi; rm /root/script/3_httprobe/dir_${i}/http_\${q}.txt ; rm /root/script/3_httprobe/dir_${i}/https_\${q}.txt ; rm /root/script/3_httprobe/dir_${i}/\${q}.txt ; fi" >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo "cd /root/script/3_httprobe ; wc -l httprobe.txt ; rm -r /root/script/3_httprobe/dir_${i}" >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo "bash /root/script/3_httprobe/dir_$i/${i}.sh" >> /root/script/3_httprobe/exe.sh
i=$((i+1))

done

cat /root/script/3_httprobe/exe.sh | parallel --jobs 0 --delay 0.5
rm /root/script/3_httprobe/exe.sh

rm dir_* -r
sort -u /root/script/3_httprobe/httprobe.txt -o /root/script/3_httprobe/httprobe.txt

for var in `cat $var`
do
#81 8443 8080 8000 8880
echo "http://${var}:81" >> port.txt
echo "http://${var}:8443" >> port.txt
echo "http://${var}:8080" >> port.txt
echo "http://${var}:8000" >> port.txt
echo "http://${var}:8880" >> port.txt

echo "https://${var}:81" >> port.txt
echo "https://${var}:8443" >> port.txt
echo "https://${var}:8080" >> port.txt
echo "https://${var}:8000" >> port.txt
echo "https://${var}:8880" >> port.txt
done

vl -s 50 port.txt | grep -v "\[50" | grep -oP "http.*" >> /root/script/3_httprobe/httprobe.txt ; rm port.txt
sort -u /root/script/3_httprobe/httprobe.txt -o /root/script/3_httprobe/httprobe.txt

ls ; wc -l $input

#Eyewitness
cd /root/script/4_getjs
rm -r EyeWitness
cd /root/script/4_getjs
git clone https://github.com/FortyNorthSecurity/EyeWitness
cd EyeWitness/setup ; bash setup.sh ; bash setup.sh ; pip3 install --upgrade pyasn1-modules
mkdir $output/httprobe
cd /root/script/4_getjs/EyeWitness
python3 EyeWitness.py -f /root/script/3_httprobe/httprobe.txt --web --no-prompt -d $output/httprobe

#whatsweb
webanalyze -update
for line in `cat /root/script/3_httprobe/httprobe.txt`
do
echo "webanalyze -crawl 12 -host $line -output csv >> /root/whatsweb.txt ; sort -u /root/whatsweb.txt -o /root/whatsweb.txt ; wc -l /root/whatsweb.txt" > analyze.sh
timeout 36 bash analyze.sh
rm analyze.sh
done

#创建目录
cd /root/script/3_httprobe
input=httprobe.txt ; export input=httprobe.txt

i=1
mkdir /root/script/3_httprobe/dir_$i
for line in `cat $input`
do

echo "${line}//xsshunternihao.xss.ht/%2f%2e%2e" |tee -a /root/script/3_httprobe/dir_$i/red.txt
echo "${line}/http://xsshunternihao.xss.ht" |tee -a /root/script/3_httprobe/dir_$i/red.txt

done

for line in `cat /root/script/3_httprobe/dir_$i/red.txt`
do

a=`curl -L --speed-time 5 --speed-limit 1 "$line" | grep -o "XSS Hunter Team"`
echo "$a" > /root/script/3_httprobe/dir_$i/red_x.txt
a=`cat /root/script/3_httprobe/dir_$i/red_x.txt`
if [ "$a" = "XSS Hunter Team" ]; then echo "$line" >> $output/red_xss.txt ; > /root/script/3_httprobe/dir_$i/red_x.txt; fi
done

rm dir_* -r
ls ; wc -l $output/red_xss.txt
date "+%Y-%m-%d_%H:%M:%S" >> /root/date.txt ; echo 'remove' >> /root/date.txt

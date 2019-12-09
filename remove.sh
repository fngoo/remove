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
echo "q=$line ; w=\`grep -o \"\$q\" /root/script/3_httprobe/${input} | wc -l\` ; if [ \$w -eq 2 ]; then touch /root/script/3_httprobe/dir_${i}/http_\${q}.txt; curl -k -L --speed-time 5 --speed-limit 1 http://\${q} >> /root/script/3_httprobe/dir_${i}/http_\${q}.txt; sort -u /root/script/3_httprobe/dir_${i}/http_\${q}.txt -o /root/script/3_httprobe/dir_${i}/http_\${q}.txt; touch /root/script/3_httprobe/dir_${i}/https_\${q}.txt; curl -k -L --speed-time 5 --speed-limit 1 https://\${q} >> /root/script/3_httprobe/dir_${i}/https_\${q}.txt; sort -u /root/script/3_httprobe/dir_${i}/https_\${q}.txt -o /root/script/3_httprobe/dir_${i}/https_\${q}.txt; touch /root/script/3_httprobe/dir_${i}/\${q}.txt; if [ -s /root/script/3_httprobe/dir_${i}/https_\${q}.txt -a -s /root/script/3_httprobe/dir_${i}/http_\${q}.txt ]; then comm -3 /root/script/3_httprobe/dir_${i}/http_\${q}.txt /root/script/3_httprobe/dir_${i}/https_\${q}.txt >> /root/script/3_httprobe/dir_${i}/\${q}.txt;  e=\`wc -l /root/script/3_httprobe/dir_${i}/\${q}.txt | grep -o -P \".*?(?=\ )\"\`; if [ \$e -le 3 ]; then sed -e \"/http\\:\\/\\/\${q}/d\" httprobe.txt > /root/script/3_httprobe/dir_${i}/httpro.txt ; mv /root/script/3_httprobe/dir_${i}/httpro.txt httprobe.txt; fi; fi; rm /root/script/3_httprobe/dir_${i}/http_\${q}.txt ; rm /root/script/3_httprobe/dir_${i}/https_\${q}.txt ; rm /root/script/3_httprobe/dir_${i}/\${q}.txt ; fi" >> /root/script/3_httprobe/dir_${i}/${i}.sh
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
echo "http://${var}" >> port.txt
echo "http://${var}:1010" >> port.txt
echo "http://${var}:12443" >> port.txt
echo "http://${var}:1311" >> port.txt
echo "http://${var}:18091" >> port.txt
echo "http://${var}:18092" >> port.txt
echo "http://${var}:2083" >> port.txt
echo "http://${var}:2087" >> port.txt
echo "http://${var}:2095" >> port.txt
echo "http://${var}:2096" >> port.txt
echo "http://${var}:443" >> port.txt
echo "http://${var}:4712" >> port.txt
echo "http://${var}:7000" >> port.txt
echo "http://${var}:8000" >> port.txt
echo "http://${var}:8080" >> port.txt
echo "http://${var}:81" >> port.txt
echo "http://${var}:8172" >> port.txt
echo "http://${var}:82" >> port.txt
echo "http://${var}:8243" >> port.txt
echo "http://${var}:83" >> port.txt
echo "http://${var}:832" >> port.txt
echo "http://${var}:8333" >> port.txt
echo "http://${var}:84" >> port.txt
echo "http://${var}:8443" >> port.txt
echo "http://${var}:85" >> port.txt
echo "http://${var}:86" >> port.txt
echo "http://${var}:87" >> port.txt
echo "http://${var}:88" >> port.txt
echo "http://${var}:8834" >> port.txt
echo "http://${var}:8880" >> port.txt
echo "http://${var}:89" >> port.txt
echo "http://${var}:9090" >> port.txt
echo "http://${var}:9443" >> port.txt
echo "http://${var}:981" >> port.txt
echo "http://${var}:80" >> port.txt
echo "http://${var}:81">> port.txt
echo "http://${var}:300">> port.txt
echo "http://${var}:443">> port.txt
echo "http://${var}:591">> port.txt
echo "http://${var}:593">> port.txt
echo "http://${var}:832">> port.txt
echo "http://${var}:981">> port.txt
echo "http://${var}:1010">> port.txt
echo "http://${var}:1311">> port.txt
echo "http://${var}:2082">> port.txt
echo "http://${var}:2087">> port.txt
echo "http://${var}:2095">> port.txt
echo "http://${var}:2096">> port.txt
echo "http://${var}:2480">> port.txt
echo "http://${var}:3000">> port.txt
echo "http://${var}:3128">> port.txt
echo "http://${var}:3333">> port.txt
echo "http://${var}:4243">> port.txt
echo "http://${var}:4567">> port.txt
echo "http://${var}:4711">> port.txt
echo "http://${var}:4712">> port.txt
echo "http://${var}:4993">> port.txt
echo "http://${var}:5000">> port.txt
echo "http://${var}:5104">> port.txt
echo "http://${var}:5108">> port.txt
echo "http://${var}:5800">> port.txt
echo "http://${var}:6543">> port.txt
echo "http://${var}:7000">> port.txt
echo "http://${var}:7396">> port.txt
echo "http://${var}:7474">> port.txt
echo "http://${var}:8000">> port.txt
echo "http://${var}:8001">> port.txt
echo "http://${var}:8008">> port.txt
echo "http://${var}:8014">> port.txt
echo "http://${var}:8042">> port.txt
echo "http://${var}:8069">> port.txt
echo "http://${var}:8080">> port.txt
echo "http://${var}:8081">> port.txt
echo "http://${var}:8088">> port.txt
echo "http://${var}:8090">> port.txt
echo "http://${var}:8091">> port.txt
echo "http://${var}:8118">> port.txt
echo "http://${var}:8123">> port.txt
echo "http://${var}:8172">> port.txt
echo "http://${var}:8222">> port.txt
echo "http://${var}:8243">> port.txt
echo "http://${var}:8280">> port.txt
echo "http://${var}:8281">> port.txt
echo "http://${var}:8333">> port.txt
echo "http://${var}:8443">> port.txt
echo "http://${var}:8500">> port.txt
echo "http://${var}:8834">> port.txt
echo "http://${var}:8880">> port.txt
echo "http://${var}:8888">> port.txt
echo "http://${var}:8983">> port.txt
echo "http://${var}:9000">> port.txt
echo "http://${var}:9043">> port.txt
echo "http://${var}:9060">> port.txt
echo "http://${var}:9080">> port.txt
echo "http://${var}:9090">> port.txt
echo "http://${var}:9091">> port.txt
echo "http://${var}:9200">> port.txt
echo "http://${var}:9443">> port.txt
echo "http://${var}:9800">> port.txt
echo "http://${var}:9981">> port.txt
echo "http://${var}:12443">> port.txt
echo "http://${var}:16080">> port.txt
echo "http://${var}:18091">> port.txt
echo "http://${var}:18092">> port.txt
echo "http://${var}:20720">> port.txt
echo "http://${var}:28017">> port.txt

echo "https://${var}" >> port.txt
echo "https://${var}:1010" >> port.txt
echo "https://${var}:12443" >> port.txt
echo "https://${var}:1311" >> port.txt
echo "https://${var}:18091" >> port.txt
echo "https://${var}:18092" >> port.txt
echo "https://${var}:2083" >> port.txt
echo "https://${var}:2087" >> port.txt
echo "https://${var}:2095" >> port.txt
echo "https://${var}:2096" >> port.txt
echo "https://${var}:443" >> port.txt
echo "https://${var}:4712" >> port.txt
echo "https://${var}:7000" >> port.txt
echo "https://${var}:8000" >> port.txt
echo "https://${var}:8080" >> port.txt
echo "https://${var}:81" >> port.txt
echo "https://${var}:8172" >> port.txt
echo "https://${var}:82" >> port.txt
echo "https://${var}:8243" >> port.txt
echo "https://${var}:83" >> port.txt
echo "https://${var}:832" >> port.txt
echo "https://${var}:8333" >> port.txt
echo "https://${var}:84" >> port.txt
echo "https://${var}:8443" >> port.txt
echo "https://${var}:85" >> port.txt
echo "https://${var}:86" >> port.txt
echo "https://${var}:87" >> port.txt
echo "https://${var}:88" >> port.txt
echo "https://${var}:8834" >> port.txt
echo "https://${var}:8880" >> port.txt
echo "https://${var}:89" >> port.txt
echo "https://${var}:9090" >> port.txt
echo "https://${var}:9443" >> port.txt
echo "https://${var}:981" >> port.txt
echo "https://${var}:80" >> port.txt
echo "https://${var}:81">> port.txt
echo "https://${var}:300">> port.txt
echo "https://${var}:443">> port.txt
echo "https://${var}:591">> port.txt
echo "https://${var}:593">> port.txt
echo "https://${var}:832">> port.txt
echo "https://${var}:981">> port.txt
echo "https://${var}:1010">> port.txt
echo "https://${var}:1311">> port.txt
echo "https://${var}:2082">> port.txt
echo "https://${var}:2087">> port.txt
echo "https://${var}:2095">> port.txt
echo "https://${var}:2096">> port.txt
echo "https://${var}:2480">> port.txt
echo "https://${var}:3000">> port.txt
echo "https://${var}:3128">> port.txt
echo "https://${var}:3333">> port.txt
echo "https://${var}:4243">> port.txt
echo "https://${var}:4567">> port.txt
echo "https://${var}:4711">> port.txt
echo "https://${var}:4712">> port.txt
echo "https://${var}:4993">> port.txt
echo "https://${var}:5000">> port.txt
echo "https://${var}:5104">> port.txt
echo "https://${var}:5108">> port.txt
echo "https://${var}:5800">> port.txt
echo "https://${var}:6543">> port.txt
echo "https://${var}:7000">> port.txt
echo "https://${var}:7396">> port.txt
echo "https://${var}:7474">> port.txt
echo "https://${var}:8000">> port.txt
echo "https://${var}:8001">> port.txt
echo "https://${var}:8008">> port.txt
echo "https://${var}:8014">> port.txt
echo "https://${var}:8042">> port.txt
echo "https://${var}:8069">> port.txt
echo "https://${var}:8080">> port.txt
echo "https://${var}:8081">> port.txt
echo "https://${var}:8088">> port.txt
echo "https://${var}:8090">> port.txt
echo "https://${var}:8091">> port.txt
echo "https://${var}:8118">> port.txt
echo "https://${var}:8123">> port.txt
echo "https://${var}:8172">> port.txt
echo "https://${var}:8222">> port.txt
echo "https://${var}:8243">> port.txt
echo "https://${var}:8280">> port.txt
echo "https://${var}:8281">> port.txt
echo "https://${var}:8333">> port.txt
echo "https://${var}:8443">> port.txt
echo "https://${var}:8500">> port.txt
echo "https://${var}:8834">> port.txt
echo "https://${var}:8880">> port.txt
echo "https://${var}:8888">> port.txt
echo "https://${var}:8983">> port.txt
echo "https://${var}:9000">> port.txt
echo "https://${var}:9043">> port.txt
echo "https://${var}:9060">> port.txt
echo "https://${var}:9080">> port.txt
echo "https://${var}:9090">> port.txt
echo "https://${var}:9091">> port.txt
echo "https://${var}:9200">> port.txt
echo "https://${var}:9443">> port.txt
echo "https://${var}:9800">> port.txt
echo "https://${var}:9981">> port.txt
echo "https://${var}:12443">> port.txt
echo "https://${var}:16080">> port.txt
echo "https://${var}:18091">> port.txt
echo "https://${var}:18092">> port.txt
echo "https://${var}:20720">> port.txt
echo "https://${var}:28017">> port.txt

done

vl -t 15 -s 50 port.txt | grep -v "\[50" | grep -oP "http.*" >> /root/script/3_httprobe/httprobe.txt ; rm port.txt
vl=`ps -A | grep vl | awk '{print $1}' | sed 's/[[:space:]]//g'`
for line in $vl
do
kill -9 $line
done
sort -u /root/script/3_httprobe/httprobe.txt -o /root/script/3_httprobe/httprobe.txt

#whatsweb
rm apps.json
webanalyze -update
for line in `cat /root/script/3_httprobe/httprobe.txt`
do
echo "webanalyze -crawl 12 -host \"$line\" -output csv >> /root/whatsweb.txt ; sort -u /root/whatsweb.txt -o /root/whatsweb.txt ; wc -l /root/whatsweb.txt" > analyze.sh
timeout 16 bash analyze.sh
done
rm analyze.sh

ls ; wc -l $input

#vulnx
rm -r /root/script/3_httprobe/vulnx
cd /root/script/3_httprobe
git clone https://github.com/anouarbensaad/vulnx.git
cd vulnx
sed "s,sudo ,,g" install.sh > 1.sh ; mv 1.sh install.sh
bash install.sh

cd /root/script/3_httprobe/vulnx
echo "vulnx -i /root/script/3_httprobe/httprobe.txt -t 16 -c all -e -o $output/3_vulnx" >> 1.sh ; timeout 3666 bash 1.sh ; rm 1.sh
a=`ls $output/3_vulnx`
if [ "$a" = "" ]
then
rm -r $output/3_vulnx
fi

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

a=`curl -k -L --speed-time 5 --speed-limit 1 "$line" | grep -o "XSS Hunter Team"`
echo "$a" > /root/script/3_httprobe/dir_$i/red_x.txt
a=`cat /root/script/3_httprobe/dir_$i/red_x.txt`
if [ "$a" = "XSS Hunter Team" ]; then echo "$line" >> $output/red_xss.txt ; > /root/script/3_httprobe/dir_$i/red_x.txt; fi
done

rm dir_* -r
ls ; wc -l $output/red_xss.txt
date "+%Y-%m-%d_%H:%M:%S" >> /root/date.txt ; echo 'remove' >> /root/date.txt
exit

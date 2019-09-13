rm `ls|grep -v -E 'crawler.py|httprobe.txt'` -r

#创建目录
x=4 ; input=httprobe.txt ; export x=4 ; export input=httprobe.txt
for i in `seq 1 $x`
do
mkdir dir_$i
done

#切割文本
a=`wc -l $input|grep -o -P ".*?(?=\ )"`
#y=$((x-1))
each=$(($a/$x))
split -l $each  $input -d -a 3 split_

#可能多出一份文件
maybe=`ls|grep split|wc -l|grep -o -P ".*?(?=\ )"`
if [ '$maybe' != '$x' ]
then
cat split_000 >> split_004 ; rm split_000
fi

#移动文件至对应数字目录
for i in `seq 1 $x`
do
#创建bash
mv split_00$i dir_$i/$input
echo '#!/bin/bash' >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo 'x=$x ; input=httprobe.txt' >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo "for q in "\`cat \$var\`";  do w=\`grep -o \$q /root/script/3_httprobe/dir_${i}/${input} | wc -l\` ; if [ \$w -eq 2 ]; then touch /root/script/3_httprobe/dir_${i}/http_\${q}.txt; curl -L http://\${q} >> /root/script/3_httprobe/dir_${i}/http_\${q}.txt; sort -u /root/script/3_httprobe/dir_${i}/http_\${q}.txt -o /root/script/3_httprobe/dir_${i}/http_\${q}.txt; touch /root/script/3_httprobe/dir_${i}/https_\${q}.txt; curl -L https://\${q} >> /root/script/3_httprobe/dir_${i}/https_\${q}.txt; sort -u /root/script/3_httprobe/dir_${i}/https_\${q}.txt -o /root/script/3_httprobe/dir_${i}/https_\${q}.txt; touch /root/script/3_httprobe/dir_${i}/\${q}.txt; comm -3 /root/script/3_httprobe/dir_${i}/http_\${q}.txt /root/script/3_httprobe/dir_${i}/https_\${q}.txt >> /root/script/3_httprobe/dir_${i}/\${q}.txt;  e=\`wc -l /root/script/3_httprobe/dir_${i}/\${q}.txt | grep -o -P ".*?(?=\ )"\`; if [ \$e -le 3 ]; then sed -e "/http\\:\\/\\/\${q}/d" httprobe.txt > /root/script/3_httprobe/dir_${i}/httpro.txt ; mv /root/script/3_httprobe/dir_${i}/httpro.txt httprobe.txt; fi; fi; rm /root/script/3_httprobe/dir_${i}/http_\${q}.txt ; rm /root/script/3_httprobe/dir_${i}/https_\${q}.txt ; rm /root/script/3_httprobe/dir_${i}/\${q}.txt; done" >> /root/script/3_httprobe/dir_${i}/${i}.sh
done


#执行并删除
echo '#!/bin/bash' >> exe.sh
for i in `seq 1 $x`
do
echo "bash /root/script/3_httprobe/dir_${i}/${i}.sh" >> exe.sh
done

cat exe.sh | parallel -j $x

for i in `seq 1 $x`
do
rm -r dir_$i
done

sort -u /root/script/3_httprobe/httprobe.txt -o /root/script/3_httprobe/httprobe.txt ; rm exe.sh

cat "iplist" | while read line
do
echo "Test $line En Cours .."
iscsiadm -m discovery -t sendtargets -p $line > testtmp.txt
awk '{print $2}' testtmp.txt > testtmp2.txt
awk '!a[$0]++' testtmp2.txt > testtmp3.txt
sed 's/^/'$line',/' testtmp3.txt >> iscsi.txt
rm testtmp*
done


cat "iscsi.txt" | while IFS=, read col1 col2
do
echo $col1/$col2 >> resultats.txt
iscsiadm --mode node --targetname $col2 --portal $col1:3260 --login >> resultats.txt
done
rm iscsi.txt

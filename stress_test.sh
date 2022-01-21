#!/bin/sh

echo "test start"
today=$(date)
s=0
m=0
l=0
index=0

sha1sum 300kb_test.txt | awk '{ print $1 }' > sha1_check_s.txt
sha1sum 10m_test.txt | awk '{ print $1 }' > sha1_check_m.txt
sha1sum 100m_test.txt | awk '{ print $1 }' > sha1_check_l.txt

while :
do
	
	if [ $index -le 100 ]
	then
		cp 300kb_test.txt 300kb_test$s.txt
		sha1sum 300kb_test$s.txt | awk '{ print $1 }' > sha1_check.txt
		diff -q sha1_check_s.txt sha1_check.txt > hash_result.txt
		s=$((s+1))
		if [ $s -eq 5 ]
		then
			echo "300kb_test success - ${today}" >> test_result.txt	
		fi
	elif [ $index -le 200 ]
	then
		cp 10m_test.txt 10m_test$m.txt
		sha1sum 10m_test$m.txt | awk '{ print $1 }' > sha1_check.txt
		diff -q sha1_check_m.txt sha1_check.txt > hash_result.txt
		m=$((m+1))
		if [ $m -eq 5 ]
		then
			echo "10m_test success - ${today}" >> test_result.txt
		fi
	elif [ $index -le 300 ]
	then 
		cp 100m_test.txt 100m_test$l.txt
		sha1sum 100m_test$l.txt | awk '{ print $1 }' > sha1_check.txt
		diff -q sha1_check_l.txt sha1_check.txt > hash_result.txt
		l=$((l+1))
		if [ $l -eq 5 ]
		then
			echo "100m_test success - ${today}" >> test_result.txt
		fi
	fi
	index=$((index+1))
	if [ $? -eq "0" ]
	then
		echo "true"
	else
		echo "false"
		exit 0
	fi

	sleep 1
done

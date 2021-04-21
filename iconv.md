iconv -f GB2312 -t UTF-8 test1.m -o test1.m 
iconv -f gbk -t UTF-8 test1.m -o test1.m 

for f in *.TXT; do iconv -f CP1250 -t utf-8 $f > $f.txt; done

-c     Silently  discard characters that cannot be converted
	  instead of terminating when encountering such charac‐
	  ters.

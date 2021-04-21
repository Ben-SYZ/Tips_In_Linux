/*************************************************************************
    > File Name: passwd.c
    > Author: Song Yuzhen
    > Mail: bensongsyz@gmail.com 
    > Created Time: 2019-08-03
 ************************************************************************/

#include<stdio.h>
int main()
{
	char a[100]="";
//	for (int i=0;i<100;i++)
//		a[i]=;
	for (int i=0;i<100;i++)
		printf("%c",*(a+i));
	char *p=a;
	while(~scanf("%c", p++));
	for (int i=0;i<100;i++)
		printf("%c",*(a+i));
	return 0;
}

%{
#include <stdio.h>
FILE* yyin;
int ycount = 0;
int operation = 0;
int countycount = 0;
int num;
int a, b, c;
int merge2(int a, int b, int c){
	return a*100+b*10+c;
}
int merge(int a, int b){
	return a*10+b;
}

%}
%%
y	{ycount++;}
[ ]	{
	countycount++;
	if(countycount==1){
		a = ycount;
	}else if(countycount==2){
		b = ycount; ;
	}else if (countycount == 3){
		c = ycount;
		countycount++;
	}
	
	ycount = 0;
}
\n{2}	{
	num = a;
	if(countycount==2){
		num = merge(a,b);
	}else if(countycount==3){
		num = merge2(a,b,c);
	}
	countycount=0;
	printf("%c",num);
	operation = 0;
	ycount = 0;
	
	}
\n	{
	num = a*10;
	if(countycount==2){
		num = merge(a,b);
	}else if(countycount==3){
		num = merge2(a,b,c);
	}
	countycount=0;
	printf("%c",num);
	operation = 0;
	ycount = 0;
	
}
%%
int main(int argc, char* argv[]){
yyin = fopen(argv[1], "r");
yylex();
fclose(yyin);
}
int yywrap(){
return 1;
}

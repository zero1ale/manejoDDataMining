PROC PRINT DATA=AA.POVERTY(OBS=10);RUN;

PROC UNIVARIATE DATA=AA.POVERTY;HIST;RUN;

PROC STDIZE DATA=AA.POVERTY METHOD=std OUT=XS; VAR Birth Death InfantDeath;RUN;
PROC STDIZE DATA=AA.POVERTY METHOD=RANGE OUT=XM; VAR Birth Death InfantDeath;RUN;

PROC PRINCOMP DATA=XS out=XP ;RUN;



ods graphics / reset width=4in height=4in imagemap;

proc sgplot data=WORK.XP;
	scatter x=Prin1 y=Prin2 /;
	xaxis grid;
	yaxis grid;
run;

PROC FASTCLUS DATA=XM maxclusters=5 OUT=XC;RUN;

PROC SORT DATA=XP;BY COUNTRY;RUN;
PROC SORT DATA=XC;BY COUNTRY;RUN;
DATA XP;
MERGE 
 XP(IN=A)
 XC(IN=B KEEP=COUNTRY CLUSTER);
 BY COUNTRY;
IF A AND B;
RUN;


ods graphics / reset width=6in height=6in imagemap;

proc sgplot data=WORK.XP;
	scatter x=Prin1 y=Prin2 / group=CLUSTER;
	xaxis grid;
	yaxis grid;
run;

ods graphics / reset;

proc means data=WORK.XC chartype mean  vardef=df;
	var Birth Death InfantDeath;
	class CLUSTER;
run;
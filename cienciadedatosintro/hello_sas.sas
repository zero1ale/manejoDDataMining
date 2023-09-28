
FILENAME REFFILE '/home/josegustavofue0/my_content/carpetas-de-investigacion-pgj-cdmx(1).csv';


PROC IMPORT DATAFILE=REFFILE
	DBMS=DLM
	OUT=AA.delitos;
	DELIMITER=";";
	GETNAMES=YES;
RUN;

FILENAME REFFILE '/home/josegustavofue0/my_content/delitos.xlsx';

PROC IMPORT DATAFILE=REFFILE
	DBMS=XLSX
	OUT=AA.DELITOS;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=AA.delitos; RUN;

PROC FREQ DATA=AA.DELITOS ;TABLES categoria_delito colonia_hechos;run;

DATA X;
 SET AA.DELITOS(KEEP=categoria_delito colonia_hechos fecha_hechos
 WHERE =(categoria_delito NOT IN	('DELITO DE BAJO IMPACTO','HECHO NO DELICTIVO')));
 MES = SUBSTR(FECHA_HECHOS,1,4)*100+SUBSTR(FECHA_HECHOS,6,2);
 
RUN;

PROC SQL ;
 CREATE TABLE XX AS 
 SELECT categoria_delito,COUNT(*) AS CASOS
 FROM X GROUP BY categoria_delito ORDER BY CASOS DESC;
QUIT;

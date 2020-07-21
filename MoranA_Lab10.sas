/*****************************************************************************
* Name: Acacia Moran
* Assignment:  Lab 10
*****************************************************************************/

/* this creates the macro*/

/* part 1*/

%let location = /folders/myshortcuts/MY_FOLDER/;

/* part 2a*/

data NY ;

infile "&location.Data_parking.dat" ; 

input date monyy7. +7 state comma9.0 +1 city comma5.0 contractor;
run;

/* part 2b*/

proc contents data= NY;

run;

/* yes all vars are numeric*/

/* part 2c check*/

proc print data = NY;

run;

/* part 2d*/

proc means data = NY mean;

var city;

class contractor;

run;

/* mean for other contractor 6754.78
mean for Brinks is 6933.75 the Brinks contractor has a higher mean*/

/* step 3 a*/

data music ;

infile "&location.Data_music_files.dat" ; 

input  @"ALBUM: " album $ @"FILE:" song : $34. bytes : comma.;

/* step 3b*/

lengthsong = length(song);

run;

proc contents data = music;
run;

proc print data = music;

run;

ods graphics on;

/* this gives the data a title*/

title 'Lenght of song and Bytes Data';

/* this does a correlation procedure plots= scatter makes the scatter plots*/

PROC CORR DATA = music plots = scatter;

/* this tell the main variable*/

    VAR lengthsong;

/* this tells what variable to compare the main one to*/

    WITH bytes;
    
/* this runs proc corr*/

RUN;

/* this turns the graphics off*/

ods graphics off;

/* the p value was .2368 which is not significant at the .05 signifcance
level. The correlation is.1866 which is very low. Also the scatter plot shows that 
its linear except one outlier*/

/* step 3d */

proc univariate data=music;

var lengthsong;

run;

/* step 4a*/

data shake ;

infile "&location.Earthquake.dat" ; 

input  name $1-4 magnitude 6-8 @10 DT ymddttm24. Latitude Longitude Depth Location $char43.;

run;

/* step 4b*/

/* yes only name and location are char var*/

proc contents data= shake;

run;


proc print data = shake;

run;

/* step 4c*/

proc sgplot data = shake;

series x = DT y = magnitude;
format DT datetime9.;
run;

/* step 4d*/

proc freq data = shake;

where location contains "MEXICO";

run;

proc freq data = shake;

where location contains "ALASKA";

run;

/* there were 17 quakes in Mexico and 46 quakes in Alaska*/



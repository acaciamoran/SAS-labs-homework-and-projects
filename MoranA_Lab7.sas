/*****************************************************************************
* Name: Acacia Moran
* Assignment:  Lab 7
*****************************************************************************/

/* this gets creates a library*/

libname alz "/folders/myshortcuts/sf_MY_FOLDER/";

/* this is Step 2 */

/* this creates my own format for dx variable */

proc format;

value diag 1 = "Normal"
		   2 = "MCI"
		   3 = "AD";

/* this prints the data to the screen */

proc print data = alz.adni;

format dx diag.;

title "Problem 2";

run;


/* this is Step 3 */

/* this creates the data set*/

data alzdata;

/* this put the adni data in*/

set alz.adni;

/* this gives the dx the "Diagnosis" lable */

label dx = "Diagnosis";

/* this applies the format */

format dx diag.;

run;

/* Step 4a*/

proc sgplot data = alzdata;

/* default is stacked */

vbar dx / Group = APOE4;

title "Question 4a";

run;

/* Step 4b */

proc sgplot data = alzdata;

/* this forces the bars to be side by side with cluster */

vbar dx / Group = APOE4 groupdisplay = cluster;

title "Question 4b";

run;

/* Step 5 */

/* this sorts the data by dx */

proc sort data = alzdata;

by dx;

run;

/* this creates the boxplot */

proc sgplot data = alzdata;

/* the h makes the boxplot horizantal */

hbox MMSE / group = dx;

title "Question 5";

run;

/* Step 6a */

proc sgplot data= alzdata;

/* this makes the first histogram */

histogram MMSE / transparency = 0.5 name = "MMSE" legendlabel = "MMSE";

/* this makes the seconds histogram*/

histogram ADAS / transparency = 0.5 name = "ADAS" legendlabel = "ADAS";

/* this gives the graph a legend*/

keylegend "MMSE" "ADAS" / across=1 position=TopRight location=Inside;

title "MMSE and ADAS for Question 6a";

run;

/* Step 6b */

proc sgplot data= alzdata;

/* this makes the first histogram */

histogram MMSE / group = GENDER transparency = 0.5 name = "MMSE" legendlabel = "MMSE";

/* this gives the graph a legend*/

/* if legend is wanted comment this in */

/*keylegend "MMSE" "GENDER" / across=1 position=TopRight location=Inside;*/

title "MMSE and GENDER for Question 6b";

run;

/* Step 7 */

proc sgplot data = alzdata;

/* this creates a scatter plot */

scatter x = AGE y = WHOLEBRAIN/

/* this makes the circles filled in*/

markerattrs= (symbol = circlefilled);

title "Question 7";

run;

/* Step 8 */

/* this makes the macro that takes in one variable*/

%macro scatter(color);

/* this give the plot a title using the inputed color*/

title "Scatter plot of whole brain vs age by &color";

/* this makes a plot with the temporary data set from before*/

proc sgplot data=alzdata;

/* this makes the data into a scatter plot with wholebrain and age*/

/* the group breakes it up by the color that was put into the macro*/

/* the markerattrs tells SAS was symbol to use and to fill it in*/

	scatter y=wholebrain x=age / group=&color markerattrs=(symbol=CircleFilled);

run;

/* this ends the macro*/

%mend;

/* thid turns on the graphics in sas */
/* the imagename gives the image a name */
/* the reset index will over right any old images if they have the same name*/

ods graphics on / imagename="Question8a" reset=index;

/* this takes in the variables gender for the scatter plot*/

%scatter(gender);

/* this turnt he graphics back off*/

ods graphics off;


ods graphics on / imagename="Question8b" reset=index;

/* this takes in the variables APOE4 for the scatter plot*/

%scatter(APOE4);

/* this turns he graphics back off*/

ods graphics off;


ods graphics on / imagename="Question8c" reset=index;

/* this takes in the variables APOE4 for the scatter plot*/

%scatter(dx);

/* this turns he graphics back off*/

ods graphics off;



		
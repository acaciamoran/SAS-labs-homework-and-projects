/*****************************************************************************
* Name: Acacia Moran
* Assignment:  Lab 15
*****************************************************************************/
/* step 1 a b */

/* in data steps I inputed the data to create a temporary data set I also used
data step to create tracking variables and new variables. I used proc data steps to 
print the data to get information on the data and to boht sort the data by country and 
get the number of observations and to describe the data. I used if and incrimentated 
variables to create new ones as sas goes through each observation to both create new 
variables and to find out information on variables*/

/* step 2 a b */

/* to create this table with proc tabulate I am going to set the class statement to 
country so as to display the country in the rows. I will put N a sum a max a mean a ratio
a mean and prop to get the different data we wanted. I will use data steps to create
the variables that I dont have in the data. I will use proc statement to create both 
the tables and to print the data to reference*/

/* step 2 c*/

/* in the table there will be country age weight and gender. In the rows there will 
be */

/* step 3*/

/* this gets creates a library*/

libname olympic "/folders/myshortcuts/MY_FOLDER/";

data theolympics;

set olympic.O2012;

run;

/* step 4a*/

proc tabulate data = theolympics;
class country;
var total;
table country, all*N;
run;

/* step 4b*/

proc tabulate data = theolympics;
class country;
var total;
table country, total*(sum);
run;

/* step 4c*/

proc tabulate data = theolympics;
class country;
var total;
table country, all*( N total*(sum mean max));
run;

/* step 4d*/

proc tabulate data = theolympics;
class country gender;
var total age weight;
table country, all*(N total*(sum mean max) age*(mean) weight*(mean));
run;

/*step 4e*/

proc tabulate data = theolympics;
class country gender;
var total age weight;
table country, all*(N total*(sum mean max) age*(mean) weight*(mean) gender*(rowpctn));
run;

/* step 5 */

proc tabulate data = theolympics;
class country gender;
var total age weight;
table country = "", all*( N total*(sum mean = "Ratio" max) age*(mean = "Average") weight*(mean = "Average") gender*(rowpctn = ""))/ box="Country";;
label total = "Total Medals" age = "Age (yrs)" weight = "Weight (kg)" gender = "Gender";
keylabel N = "# Medalists" max = "Max per Athlete";
run;

/* step 6a */
/* step 6d*/

proc tabulate data = theolympics;
class country gender;
var total age weight;
table country = "", all*( N total*(sum*f=2. mean = "Ratio"*f=4.2 
max = "Max per Athlete"*f=2.) age*(mean = "Average"*f=4.1) 
weight*(mean = "Average"*f=4.1) gender*(rowpctn = ""*f=pct.))/ box="Country" misstext='----';
label total = "Total Medals" age = "Age (yrs)" weight = "Weight (kg)" gender = "Gender";
keylabel N = "# Medalists";
format gender $sex.;
run;

/* step 6b*/

proc format;
 value $sex "F" = "Female"
 			"M" ="Male";
run;

/* step 6c*/

proc format ;
	picture pct(round) low-high='009.9%';
run;				

/* step 7*/

proc tabulate data = theolympics;
class country gender;
var total age weight;
table country = "", all*( N*{style={background=hlpct.}} total*(sum*f=2. mean = "Ratio"*f=4.2 
max = "Max per Athlete"*f=2.) age*(mean = "Average"*f=4.1) 
weight*(mean = "Average"*f=4.1) gender*(rowpctn = ""*f=pct.))/ box="Country" misstext='----';
label total = "Total Medals" age = "Age (yrs)" weight = "Weight (kg)" gender = "Gender";
keylabel N = "# Medalists";
format gender $sex.;
run;

proc format ;
	value hlpct 20-high="PAPB";
run;

/*step 8*/

ods pdf file="/folders/myshortcuts/MY_FOLDER/Lec16table.pdf" style=sasweb ;
OPTIONS ORIENTATION=LANDSCAPE NODATE NONUMBER;
proc tabulate data = theolympics;
class country gender;
var total age weight;
table country = "", all*( N*{style={background=hlpct.}} total*(sum*f=2. mean = "Ratio"*f=4.2 
max = "Max per Athlete"*f=2.) age*(mean = "Average"*f=4.1) 
weight*(mean = "Average"*f=4.1) gender*(rowpctn = ""*f=pct.))/ box="Country" misstext='----';
label total = "Total Medals" age = "Age (yrs)" weight = "Weight (kg)" gender = "Gender";
keylabel N = "# Medalists";
format gender $sex.;
run;
ods pdf close;


/* step 9*/
%macro colorer (style= , color= );
	
	OPTIONS MPRINT MLOGIC SYMBOLGEN;
	proc format ;
		value hlpct 20-high="&color";
	run;
	ods pdf file="/folders/myshortcuts/MY_FOLDER/&style&color.pdf" style= &style ;
	OPTIONS ORIENTATION=LANDSCAPE NODATE NONUMBER;
	proc tabulate data = theolympics;
	class country gender;
	var total age weight;
	table country = "", all*( N*{style={background=hlpct.}} total*(sum*f=2. mean = "Ratio"*f=4.2 
	max = "Max per Athlete"*f=2.) age*(mean = "Average"*f=4.1) 
	weight*(mean = "Average"*f=4.1) gender*(rowpctn = ""*f=pct.))/ box="Country" misstext='----';
	label total = "Total Medals" age = "Age (yrs)" weight = "Weight (kg)" gender = "Gender";
	keylabel N = "# Medalists";
	format gender $sex.;
	run;
	ods pdf close;

%mend colorer;

%colorer(style = Pearl, color = LIOY);
%colorer(style = RTF, color = ROSE);
%colorer(style = PRINTER, color = LIBG);			

/* my prefered style/color combination was printer and LIBG*/

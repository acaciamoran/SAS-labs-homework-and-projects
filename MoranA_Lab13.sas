/*****************************************************************************
* Name: Acacia Moran
* Assignment:  Lab 13
*****************************************************************************/

/* Part 1*/

%let path = /folders/myshortcuts/MY_FOLDER/;

/* Part 2 */

PROC IMPORT

/* this tells it where to find the data*/

   DATAFILE="&path.babies.csv"
   
/* this tells what to call the data*/

   OUT = babies2
   
/* this tells sas what kind of file it is*/

   DBMS = CSV

/* this has it actually replace the data*/

   REPLACE;

/* this runs the proc import*/

RUN;

/* Part 3a */

proc sort data = babies2 out = babysmoke;

/* this sorts the data by smoke*/

by smoke;

run;


/* the mean and sd are about the same and so there doesnt seem to be
relationship between mother’s smoking status and baby birth weight*/

/* this does a proc means step*/

proc means data=babysmoke;

/* this seperates the data by smoking or non smoking moms*/

	class smoke;

/* this tells sas what variable to find the mean of */
	
	var bwt;
	
/* step 3b*/

/* this tells sas to output the summary statistics*/
	
	output out=summarystats;
	
/* this runs the proc means */
	
run;

proc print data = summarystats;

run;

/* step 3c*/

/* this does a transpose on the data so that we can use the statistics as varaiables*/

PROC TRANSPOSE

/* this tells sas what data set ot use and how to organize it*/

DATA = summarystats OUT = baby NAME = babyweight; ID _stat_ ;

/* this tells it by what variable to organize the data by*/

BY smoke ;

/* this tells proc what variable to transpose by*/

VAR bwt ;

/* this runs the pro transpose*/

RUN;

/* this creates a new data step*/

data baby2;

/* this inputs the data into this new data set*/

set baby;

/* this tells sas to take out the data where smoke is missin*/

where smoke ne .;

/* this runs the data step*/

run;

proc print data = baby2;

run;

/* step 3d */

/* this creates a format we can use for smoke*/

proc format;

/* this assigns 0's to a new name and 1's to a new name*/

value code 0 = "Non-smoking mothers"

		   1 = "Smoking mothers";

/* this runs the format*/

run;

/* this creates a new data set*/

data formatbaby;

/* this sets the data to the new data set*/

set baby2;

/* this applies the formats we want to the data*/

format smoke code. STD 4.1 MEAN 5.1;

/* this only keeps the variables we want*/

keep smoke N MIN MAX MEAN STD;

/* this runs the data step*/

run;


proc print data= formatbaby;

run;

/* step 3e*/

/* this allows us to export the data as a different kind of data file*/

PROC EXPORT

/* this takes in the specified data*/

	DATA = formatbaby

/* this tells it where to put the new data and what to call it*/
	
	OUTFILE = "&path/BabiesSummaryStats.csv"

/* this tells it what kind of datafile to make it*/
	
	DBMS = CSV

/* this runs the data part*/
	
	REPLACE ;

/* this runs the proc export*/
	
RUN;

/* Part 4a*/

/* this turns the graphics on*/

ods graphics on;

/* this runs a regression of the data*/

proc reg data = babysmoke;


/* this tells it what variables to use dependent is bwt*/

   model bwt = gestation parity age height weight smoke;

/* step 4c */

/* this tells it to store the predicted and residuls as variables in
the data set*/
 
   output out = reg_results predicted = yhat residual = resid;
   
/* this runs the proc reg*/

quit;

/* this turns the graphics off*/

ods graphics off;

/* step 4b */

/* age is the only varible not associated with btw at the .o5 significance level
it has a p value of .917 which is about thesignificance level*/

/* parity and smoke seem to appear to be associated with 
having a baby with lower birth weight because there t statitics
are negative*/

proc print data = reg_results;

run;

/* step 4d*/

/* this sorts the data and puts it in a new data set 
called sorted*/

proc sort data = reg_results out = sorted;

/* this sorts the data by resid*/

by resid;

/* this tells it to take out the data that is missing a residual*/

where resid ne .;

/* this runs the proc sort*/

run;

proc print data = sorted;

run;

/* step 4e */

/* this creates a new data set*/

data birth;

/* this brings in the data to the new data set*/

set sorted;

/* these if statements check to see if the residual differs by more the 50*/

if resid > 50 then output;

if resid < -50 then output;

/* this takes out the missing residual from the data*/

where resid ne .;

/* this runs the data step*/

run;

proc print data = birth;

run;

/* there were 4  babies with residuals that differ by more than 50 
-57.6128, -51.5968, -50.4344, 51.7131*/


/* step 4f*/

/* this allows us to export the data*/

PROC EXPORT

/* this take in a data set to export*/

	DATA = sorted

/* this tells it where to put the data and what to call it*/
	
	OUTFILE = "&path/BabiesResids.csv"
	
/* this tells it what kind of file to export it as*/
	
	DBMS = CSV
	
/* this runs the data part and replaces it*/
	
	REPLACE ;

/* this runs the proc export*/
	
RUN;





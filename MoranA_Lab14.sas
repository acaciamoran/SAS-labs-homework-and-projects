/*****************************************************************************
* Name: Acacia Moran
* Assignment:  Lab 14
*****************************************************************************/


/* Part 1*/

%let path = /folders/myshortcuts/MY_FOLDER/;

/* part 2*/

libname flash "&path";

/* part 3 a*/

/* proc contents allows us to examine the data*/

proc contents data =flash.australia;

run;

/* proc contents allows us to examine the data*/

proc contents data =flash.france;
run;

/* proc contents allows us to examine the data*/

proc contents data =flash.india;
run;

/* proc contents allows us to examine the data*/

proc contents data =flash.brazil;
run;

/* proc contents allows us to examine the data*/

proc contents data =flash.unitedstates;
run;

/* proc contents allows us to examine the data*/

proc contents data =flash.russia;
run;

/* proc contents allows us to examine the data*/

proc print data = flash.australia;
run;

/* each data set has the words for female and male in there own
language as variables.This could result in a problem because 
sas wont reconize them as the same variable. Also each has the 
names of 10 different males and females*/

/* step 3b*/

/* this creates the macro for adding the rank vairable*/

%macro ranker (country =);

/* this crates a new data set called nameofcountryrank that
has the rank variable*/

data &country.rank;

/* this takes in the old data without rank*/

	set flash.&country;

/* this keep track of the rank and makes a rank variable*/

	rank + 1;

/* this runs the data step*/

/* this allows us to have it all be in english*/


run;

/* this ends the macro*/

%mend ranker;

/* this runs the data for australia*/

%ranker(country = australia );


/* this runs the data for brazil*/

%ranker(country = brazil);


/* this runs the data for france*/

%ranker(country = france);


/* this runs the data for india*/

%ranker(country = india);


/* this runs the data for russia*/

%ranker(country = russia);


/* this runs the data for unitedstates*/

%ranker(country = unitedstates);



/* step 3c*/

/* this creates a new data set*/

data allcountry;

/* this bring in the new data and renames the variables to Girl and Boy
for all the countries*/

	set australiarank 
	brazilrank (rename = (Menina = Girl) rename = (Menino = Boy) )
	francerank (rename = (Fille = Girl) rename = (Garcon = Boy)) 
	indiarank (rename = (Laraki = Girl) rename = (Laraka = Boy))
	russiarank (rename = (Devushka = Girl) rename = (Malchik = Boy))
	unitedstatesrank;


/* this seperates the data by rank*/

/* this creates a new variable called country */

/* step 3d */

/* this tells dad what to merge by*/

by rank;

/* this creates a new variable called start to help us track and
create a new variable called country*/

if first.rank then start = 0;

/* Since the data is sorted alphabetically we know autralia always
come first so we use the start when its zero to store that country as australia*/

if start = 0 then country = "Australia";

/* does the same thing for Brazil*/

if start = 1 then country = "Brazil";

/* does the same thing for france*/

if start = 2 then country = "France";

/* does the same thing for india*/

if start = 3 then country = "India";

/* does the same thing for russia*/

if start = 4 then country = "Russia";

/* does the same thing for united states*/

if start = 5 then country = "United States";

/* this incriments the start tracker*/

start + 1;

/* this seperates the data by rank*/

/* this runs the data step*/

/* this drops the tracker variable*/

drop start;
	
run;

/* step 3e*/

proc print data = allcountry;

run;

/* step 4 a */

/* proc contents allows us to see the number of observations*/

proc contents data = flash.users;

/* this runs the proc contents*/

run;

/* proc contents allows us to see the number of observations*/

proc contents data = flash.projects;

/* this runs the proc contents*/

run;

/* this allows us to see variable names so we know what 
to use for the by statement*/

proc print data = flash.projects;

/* this runs the proc print*/

run;

/* this allows us to see variable names so we know what 
to use for the by statement*/

proc print data = flash.users;

/* this runs the proc print*/

run;

/* there are 1797 observations in users and 7266 observations in projects */

/* since there aren't the same number of observations it would not make sense to 
use stack. Also the only variable they share is user id so we will 
want to combine them by that variable. We dont want to interleave because we want
to associte each user to a project. Therefore we want to merge. We dont want to
do a one to one merge because 1 user can have more than on project
so we will do a one to many merge.*/

/* step 4b*/

/* this sorts the data so that we can combine it with the users data*/

proc sort data = flash.projects;

/* this tells it what to sort by*/

by UserID;

/* this rusn the proc sort*/

run;

/* this creates a new data set*/

data combined ;

/* this tells what data sets to merge*/

   merge flash.users flash.projects ;

/* this tells what variable to merge by*/
  
   by UserID;
   
/* this runs the data step*/

run;

/* this prints the data*/

proc print data = combined;

run;

/* this allows us to see the number of observations*/

proc contents data = combined;

run;

/* there are 7273 observations in the combined data set*/

/* step 4c */

data incomplete ;

/* this tells what data sets to merge*/

   merge flash.users flash.projects ;

/* this tells what variable to merge by*/
  
   by UserID;

/* this gets all the data that has no end data*/
   
   if EndDate = "" then output;
   
/* this runs the data step*/

run;

/* this allows us to get the number of observatiosn in the data with no end data*/

proc contents data = incomplete;

run;

/* there are 3146 projects that are incomplete*/


data complete ;

/* this tells what data sets to merge*/

   merge flash.users flash.projects ;

/* this tells what variable to merge by*/
  
   by UserID;

/* this gets rid of all the data that has no end data*/
   
   if EndDate ne . then output;
   
/* this runs the data step*/

run;

/* this allows us to get the number of obsevationsin the data with a end data*/

proc contents data = complete;

run;

/* there are 4127 projects that are completed*/

data nowork ;

/* this tells what data sets to merge*/

   merge flash.users flash.projects ;

/* this tells what variable to merge by*/
  
   by UserID;

/* this keeps the data with no projects*/
   
   if ProjectID = . then output;
   
/* this runs the data step*/

run;

/* this allows us to get the number of obsevationsin the data with a end data*/

proc contents data = nowork;

run;

/* there are 7 people with no projects*/

/* step 4d i */

/* this creates a new data set called newvar*/

data newvar;

/* this brings in the ol data set*/

set complete;

/* this sorts the data by user id*/

by UserID;

/* this checks if its that person first project 
if so it sets the tracker to zero*/

if first.UserID then total = 0;

/* this incriments the tracker*/
 
total + 1;

/* this checks if its the users last project
if so it outputs*/

if last.UserID then output;

/* this runs the data step*/

run;

/* this prints the data*/

proc print data = complete;

run;

/* step 4d ii*/

/* this finds the max for the tracker variable*/

proc means data = newvar max;

/* this tells sas to find the max of this variable*/

var total;

/* this runs the means*/

run;

/* the max number of projects completed by one person is 8*/

/* step 4d iii*/

/* this prints the data*/

proc print data = newvar;

/* this tells it to only print the data for
the person with 8 projects which is the max*/

where total = 8;

/* this runs the proc print*/

run;

/* Joseph Turner has the most completed projects*/

/* step 4 iv*/

/* this prints the data*/

proc print data = combined;

/* this tells it to only print the data where the user is the user with
the max number of projects completed*/

where UserID = 1669;

/* this applies a format to the dates so that 
they appear as calendar dates instead*/

format EndDate mmddyy. StartDate mmddyy.;

run;




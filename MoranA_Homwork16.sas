/*****************************************************************************
* Name:        YOUR NAME HERE
* Assignment:  Homework 16-25
*****************************************************************************/

*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;

/****************************************************************************** 
You've already learned about the power of PROC TABULATE to produce a table
of summary statistics.  In this lesson we'll learn yet another alternative, 
PROC REPORT.

PROC REPORT behaves like PROC PRINT, in that it can be used to display 
rows of a data set.

PROC REPORT also behaves like PROC MEANS, PROC FREQ, and PROC TABULATE in that
it can be used to obtain summary statistics.

With PROC REPORT, the user can also control additional formatting/display 
options like with PROC TABULATE. 

For demonstratation purposes, we are again going to be working with the 
patents.sas7bdat data set.  This data reports the number of utility patent 
('patents for inventions') grants from 2011 for counties in the US, in addition
to some demographic variables about the county.
- Modify the libname statement to the directory of your SAS data sets.
- Submit the following data step to create some additional variables.
******************************************************************************/

libname flash "C:\Users\hglanz\Google Drive\STAT330\Data";

*create a temporarary data set called patents - work with this data set 
for the remainder of the exercsies;
data patents;
	set flash.patents;
	length division $30. ;

	*The US census divides states into Regions and Divisions.  Each for the 4 census regions is divided into 2 or more divisions.;
	if state in ("CONNECTICUT" "MAINE" "MASSACHUSETTS" "NEW HAMPSHIRE" "RHODE ISLAND" "VERMONT") then division="New England";
	if state in ("NEW JERSEY" "NEW YORK" "PENNSYLVANIA") then division="Middle Atlantic";
	if state in ("ILLINOIS" "INDIANA" "MICHIGAN" "OHIO" "WISCONSIN") then division="East North Central";
	if state in ("IOWA" "KANSAS" "MINNESOTA" "MISSOURI" "NEBRASKA" "NORTH DAKOTA" "SOUTH DAKOTA") then division="West North Central";
	if state in ("DELAWARE" "DISTRICT OF COLUMBIA" "FLORIDA" "GEORGIA" "MARYLAND" "NORTH CAROLINA" "SOUTH CAROLINA" "VIRGINIA" "WEST VIRGINIA") then division="South Atlantic";
	if state in ("ALABAMA" "KENTUCKY" "MISSISSIPPI" "TENNESSEE") then division="East South Central";
	if state in ("ARKANSAS" "LOUISIANA" "OKLAHOMA" "TEXAS") then division="West South Central";
	if state in ("ARIZONA" "COLORADO" "IDAHO" "MONTANA" "NEVADA" "NEW MEXICO" "UTAH" "WYOMING") then division="Mountain";
	if state in ("ALASKA" "CALIFORNIA" "HAWAII" "OREGON" "WASHINGTON") then division="Pacific";

	if division in ("New England" "Middle Atlantic") then region="Northeast";
	if division in ("East North Central" "West North Central") then region="Midwest";
	if division in ("South Atlantic" "East South Central" "West South Central") then region="South";
	if division in ("Mountain" "Pacific") then region="West";

	*This indicates if the percent of the county with at least a bachelors degree exceeds 25 or not;
	if education gt 25 then edu25=1;
	else edu25=0;

	*This indicates if the percent of the county that is unemployed exceeds 10 or not;
	if unemployed gt 10 then unemp10=1;
	else unemp10=0;
run;

*view variables in patents data set;
proc contents data=patents varnum; run;

*view first 10 observations;
proc print data=patents (obs=10); run;

/****************************************************************************** 
The syntax for PROC REPORT is:

PROC REPORT DATA = dataset ;
	COLUMN item1 item2...  ;
	DEFINE item1 / options ;
	DEFINE item2 / options ;
RUN;

Let's compare some ways to view the patents data for counties in Arizona (just
to keep the output short).
******************************************************************************/

*First method - proc print;
proc print data=patents;
	where state="ARIZONA";
run;

*Second method - proc report;
proc report data=patents;
	where state="ARIZONA";
run;

/****************************************************************************** 
Compare the two pieces of output.  

With PROC PRINT
-rows are labeled with observation number
-variable names are used as column headers

With PROC REPORT
-no row labels
-variable labels are used as column headers
-you might also see some text wrapping in cells

By default, if no COLUMN statement is specfied, then PROC REPORT prints all
variables in the data set.  To specify the variables to be printed, use
the COLUMN statement.
******************************************************************************/

*First method - specify variables using VAR in proc print;
proc print data=patents;
	where state="ARIZONA";
	var county state patents population;
run;

*Second method - specify variables using COLUMN in proc report;
proc report data=patents;
	where state="ARIZONA";
	column county state patents population;
run;


/****************************************************************************** 
Now let's summarize the data instead of viewing observations.  How many 
patent-holding counties are there in each region?  The first two methods
(proc freq and proc tabulate) you already saw in HW15.  

A third method is to use PROC REPORT with a DEFINE statement.  DEFINE 
  - tells SAS how to treat the variable
  - requires an option: ACROSS, ANALYSIS, COMPUTED, DISPLAY, GROUP, ORDER

This objective can be achieved by using ACROSS, which places values in columns.
******************************************************************************/
title "One-way table - proc freq";
proc freq data=patents;
	tables region;
run;
title ;

title "One-way table - proc tabulate";
proc tabulate data=patents; 
	class region;
	table region; 
run;
title ;

title "One-way table - proc report";
proc report data=patents; 
	columns region  ;
	define region / across  ; 
run;
title ;

/****************************************************************************** 
Let's create a two-dimensional table that shows the number counties with 
patents with regards to region and edu25.  The first two methods
you saw already in HW15.  

To create a two-way table in PROC REPORT that mimics the PROC FREQ and PROC
TABULATE output, we want
 - values of edu25 in the columns (use ACROSS option in DEFINE)
 - values of region along the rows (use GROUP option in DEFINE)
******************************************************************************/

title "Two-way table  - proc freq";
proc freq data=patents;
	tables region*edu25 / norow nopercent nocol;
run;
title ;

title "Two-way table  - proc tabulate";
proc tabulate data=patents; 
	class region edu25;
	table region, edu25; 
run;
title ;

title "Two-way table  - proc report";
proc report data=patents; 
	columns region edu25 ;
	define region / group;  *group for rows;
	define edu25  / across; *across for columns; 
run;
title ;

/****************************************************************************** 
Note that you can have an unlimited number of DEFINE statements.

Before we obtained the *number of counties* with utility patent grants.  But 
each county has a different *number of patents*.  So how many patents do these 
regions have?

Below, are two methods we already learned (proc means and proc tabulate).
******************************************************************************/

title "Total # patents by region/edu25 - proc means";
proc means data=patents N sum;
	class region edu25;
	var patents;
run;

title "Total # patents by region/edu25 - proc tabulate";
proc tabulate data=patents; 
	class region edu25;
	var patents;
	table region, edu25*patents*(N sum); 
run;

/****************************************************************************** 
Now let's achieve the same objective with PROC REPORT.
 - Patents is a numeric variable in the data set and is defined as an ANALYSIS variable 
   for PROC TABULATE (which means we want to calculate statistics for this variable).
   The default summary statistic produced is SUM.
 - To also produce the sample size for each combination of region/edu25, we 
   need to place N on the COLUMNS statement
 - Since edu25 utlizes the GROUP option (goes along rows), this produces a vertical
   orientation of the table similar to PROC MEANS.
******************************************************************************/
title "Total # patents by region/edu25 - proc report";
title2 "edu25 in GROUP";
proc report data=patents; 
	columns region edu25 N patents ;
	define region / group; *group for rows;
	define edu25  / group; *group for rows;
	define patents / analysis; *analysis to get a statistic from a numeric variable;
	*define patents / analysis SUM; *this demonstrates how to explicitly request a statistic; 
run;
title ;
title2 ;


/****************************************************************************** 
The default summary statistic produced for an analysis variable is SUM.
To explicitly specify this statistic, or a different statistic, we could use 
	DEFINE patents / analysis SUM;
******************************************************************************/


/****************************************************************************** 
Now it is your turn to practice:

Using PROC REPORT, create table with:
   -geographical region along the rows
   -geographical division along the rows (should appear nested within region)
   -the following statistics under the columns:
		~number of counties
		~total number of patents
		~total population size
		~average age (This will display as Median Age in your table because
         the variable age represents the median age of the county - you want to
		 calculate the average of the median ages.) 
******************************************************************************/


*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;

libname flash "/folders/myshortcuts/MY_FOLDER/";

proc report data=patents; 

	columns region division N patents population age;
	define region / group; *group for rows;
	define division  / group; *group for rows;
	define population / analysis SUM;
	define patents / analysis SUM;
	define age/ analysis mean;
run;











/****************************************************************************** 
Compare your PROC REPORT output to the 'equivalent' PROC MEANS  and PROC
TABULATE output.  What do you see as pros and cons of the different methods?  
******************************************************************************/
proc means data=patents N sum mean;
	class region division;
	var patents population age;
run;

proc tabulate data=patents ;
	class region division;
	var patents population age;
	table region*division, ALL patents population age*mean;
run;






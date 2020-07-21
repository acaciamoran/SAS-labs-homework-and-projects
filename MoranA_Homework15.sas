/*****************************************************************************
* Name:        Acacia Moran
* Assignment:  Homework 15-24
*****************************************************************************/

*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;

/****************************************************************************** 
The following procedures can be used to get various summary statistics:
PROC PRINT - N, SUM
PROC MEANS - N, SUM, MEAN, STD, etc.
PROC FREQ  - N, percents

PROC TABULATE can compute all of these statistics in a results table that 
allows the user to control additional formatting options. 

For demonstratation purposes, we are going to be working with the 
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
PROC TABULATE can create 1, 2, or 3 dimensional tables, and the default
summary statistic reported is N (counts).  The syntax is:

PROC TABULATE DATA = dataset ;
	CLASS catvar1 catvar2...  ;
	VAR quantvar1 quantvar2... ;
	TABLE page-var, row-var, col-var;
RUN;

Let's compare two ways to identify the number of counties with utility patent
grants.
******************************************************************************/

*First method - proc freq;
proc freq data=patents;
	tables region;
run;

*Second method - proc tabulate;
*With ONE variable in the TABLE statement, the variable goes on the COLUMNS;
proc tabulate data=patents; 
	class region;
	table region; 
run;

*To request a statistic, do var*statistic on the TABLE statement;
*The default statistic is the count, N, so this PROC gives the same results
as the PROC above;
proc tabulate data=patents; 
	class region;
	table region*N; 
run;

/****************************************************************************** 
Let's create a two-dimensional table that shows how many counties with 
utility patent grants with regards to region and whether or not the county has 
at least 25% of the population with at least a bachelor's degree.
******************************************************************************/

*First method - proc freq;
proc freq data=patents;
	tables region*edu25 / norow nopercent nocol;
run;

*Second method - proc tabulate;
*With TWO variables in the TABLE statement, 
	-the first variable goes on the ROWS
	-the second variable goes on the columns;
proc tabulate data=patents; 
	class region edu25;
	table region, edu25; 
run;

*Again, the default statistic is the count, N, so this PROC gives the same results
as the PROC above;
proc tabulate data=patents; 
	class region edu25;
	table region, edu25*N; 
run;

/****************************************************************************** 
Note that ALL categoricical variables in the TABLE statement MUST also
go in the CLASS statement.

A limitation of PROC FREQ is that we can only request statistics for
categorical variables, like counts and percents.  In PROC TABULATE, we can
request statistics for quantitative variables, like means, standard deviations,
and sums (like with PROC MEANS).

When using a quantitative variable
-The quantitative variable must go in the VAR statement
-In the TABLE statement, the syntax is catvar*quantvar
-The defualt summary statistic is SUM

Before we obtained the *number of counties* with utility patent grants.  But each 
county has a different *number of utility patent grants*.  For example, if
you review the PROC PRINT output from above, you see that in Alabama, Baldwin
County has 8 patents and Calhoun County only has 1.  

So how many patents do these regions have?
******************************************************************************/

*One dimensional table that shows the total number of patents per region ;
*The syntax on the TABLE statement is 
TABLE catvar *  quantvar ;
proc tabulate data=patents; 
	class region;
	var patents;
	table region*patents; 
run;

*Because the default statistic is SUM, the above code is equivalent to this code;
*Note the syntax on the TABLE statement is
TABLE	catvar *  quantvar * statistic; 
proc tabulate data=patents; 
	class region;
	var patents;
	table region*patents*sum; 
run;

*To obtain both
-the number of counties per region, and
-the total number of patents per region
we need to request multiple statistics.  You can do that by placing multiple
statistic names in parentheses;
proc tabulate data=patents; 
	class region;
	var patents;
	table region*patents*(N sum); 
run;

*The three PROC TABULATEs that you submitted above are all still one-dimensional
tables!  You can still request statistics for two dimensional tables as well;
proc tabulate data=patents; 
	class region edu25;
	var patents;
	table region, edu25*patents*(N sum); 
run;


*Note that this PROC TABULATE is equivalent to the following PROC MEANS;
proc means data=patents N sum;
class region edu25;
var patents;
run;


/****************************************************************************** 
Now it is your turn to practice:

Using PROC TABULATE, create a two-dimenional table with:
   -geographical division along the rows
   -whether or not the county's unemployment rate exceeded 10% along the columns
   -the following statistics under the columns:
		~number of counties
		~total number of patents
		~average number of patents per county 

Lastly, use PROC MEANS to obtain the same results.
******************************************************************************/
/* Part 1*/

%let path = /folders/myshortcuts/MY_FOLDER/;

/* part 2*/

libname flash "&path";

proc tabulate data= patents; 
	class division unemp10;
	var patents;
	table division, unemp10*patents*(N sum mean); 
run;

proc means data= patents N sum mean;
class division unemp10;
var patents;
run;

proc print data = flash.patents;
run;
*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;



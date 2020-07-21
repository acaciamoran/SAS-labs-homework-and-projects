/*****************************************************************************
* Name:        Acacia Moran
* Assignment:  Homework 1-2
*****************************************************************************/

*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;



/*****************************************************************************
Comments are pieces of a SAS script that are ignored when the script is run.
They can be very useful for documenting and explaining the purposes of each
portion of a SAS script.
*****************************************************************************/

* This is a comment;
/* This is a comment */

/*****************************************************************************
In general, any commented text will be ignored by SAS, even if it's in the 
middle of a line of code.

Notice that all SAS statements end with a semicolon as well.
*****************************************************************************/

*Create second program;
data secondprogram;

* In general we use an = to assign values to variables. Variables are
tools for storing values and data to work with in SAS.;

* This is a numeric variable.;
annualsalary = 60000;

* This is a character variable. We must use quotes to specify the value of
a character variable. If the value has a single quote in it, then double
quotes must be used on the outside. Otherwise it doesn't matter.;
annualdollars = "$60,000";
run;

*Print second program;
proc print data = secondprogram;
run;


/*****************************************************************************
In the space below write your own DATA and PROC PRINT steps to store and print
your annual salary as both a numeric and a character variable. Add variables
for (1) the number of years you've been at your current position as well as (2)
your job title. Are these numeric or character variables? Be sure to comment your
program.
*****************************************************************************/

*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;

* This creates my second program.;
data program2;

* This is a numeric variable I created.;
mysalary = 250000;

* This is a character variable I created.;
mymoneyindollars = "250000";

* This is a numeric variable I created.;
yearsinthisposition = 4;

* This is a character variable I created.;
jobtitle = "head of cat department";

run;

* This prints my second program.;
proc print data = program2;

run;






/*****************************************************************************
You may notice that certain words in SAS get colored in special ways. If your
data set or variable names are not colored black then those names are 
probably used by SAS in some other special way, so you should change them until
they are colored black.

Once your DATA and PROC PRINT steps look good, go ahead and run this SAS script.
Notice the structure of these data sets: rows correpsond to observations
and columns correspond to variables. In this program, we only created one 
observation.
*****************************************************************************/



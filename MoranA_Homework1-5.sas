/*****************************************************************************
* Name:        Acacia Moran
* Assignment:  Homework 1-5
*****************************************************************************/

*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;

/*****************************************************************************
So far we have been defining variables and performing computations on our own. 
Many commonly used computations as well as other more complicated tasks can be 
executed using SAS functions instead of programming them from scratch ourselves.

For example, we can add our bills using the SUM function.
*****************************************************************************/


data bills;
rent = 1600;
util = 150;
food = 550;

* To add them up we could simply use what we learned in the previous lesson.;
totalbills = rent + util + food;

* We could also use the SAS function sum().;
sumbills = sum(rent, util, food);


* Most SAS functions take some number of arguments (the values or variables
that go inside the parentheses). In this case the function is SUM() and the
arguments are rent, util, and food. The SUM() function could take more or less
arguments if we wanted.;

run;

proc print data = bills;

* This gives the output a title.  The title printed will remain the same
for all output, until you re-specify TITLE statement.;
title "Output 1";

run;

/*****************************************************************************
Go ahead and run this script to verify the two totals are the same
in Output 1.

Take a few minutes to peruse the list of SAS functions at the following url:
http://support.sas.com/documentation/cdl/en/lrdict/64316/HTML/default/viewer.htm#a000245860.htm

One thing that functions are extremely useful for is dates and times.
SAS date values represent the number of days between January 1, 1960 and the 
specified date.  Let's demonstrate this below.
*****************************************************************************/



data datefun;
* The today() function returns the current date as a SAS date value.;
now = today();

run;

proc print data = datefun;
title "Output 2";
run;

/*****************************************************************************
In the space below write DATA and PROC PRINT steps to do the following:
- Use the MDY function to store your birthday as a SAS date value.
- Compute your age in days using a SAS date function
- Compute your age in years using a SAS date function
- Compute the day of the week you were born on using a SAS date function (it
is sufficient to identify the integer that corresponds to the day of the week)
*****************************************************************************/

*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;

data birthday;

* This will store my birthday as a SAS date value;
mybirthday = mdy(10, 14,  1997);

* This gives me my age in days;
today = DATE();
days = today - mybirthday;

* This gives my age;
age = days / 365;

* This gives what day of the week I was born;
weekdayborn = weekday('14oct1997'd);

run;

* This prints my birthday in a table;
proc print data = birthday;

title "Output 2";

run;



/*****************************************************************************
Once your DATA and PROC PRINT steps look good, run the script and verify
the output yourself.
*****************************************************************************/






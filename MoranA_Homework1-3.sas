/*****************************************************************************
* Name:        Acacia Moran
* Assignment:  Homework 1-3
*****************************************************************************/

*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;



/*****************************************************************************
One of the first things you probably used a computer or device for was 
for mathematical computations.  SAS is capable of some complex and quite 
amazing things, but let's start simple: use it as a calculator.

We can use traditional notation in SAS to perform computations: +, -, *, /.
SAS adheres to the traditional order of operations (PEMDAS) as well: 
parentheses (), exponents **, multiplication *, division /, addition +,
 subtraction -.;
*****************************************************************************/


*Demonstration of SAS as a calculator;
data math;

*We can use variables to compute the values of other variables.  However, 
as long as we're doing math we can only use numeric variables.;

*Enter salary;
annualsalary = 60000;

*Enter rent;
monthlyrent = 1600;

*Calculate annual rent;
annualrent = monthlyrent * 12;

* Proportion of salary used for rent.;
rentprop = annualrent / annualsalary;

run;

*Print results;
proc print data = math;
run;


/*****************************************************************************
In the space below write your own DATA and PROC PRINT steps to store or 
compute the following: 
- your annual salary
- your montly and annual rent
- your monthly and annual utilities
- the proportion of your annual salary that goes to rent and utilities
*****************************************************************************/


*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;

*doing math;
data math;

*my salary;
myyearlysalary = 250000;

*my rent;
mymonthlyrent = 2000;

*my utilities;
mymonthlyutilities = 500;

*my utilities yearly;
myyearlyutilities = mymonthlyutilities * 12;

*yearly rent;
myyearlyrent = mymonthlyrent * 12;

* proportion of my salary and utitlities that goes to rent.;
proportionofrent = (myyearlyrent + myyearlyutilities) / myyearlysalary;

run;

*Print results;
proc print data = math;

run;





/*****************************************************************************
When your DATA and PROC PRINT steps look good, go ahead and run this SAS
script. In the first lesson you should have noted the presence of the Editor,
Log, and Output windows. So far we've only looked at the Editor and Output 
windows. The Log window is useful for checking to make sure SAS did not
encounter any errors in running the script. If your output looks different 
than you expect, the Log is a good place to look first.;
*****************************************************************************/



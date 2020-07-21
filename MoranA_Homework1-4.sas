/*****************************************************************************
* Name:        Acacia Moran
* Assignment:  Homework 1-4
*****************************************************************************/

*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;



/*****************************************************************************
In this data step we demonstrate removing variables and the logic of 
IF/THEN/ELSE statements.

In the previous lesson you were asked to store different bill amounts
and then compute the proportion of your salary that they make up. In doing
so quite a few variables needed to be created, while we may have only
really been interested in the proportions. We can remove unwanted variables from the 
data set using DROP and KEEP.

It's also possible to define variables or perform other actions based
on certain criteria or conditions using conditional logic IF/THEN/ELSE.;
*****************************************************************************/

data moremath;

annualsalary = 60000;
monthlyrent = 1600;
annualrent = monthlyrent * 12;

* Proportion of salary used for rent.;
rentprop = annualrent / annualsalary;

* Suppose rent should only reasonably make up 30% of your salary.
We can check this condition in the following way. If our proportion
is less than or equal to .3 then your proportion spent is reasonable, 
otherwise it is not.;
if rentprop <= .3 then reasonable = "YES";
else reasonable = "NO";

* In general we can combine multiple IF/THEN/ELSE statements.;
if annualsalary <= 40000 then paylevel = "low";
else if annualsalary <= 80000 then paylevel = "medium";
else paylevel = "high";

* Removes the monthlyrent and annualrent variables.;
drop monthlyrent annualrent; 

* Another way to achieve the same thing.;
*keep annualsalary rentprop reasonable paylevel;

run;

proc print data = moremath;
run;

/*****************************************************************************
In the space below write your own single DATA and single PROC PRINT steps to
store or compute the following: 
- your annual salary
- your monthly and annual rent
- your monthly and annual utilities
- the proportion of your annual salary that goes to rent and utilities

Suppose it is reasonable for your rent to make up no more than 30% of your
salary and for your utilities to make no more than 1% of your salary. Now,
- create two different variables, one for rent and one for utilities, 
to check if your amounts are reasonable
- keep only the annual salary, proportions and "reasonable" variables in the 
final data set
*****************************************************************************/


*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;

*doing math;
data mathcoding;

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

* Proportion of salary used for rent.;
propofrentsalary = myyearlyrent / myyearlysalary;

* Proportion of salary used for utilities.;
propofrentutilities = myyearlyutilities / myyearlysalary;

* checking rent cost.;
if propofrentsalary <= .3 then reasonablesalary = "YES";
else reasonablesalary = "NO";

* checking utilities cost.;
if propofrentutilities <= .01 then reasonableutilities = "YES";
else reasonableutilities = "NO";

* this takes out certain unwanted variables;
drop myyearlyrent myyearlyutilities mymonthlyrent mymonthlyutilities proportionofrent;

* Print results;
run;

proc print data = mathcoding;

run;











/*****************************************************************************
Once your DATA and PROC PRINT steps look good, run the script and verify the output.
*****************************************************************************/




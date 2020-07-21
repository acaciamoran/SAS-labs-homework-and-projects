/*****************************************************************************
* Name:        Acacia Moran
* Assignment:  Homework 3-9
*****************************************************************************/

*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;

/*****************************************************************************
When you write a DATA step you create a data set in SAS. The variables
we've been creating and printing have been part of the data set we 
created with our DATA step. Once the run statement at the end of the
DATA step is executed SAS completes that DATA step and stores that data
set. The variables and data in that data set are only accessible by
referencing that data set. This is why when we run a PROC PRINT we must
tell SAS which data set we want to print.

You might be wondering if there's a way to create variables that can be 
referenced by a DATA or PROC step at any time, that aren't necessarily
part of a particular data set. One way to achieve this is using the macro
facility within SAS by creating what's called a macro variable. Macro 
variables have many uses, including allowing you to dynamically modify
a SAS program. Let's take a look at what this means.

Consider the calculation of savings account balance in the last few lessons.
Let's create a program that will compute the savings account balance
- With some user-defined initial amount, principal
- With some user-defined interest rate, intrate
- After some number of years, nyrs
*****************************************************************************/

*Define macro variables using %LET;
%let principal = 10000;
%let intrate = .04;
%let nyrs = 25;

/*****************************************************************************
The value of a macro variable is simply a string of characters.  The characters
can include any letters, numbers, syymbols, and blanks between characters.  
Notice again that these macro variables are not defined within a DATA step.
*****************************************************************************/

data savings;
balance = &principal; * reference a macro variable by starting with &;

do i = 1 to &nyrs;
	balance = balance + balance*&intrate;
	*output; *if we want to see balance after each year;
end;

drop i;
run;

proc print data = savings;
title "Interest rate of &intrate, over &nyrs years";
run;

/*****************************************************************************
Notice also that our macro variables do not show up in our printed
data set. We can insert the values of macro variables into text like in
the title statement above. Examine the TITLE statement in the PROC PRINT -
SAS will only substitute values of macro variables within double quotes 
(not single quotes) so be careful.

Now all we have to do is change the values of the macro variables at the 
top of the program if we want to calculate the savings under different 
conditions!

In the space below write your own DATA and PROC PRINT steps to compute the
balance of your savings account under the following conditions:
- Initial balance is $0
- Your monthly contribution (starting today) should be a macro variable 
starting at $25
- Your montly interest rate should be a macro variable starting at 3%
- Create a macro variable for the age (in whole number of years) you'd 
like to know the balance of the account at
- Your program should compute the balance of the savings account at the 
specified age
*****************************************************************************/

*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;
%let monthly = 25;
%let interest = .03;
%let age = 45;

data balance;

fund = 0;

* this stores my birthday;

acacia = mdy(10, 14, 1997);

*This gets the year for the set age;

yeardate = 1997 + &age;

* this stores my birthday when I am at age;

acaciadone = mdy(10, 14, yeardate);


* this gets the number of months till set age;

 monthstillage=INTCK('MONTH',acacia,acaciadone,'C');
 
* this gets todays date;

today = today();

* this gets my age;

myage = yrdif( acacia, today, 'AGE');

* this does a loop to add money to the fund;

do i = 1 to monthstillage;

* this adds 25$ each month;

fund = fund + &monthly;
	
* this adds 3% of the salary to my fund;

fund = fund + fund*(&interest);

*this ends the loop;

end;

*this drops everything but fund;

keep fund;
	

run;

proc print data = balance;

run;





/*****************************************************************************
Once everything looks good, run your script and verify the results. A 
good/easy way to verify things is to plug in simple values. For example,
try plugging in your age one year from now, monthly contribution of $10,
and interest rate of 10%.
*****************************************************************************/
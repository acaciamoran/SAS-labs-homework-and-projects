/*****************************************************************************
* Name:        Acacia Moran
* Assignment:  Homework 3-10
*****************************************************************************/

*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;

/*****************************************************************************
In the last exercise we learned about macro variables and a little about how 
they can be used to dynamically modify our programs. The SAS macro facility 
extends beyond just variables, but to creating modular code as well. Suppose 
we wanted to run the savings account balance code from the previous lesson for 
many different values of principal, intrate, and nyrs. Your first thought might
be to copy the DATA step we wrote many times, with changes to the macro 
variables preceeding each one. However, this is tedious and can quickly 
clutter our script with lots of code.

A SAS macro addresses the issue of writing similar code repeatedly. Let's define 
a SAS macro that computes the savings account balance.  The format for a SAS 
macro is:

%macro macro_name;
	<ENTER ANY NUMBER OF PROC AND DATA STEPS>
%mend macro_name;

Highlight and submit the savings macro.  Note that nothing will happen becacuse
you are simply defining the macro here.  The macro will execute when you
call it with 
	%calc_savings;
below.
*****************************************************************************/

%macro calc_savings; *initialize and name the macro;
	data savings;
	balance = &principal;

	do i = 1 to &nyrs;
		balance = balance + balance*&intrate;
		*output;
	end;

	drop i;
	run;

	proc print data = savings;
	title "Principal of &principal, Interest rate of &intrate, over &nyrs years";
	run;
%mend calc_savings; *end the macro;

/*****************************************************************************
Notice the code from the previous lesson has simply been copied and pasted 
inside this macro statement.  Let's compute the savings account balance for 
a few different scenarios.
*****************************************************************************/

*define macro variables;
%let principal = 10000;
%let intrate = .04;
%let nyrs = 25;
*run the macro;
%calc_savings;


*define macro variables;
%let principal = 2500;
%let intrate = .07;
%let nyrs = 20;
*run the macro;
%calc_savings;

/*****************************************************************************
Each time we write %savings imagine SAS substituting all of the code
within the savings macro we wrote. So, it's like we've written a program
that writes a program. Now we can re-run that savings account computation
in only 4 lines of code instead of actually copying the DATA and PROC PRINT
steps above.

In the space below convert your savings account balance code from the 
previous lesson to a macro. Then run the macro under different values
for your macro variables.
*****************************************************************************/

*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;

%macro account; 

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

*end the macro;

%mend account;

%let monthly = 100;
%let interest = .03;
%let age = 45;
%account;


%let monthly = 25;
%let interest = .035;
%let age = 45;
%account;

%let monthly = 25;
%let interest = .03;
%let age = 50;
%account;








/*****************************************************************************
Once your code looks good, run the script and verify the output.
*****************************************************************************/
/*****************************************************************************
* Name:        Acacia Moran
* Assignment:  Homework 3-11
*****************************************************************************/

*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;

/*****************************************************************************
Macros are helpful for running pieces of code that would otherwise
have been repeated many times. We can shorten and organize things even
more by adding parameters to macros. Similar to how we've seen SAS functions
take arguments, we can pass values to a macro for it to use in its
execution.

Recall the savings account balance in the last two lessons. We needed
the following.
*****************************************************************************/

%let principal = 10000;
%let intrate = .04;
%let nyrs = 25;

%macro calc_savings;
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
%mend calc_savings;

%calc_savings;

/*****************************************************************************
To make principal, intrate, and nyrs parameters in the calc_savings macro 
we can do the following:
*****************************************************************************/

%macro calc_savings2(principal=,intrate=,nyrs=);
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
%mend calc_savings2;

/*****************************************************************************
Highlight and submit the macro above.  

We still reference the variables within the macro in the same way as before, 
but now run the macro by explicitly stating its parameters, instead of 
defining them with %LET statements.
*****************************************************************************/

%calc_savings2(principal = 10000, intrate = .04, nyrs = 25);


/*****************************************************************************
In the space below convert your macro from the previous lesson to a macro
that takes parameters. In other words, you should not need %LET statements
to execute your macro.  Run your macro for at least 3 different sets of
values for your parameters.
*****************************************************************************/


*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;


%macro account(monthly=, interest=, age=); 

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

fund = fund + (&monthly);
	
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

%account(monthly=100, interest=.03, age=45); 

%account(monthly=25, interest=.035, age=45); 

%account(monthly=25, interest=.03, age=50); 


/*****************************************************************************
Once your code looks good, run the script and verify the output.
*****************************************************************************/

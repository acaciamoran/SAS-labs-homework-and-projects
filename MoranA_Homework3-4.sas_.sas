/*****************************************************************************
* Name:        Acacia Moran
* Assignment:  Homework 3-12
*****************************************************************************/

*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;

/****************************************************************************** 
Up until now, we've used conditional logic exclusively within the
DATA step to perform a number of different possible actions based
on some condition(s). Now that we've introduced the SAS macro facility,
it may very well be the case that we want to conditionally assign the values
of macro variables. We may even want to conditionally run whole DATA or 
PROC steps.

To accomplish this the SAS macro facility has its own conditional logic.
Suppose we were keeping track of savings account balance, but want to 
check if the values make sense first.
*****************************************************************************/

%macro calc_savings(principal=, intrate=, nyrs=, goal=);
	
	%if &principal < &goal %then %do; /*principal must be below goal amount*/
		data savings;
		balance = &principal;
	
		do i = 1 to &nyrs;
			balance = balance + balance*&intrate;
		end;
	
		drop i;
		run;
	
		
		proc print data = savings;
		title "Principal of &principal, Interest rate of &intrate, over &nyrs years";
		run;
	%end;

	/*This prints a statement to the log (not the output)*/
	%else  %put "Principal (&principal) exceeds goal (&goal)";
	
%mend calc_savings;

*This should produce output;
%calc_savings(principal = 10000, intrate = .04, nyrs = 25, goal = 15000);

*This should produce nothing in the output, but prints a statement to the log;
%calc_savings(principal = 10000, intrate = .04, nyrs = 25, goal = 9000);

/*****************************************************************************
IMPORTANT NOTE:  Using coments with star semicolon in SAS macros with 
conditional logic can cause an error.  To be safe, use the slash star star slash 
notation for comments instead.

In the space below revise your macro(s) from the previous lessons to include
error checking like above. That is, use macro conditional logic to make sure
the values passed to your macros make sense.
*****************************************************************************/

*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;

* this is the old code;
%macro account(monthly=, interest=, age=);

* this checks if the interest rate is less than 100%;

	%if &interest < 1 %then %do; 

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
		
		* this makes a title;
		
		title "My Fund";
		
		run;
	%end;

	
	%else  %put "Interest rate (&interest) is too high";

*end the macro;

%mend account;

* these run some numbers into the code;

%account(monthly=25, interest=1.2, age=45); 

%account(monthly=25, interest=.03, age=45); 




/*****************************************************************************
Once your code looks good, run it for a few different sets of values and
verify the output.
*****************************************************************************/
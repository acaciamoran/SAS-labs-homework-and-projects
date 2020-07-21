/*****************************************************************************
* Name:        Acacia Moran
* Assignment:  Homework 2-8
*****************************************************************************/

*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;

/*****************************************************************************
In the last lesson we were introduced to looping, more specifically
DO loops. To construct a DO loop we needed a list of values we wanted
to iterate over in some way, with specified starting and ending points.
It's quite possible, however, that we don't know how long the loop should
be. 

Suppose we want to know how many years until I've saved $500,000 based 
on my income, savings, and an assumed pay increase each year. Suppose my
annual income is $60,000, my salary increases by 4% each year, and 
I'm able to put 10% of my income into savings each year. How many years 
will it take for my savings to reach $500,000. The 'until' in this 
question is a hint at the solution.

We'll use a DO UNTIL loop, which executes some set of code over and over
UNTIL some condition is met.

Since we don't know how long the loop is, we specify a condition instead of 
starting and ending values. In this case we want to stop the loop once my
savings reach or exceed $500,000. Be sure to base your condition on something
that's changing in the loop. It's possible to construct infinite loops, which
we want to avoid. So that you're prepared, locate the icon at the top of the
SAS session window that looks like a ! with a circle around it. Should SAS
continue to run longer than you like, hit this button to stop SAS and
investigate.

Run the script to below to observe the output. Try commenting the output
statement and re-running the script.
*****************************************************************************/

data retire;
	savings = 0;
	income = 60000;
	year = 0;

	do until (savings >= 500000);
		*provide salary increase AFTER first year of employment;
		if year > 0 then income = income + income*.04;
		savings = savings + income*.10;
		year = year + 1;
		output;
	end;

run;

proc print data = retire;
	title "Do Until";
run;

/*****************************************************************************
There is another type of DO loop called a DO WHILE loop, which works
very similarly to a DO UNTIL loop. In both we need to specify a condition
which tells SAS when to stop running. In a DO UNTIL loop the condition is
checked at the bottom of the loop, which means it's always executed at least
once. In a DO WHILE loop the condition is checked at the top of the loop, which
means it's possible for it not to be executed at all.

Here's the same retirement program with a DO WHILE loop, which executes as
long as the condition is true.  Run this script and verify that the output is 
the same for the two methods.
*****************************************************************************/

data retire2;
	savings = 0;
	income = 60000;
	year = 0;

	do while (savings < 500000);
		*provide salary increase AFTER first year of employment;
		if year > 0 then income = income + income*.04;
		savings = savings + income*.10;
		year = year + 1;
		output;
	end;

run;

proc print data = retire2;
	title "Do While";
run;


/*****************************************************************************
In the space below write your own DATA and PROC PRINT steps to do the
following:
- Store your ideal or current annual salary
- Assume you're at the same job between now to retirement. Determine how many years
away retirement is from TODAY.
- Assume you'll get a 10% raise at years 10, 20, 30, etc. and a 3% raise each
other year.
- You put away 10% of your salary each year into this retirement account

--- How much will this account have in it when you retire?
--- How many years would it take for your savings account to reach 15 times 
your current salary?
*****************************************************************************/


*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;

* this makes the data step;

data salary;

* this initializes my salary;

salary = 100000;

* this stores my birthday;

acacia = mdy(10, 14, 1997);

* this gets todays date;

today = today();

* this gets my age;

myage = yrdif( acacia, today, 'AGE');

*this gets my retirement date;

retirement = mdy(10, 14, 2062);

* this gets years till retirement;

retireyears = yrdif(today, retirement, 'AGE');

* this initializes the amount in the retirementfund;

retirementfund = 0;

* this initializes years working;

year = 0;

* this initializes years for total working;

yearend = 0;

* this creates the initial loop for retirement;

	do while (yearend <= retireyears);
	
	* this adds 10% of the salary to the retirement fund;

		retirementfund = retirementfund + (salary * .10);
	
	* this adds 10% if the year is divisible by 10;

		if year = 10 then do;
		
			salary = salary + (salary * .1);
		
			year = 0;
		
		end;
		
	* this adds 3% if the year is not divisible by 10;

		else do;
		
			salary = salary + (salary * .03);
	
			* this makes it the next year;

			year = year + 1;
		
		end;
		
		yearend = yearend + 1;
		
		output;
	

	end;
	
	* years till fund is 15 times my old salary;

	* this initilizes retiremennt fund;
	
	salary2 = 100000;

	* this initilizes retiremennt fund;
	
	fund = 0;
	
	* this initilizes the 15 times the salary;
	
	salary15 = 1500000;
	
	* this initilizes the years;

	yeartotal = 0;
	
	* this initilizes the years for final;

	yearfinal = 0;
	
	
	* this does the loop for the years till 15 times;

	Do until(fund >= salary15);
	
	* this adds 10% of the salary to the retirement fund;

		fund = fund + (salary2 * .10);
	
	
	* this adds 10% if the year is divisible by 10;

		if yeartotal = 10 then do;
		
			salary2 = salary2 + (salary2 * .1);
			
			yeartotal = 0;
		end;
		
	* this adds 3% if the year is not divisible by 10;

		else do;
			salary2 = salary2 + (salary2 * .03);
		
			* this makes it the next year;

			yeartotal = yeartotal + 1;
		
		end;
	yearfinal = yearfinal + 1;
		
		output;
	

	end;
	
	

run;

proc print data = salary;

run;





/*****************************************************************************
Once your DATA and PROC PRINT steps look good, run the script and
verify the output.
*****************************************************************************/


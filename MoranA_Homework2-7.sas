/*****************************************************************************
* Name:        Acacia Moran
* Assignment:  Homework 2-7
*****************************************************************************/

*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;

/*****************************************************************************
In the last lesson we learned a bit about how to make our programs cleaner 
and more efficient with arrays. Arrays often go hand-in-hand with DO loops 
(in many other languages known as FOR loops).;

A DO loop is concise way to do something many times or in an iterative way. 
They are not always the most efficient, but still often useful.

Suppose you decided to start saving some money to buy a car and are able
to put $300 each month towards this endeavor. How much would you have for a
down payment after 2.5 years?  We could use math in the traditional way 
to solve this problem;
*****************************************************************************/

data car1;

	* the number of months in 2.5 years (30);
	months = 2.5 * 12; 

	* total savings after 2.5 years;
	savings = months * 300; 

run;

proc print data=car1;
	title "Car1";
run;


/*****************************************************************************
Another way to do this problem is to use an array and a DO loop.
*****************************************************************************/

data car2;

	* the number of months in 2.5 years (30);
	months = 2.5 * 12; 

	* Create an array to store/track our monthly savings;
	array monthsavings (30);

	* Initialize the value of total_savings to zero.;
	total_savings = 0;

	do i = 1 to months;

		*Each monthly savings amount;
		monthsavings(i) = 300;

		*Total savings accrued;
		total_savings = total_savings + monthsavings(i);
		
	end;

run;

proc print data=car2;
	title "Car2";
run;


/*****************************************************************************
This DO loop creates a new variable, i, and starts it at the value 1. It
performs everything inside the DO loop and then increases the value of i to 2.
It proceeds in this way until the value of i reaches the value of the months 
variable. Everything inside the loop is performed again and the value of i is
increased to the value months+1. When SAS returns to the top of the loop it
checks if the value of i is greater than the last value we specified, in this 
case months. Since i is now greater than months, SAS stops and the DO loop is
completely finished. This explains why the value of i in the resulting data 
set is 31 and not 30.

Notice that the DO loop must end with that 'end' statement.
*****************************************************************************/


/*****************************************************************************
In general we can iterate in any way we want to. SAS assumes we want
to start at some value and increment it by 1 each time but we can do any
of the following:

do i=20 to 1 by -1

do j=2 to 12 by 2

do k=2,3,5,8

do l='A','B','C'

do m=var1,var2,var3

where var1, var2, var3 are variables themselves. Here we've kept the iterating
variable short (i,j,k,l,m), but you can make it whatever you want. In the 
example above our data set got cluttered with our array variables, but 
hopefully it's clear how arrays and DO loops can work together. DO loops are a
natural way to do things with the elements of an array one cell at a time, by
iterating over the elements of the array.
*****************************************************************************/


/*****************************************************************************
To clean up or organize our data set a bit we can use OUTPUT. Specifying
'output' in the data step tells SAS to save the current values of all 
variables as a new observation in the data set. With this we can track our
entire savings process in a different way than using the array, though
arrays are still very useful.

Run the script below and observe the differences in the output.
*****************************************************************************/

data car3;

	* Traditional math;
	months = 2.5 * 12; * the number of months in 2.5 years (30);
	savings = months * 300; * total savings after 2.5 years;

	* Initialize the value of total_savings to zero.;
	total_savings = 0;

	do i = 1 to months;

		*Total savings accrued;
		total_savings = total_savings + 300;
		output;
		
	end;

	*drop i;
run;

proc print data = car3;
title "Car 3";
run;

/*****************************************************************************
In the space below write your own DATA and PROC PRINT steps to do the following:
- Compute how many months there are between TODAY and when you turn 65 (a 
  common retirement age). Feel free to round the value.
- If you put $100 per month into a retirement account that already
  has $2000 in it, compute how much the account will have when you turn 65.
- Suppose your retirement account currently has $2000 and you can add  
  $100 to that each month, but this money is being invested and earns 7.5%
  interest each year (0.625% monthly), which is compounded monthly. Compute 
  how much the account will have when you turn 65.
- Track each of these savings plans with separate observations using the
  OUTPUT statement as in car3 above.
*****************************************************************************/

*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;

* data step;

data retire;

* this stores my age;

acacia = mdy( 10, 14, 1997);

* this stores todays date;

today = today();

* this stores my age at 65;

acacia65 = mdy( 10, 14, 2062);

* this gets the number of months till 65;

 monthstill65=INTCK('MONTH',today,acacia65,'C');
 
 * Initialize the value of savings to 2000.;
	savings = 2000;

	do i = 1 to monthstill65;
		
	*track savings;

		savings = savings + 100 + .00625*(savings);
		
	* prints out the savings;

		output;
		
	* this ends the loop;
		
	end;
	
* this prints the data to the screen;
 
proc print data = retire;

* this runs the data;

run;





/*****************************************************************************
Once your DATA and PROC PRINT steps look good, run the script again
and verify the output.
*****************************************************************************/




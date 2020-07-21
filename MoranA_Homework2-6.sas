/*****************************************************************************
* Name:        Acacia Moran
* Assignment:  Homework 2-6
*****************************************************************************/

*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;

/*****************************************************************************
So far we've had to create a new variable for each new value
we wanted to store or compute. It's often the case that we know
we're going to work with a certain number (greater than one) of values.

Suppose you wanted to do some brief analysis of bill amounts of your
coworkers. In your division, there are 4 other people besides yourself:
Bob, Ted, Amy, Sue.

We can use arrays to simplify our data set and code. Up until now this is how we 
might have done things:
*****************************************************************************/

data before;
	bobrent = 1000;
	tedrent = 1200;
	amyrent = 1100;
	suerent = 2000;

	avg = mean(bobrent, tedrent, amyrent, suerent); * average rent;
	highest = max(bobrent, tedrent, amyrent, suerent); * highest rent;

run;

proc print data = before;
	title "Before";
run;

/*****************************************************************************
Instead, let's define an array for these rent figures. The general syntax for 
an array is:

array <name> (n) <var-list>

where <name> is the name of the array, n is the number of variables
or length of the array, and <var-list> are the individual variable names for
each part of the array. The <var-list> is not necessary for defining an array
but can help in keeping track of things.
*****************************************************************************/

data after;
	array rent (4) bob ted amy sue;

	*Method 1 to assign values - reference array position:;
	rent(1) = 1000; 
	rent(2) = 1200;
	rent(3) = 1100;
	rent(4) = 2000;

	/*Method 2 to assign value - by variable name:
	bob = 1000;
	ted = 1200;
	amy = 1100;
	sue = 2000;
	*/

	avg = mean(of rent(*)); * average rent;
	highest = max(of rent(*)); * highest rent;
run;

proc print data = after;
	title "After";
run;

/*****************************************************************************
After running the script and observing the output from the above DATA
steps, hopefully it's clear the extra efficiency and ease of using
arrays when possible.

The above DATA steps used numeric arrays, but what if we wanted to store 
character values?
*****************************************************************************/

data after2;
	* The dollar sign indicates it will be a character array.;
	array names (4) $; 

	* When the variables can have the same name but end in an increasing number,
	SAS lets us abbreviate the creation of these variables in the following
	way.;
	array rent (4) ; 

	names(1) = 'bob';
	names(2) = 'ted';
	names(3) = 'amy';
	names(4) = 'sue';

	rent(1) = 1000;
	rent(2) = 1200;
	rent(3) = 1100;
	rent(4) = 2000;

run;

proc print data = after2;
	title "After 2";
run;

/*****************************************************************************
Run the script and notice the output. Observe that even though we didn't
create variable names for the names and rent arrays, SAS created names1, names2,
names3 and names4 for us.;

In the space below write your own DATA and PROC PRINT steps to do the
following with arrays:
- Store the names of 3 friends or coworkers
- Store the method of transportation they use to get to school or work
- Store their ages
- Store the number of siblings they each have
- Compute the average age
- Use SAS functions to compute the age of the youngest
- Use SAS to figure out the largest number of siblings
*****************************************************************************/


*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;

* this makes the data;

data people;

	* This makes a array.;
	array friends (3) $;
	
	* this assigns the variables to the names;

	friends(1) = "joe";
	
	friends(2) = "maggie";
	
	friends(3) = "aj";
	
	* This makes a array.;
	array transportation (3) $;
	
	* this assigns the variables to the transportation;

	transportation(1) = "walk";
	
	transportation(2) = "walk";
	
	transportation(3) = "bike";
	
	* This makes a array.;
	array age (3);
	
	* this sets their ages;

	age(1) = 20;
	
	age(2) = 19;
	
	age(3) = 13;
	
	* This makes a array.;
	array siblings (3);
	
	* this sets their ages;

	siblings(1) = 1;
	
	siblings(2) = 1;
	
	siblings(3) = 4;
	
	* average age;
	
	avg = mean(of age(*));
	
	* youngest age;
	
	youngest = min(of age(*));
	
	* largest number of siblings;

	mostsiblings = max(of siblings(*));
	
	run;
	
proc print data = people;
title "My Friends";
run;
	
	







/*****************************************************************************
When everything looks good run the script and check that the output matches
the data you entered.
*****************************************************************************/


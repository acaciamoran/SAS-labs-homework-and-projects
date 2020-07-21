/*****************************************************************************
* Name:        Acacia Moran
* Assignment:  Homework 12-21
*****************************************************************************/

*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;

/****************************************************************************** 
In this lesson we'll continue our foray into reading raw data into SAS. We've 
talked about LIST input, COLUMN input, and FORMATTED input. Here we'll talk about 
the use of '@' and '@@' to hold lines of data.

Suppose you were interested in specific records from your raw data. The
trailing at symbol, '@', tells SAS to "wait for more information." For example, 
you can tell SAS to test a variable with an IF-THEN statement if you like.
SAS will hold the line until it reaches the end of the DATA step or an input
statement without an @ symbol.

Consider the following small data set of students. Suppose we only want
to read in the data for students with GPAs higher than 3.5 as possible
Honor Roll students. We can tell SAS to read in the first two variables, 
then test the value of GPA. If it's less than 3.5 then delete that 
observation. Otherwise continue to read in that observation.
*****************************************************************************/

data friends;
input name $ gpa @;

if gpa < 3.5 then delete;
input age;

datalines;
Fred 2.5 19 
Alex 3.1 20 
Frank 2.7 20
Sue 3.58 18 
Christy 2.9 21 
Jason 3.75 19
;

proc print data = friends;
title "Friends 1";
run;

/****************************************************************************** 
SAS does not assume that a line of data can consist of more than one
observation, but this may be the case like in the data set below (which
is just a revised version of our data set above). The double trailing
at signs, '@@', is another line-hold specifier and tells SAS to "hold that
line of data." SAS will continue to read data until it runs out or 
reaches a new input statement without a double trailing at (@@).

Without the @@ in the following INPUT statement, the data set would not be
read in correctly. Try removing the @@ to see what happens.
*****************************************************************************/

data friends;
input name $ gpa age @@;

datalines;
Fred 2.5 19 Alex 3.1 20 Frank 2.7 20
Sue 3.58 18 Christy 2.9 21 Jason 3.75 19
;

proc print data = friends;
title "Friends 2";
run;

/****************************************************************************** 
The difference between @ and @@ is how long they hold the line. The @ holds
data for subsequent input statements and releases the line when SAS returns to 
the top of the DATA step.

The @@ holds data for subsequent input statements and even when SAS begins to
read the next observation.
*****************************************************************************/

/****************************************************************************** 
In the space below complete the INPUT statement so that the data on airlines
baggage fees is read in correctly. The variables are rank, airline, and 
revenue. You may need to use some techniques from Lecture 11 regarding list, 
column, and formatted input. Once you are done, print the data to make sure it
executed correctly.
*****************************************************************************/

*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;


data baggage;
input rank airline : $18. revenue : dollar.@@;

datalines;
1  Delta  863,608  2  American  593,465
4  Continental  353,416 5  United  276,817  
;
run;

proc print data = baggage;

run;





/*****************************************************************************
* Name:        YOUR NAME HERE
* Assignment:  Homework 4-13
*****************************************************************************/

*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;

/****************************************************************************** 
Up until this point we've defined and computed variables within the DATA 
step to create, manipulate, and work with our own user-generated data. SAS
can certainly handle whole data sets but does so in a special way.

There are MANY ways of getting data sets into SAS. The first way we'll
discuss is using what's called Instream Data. This method involves
the INPUT and the DATALINES statements. This is perhaps one of the simplest
methods as it involves manually entering the data into our SAS script.
*****************************************************************************/

data retire;
input firstname $ age principal rate years;

datalines;
Ted 64 5000 .06 35
Bill 66 2500 .07 39
Susan 62 10000 .065 30
Marie 65 7500 .07 30
;
run;

proc print data = retire;
title "Retirement Info";
run;

/****************************************************************************** 
The input statement above tells SAS the variables it's going to read data
in for, in the order that they come, and the types of variables they are.
The $ following firstname tells SAS that the firstname variable is a character
variable. Without this SAS would treat it as a numeric variable, like it does
for age, principal, rate, and years.

The datalines statement begins our data set. Notice that each value is
separated only by a space and that each observation is on its own line, and a
single semicolon is placed after ALL of the observations have been entered. This 
format is important so that SAS reads this data correctly. Color coding should help 
you do this correctly, but remember to look to the log if your output seems wrong.

If you run this script you'll see we have one observation per line, with
values for all of the variables specified in the input statement. Data sets in
SAS are arranged as tables, with the rows corresponding to observations and
the columns corresponding to variables.

What is not apparent from the DATA step above is how SAS processes this data
set. SAS uses the input statement to read this data set one line (observation)
at a time. There is an implicit loop within the DATA step. 

Up until now we've created our own data and run everything within our DATA
steps only once. Above, SAS uses the input statement to read the first 
observation and then output it to the retire data set. It then returns to the
top of the DATA step and reads the second observation and outputs it to the
retire data set in the same way...and so on.

The important thing to note here is that these four observations never coexist
within the DATA step...only one at a time.

Everything that we've learned so far can still be used, but in many situations
only with individual observations as we read in a data set.

Suppose we wanted to identify individuals in this data set as seniors or not.
*****************************************************************************/
data senior;
input firstname $ age principal rate years;

if age >= 65 then senior = "Yes";
else senior = "No";

datalines;
Ted 64 5000 .06 35
Bill 66 2500 .07 39
Susan 62 10000 .065 30
Marie 65 7500 .07 30
;

run;

proc print data = senior;
title "Retirement Info 2";
run;

/****************************************************************************** 
Notice that our conditional assignment of the senior variable seemed
to come before the data, but SAS knows to run everything between the
input and datalines statements for each observation in the data set.

In the space below write your own DATA and PROC PRINT steps to do the
following:
- Import data on yourself and three peope you know 
  (name, gender, ideal salary,and birth year)
- Create a variable called generation takes a values of 
  *baby boomer if they are born between 1946-1964
  *generation x if they are born 1965-1980
  *millenial if they are born 1981-2000
  *other if it is something else
*****************************************************************************/

*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;
/* this creates the data set*/

data friends;

/* this take in the variables for the data to come*/

input name $ gender $ idealsalary birthyear;

/* this checks if they are a baby boomer*/

if 1946 <= birthyear <= 1964 then generation = "baby boomer";

/* this checks if they are a generation x baby*/

else if 1965 <= birthyear <= 1980 then generation = "generationx";

/* this checks if they are a millenial*/

else if 1981 <= birthyear <= 2000 then generation = "millenial";

/* this assigns new to them if they arent any of those above*/

else generation = "new";

/* this input the data*/

datalines;
Acacia female 100000 1997
Aj male 450000 1973
Aaron male 40000 1950
Niki female 750000 2009
;

/* this runs the code*/
run;

/* this prints the code to the screen*/

proc print data = friends;

/* this gives the data a title*/

title "My Friends";

/* this runs the proc print*/

run;





/****************************************************************************** 
Once your code looks good, run the script and verify the output. 
*****************************************************************************/
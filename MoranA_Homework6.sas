/*****************************************************************************
* Name:        Acacia Moran
* Assignment:  Homework 6-15
*****************************************************************************/

*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;

/****************************************************************************** 
Though quite a bit of data manipulation and management happens within
the DATA step, SAS excels at printing, summarizing and reporting of data
sets as well. Up until this point we've only encountered and used one
SAS procedure: PROC PRINT.

Just like SAS functions, there is a great big world of SAS procedures
available to us for performing any number of things in SAS. 

A few basic SAS procedures include:
- PROC PRINT
- PROC FORMAT
- PROC MEANS
- PROC FREQ
- PROC UNIVARIATE

and a more extensive list can be found at

http://support.sas.com/documentation/cdl/en/allprodsproc/63875/HTML/default/viewer.htm#a003135046.htm

Let's illustrate thease procedures using the SAS data set bigcomp, which 
has information on big companies.  Make sure you have the SAS data set bigcomp,
and set a library reference to where it is stored on your computer.
*****************************************************************************/

libname sasdata "C:/Users/hglanz/Google Drive/STAT330/Data/";


*There are a number of options for PROC PRINT that help customize the output;
proc print data = sasdata.bigcomp;
title "Title for Big Companies";
title2 "Subtitle for Big Companies";
title3 "SubSubtitle for Big Companies";

* This will limit the output to these variables, but not change the data set
itself;
var Company Profits MarketValue; 
run;

/****************************************************************************** 
PROC MEANS can compute a number of descriptive statistics for us. By
default this computes statistics for all numeric variables in the data set. We
can specify which variables we want, though, with a var statement like above in
the PROC PRINT.
*****************************************************************************/

* Here I've asked specifically for just the mean and standard deviation.;
proc means data = sasdata.bigcomp mean stddev;
title "Descriptive Statistics";
var Assets Profits Sales;
run;

/****************************************************************************** 
PROC FREQ is another useful procedure for summarizing a data set. By default
this will give us frequencies and percentages for all variables, EVEN NUMERIC
ONES. 

Using the tables statement we can look at any kind of one or  two-way table we 
want.
*****************************************************************************/

proc freq data = sasdata.bigcomp;
title "PROC FREQ";
tables Country;
run;

/****************************************************************************** 
PROC UNIVARIATE is another classic procedure for producing statistics
and some graphics for a data set. The code below will produce a default 
summary for all numeric variables in the data set.
*****************************************************************************/

proc univariate data = sasdata.bigcomp;
title "PROC UNIVARIATE";
run;

/****************************************************************************** 
In the space below write your PROC steps to do the following:
- Use PROC MEANS and PROC UNIVARIATE to compare 5 number summaries,
means, and standard deviations for all numeric variables in the bigcomp
data set. Verify that the same values are produced.
- Compute the means and standard deviations of Profits and Assets, for
each country. (Hint: look up the CLASS statement for PROC MEANS.)
- Explore what you can do with these PROCs. They are all both simple and 
quite nice.  
*****************************************************************************/

*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;

/* this gets the library we are using*/

libname HW6 "/folders/myshortcuts/sf_MY_FOLDER/";

/* this has us use the univariate data*/

proc univariate data = HW6.bigcomp;

/* this gives it a title*/

title "PROC UNIVARIATE";

/* this runs the proc statement*/

run;

/* this runs the means statement only getting mean and sd*/

proc means data = HW6.bigcomp mean stddev;

/* this gives it a title*/

title "Descriptive Statistics";

/* this tells us how to categorize the data*/

class Country;

/* this pics th variables we want to get information on*/

Var Profits Assets;

/* thi runs the proc statement*/

run;



/****************************************************************************** 
Once your code looks good, run your script and verify your output.
*****************************************************************************/

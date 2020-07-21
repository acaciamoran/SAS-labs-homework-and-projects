/*****************************************************************************
* Name:        Acacia Moran
* Assignment:  Homework 7-16
*****************************************************************************/

*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;

/****************************************************************************** 
SAS procedures are a great way to get to know a data set. We can 
print the data out in very customizable ways, as well as ask SAS for many
descriptive statistics about the data using just some basic procedures like

- PROC PRINT
- PROC FORMAT
- PROC MEANS
- PROC FREQ
- PROC UNIVARIATE

Graphics are also just as important in any exploratory data. In this
lesson we're going to get a taste of graphics in SAS using a procedure called
PROC SGPLOT.

PROC SGPLOT is very flexible and robust, and it is capable of handily producing 
many different kinds of plots. Let's see this in action with the Big Company
data set we've used before. Remember to establish the appropriate library
for referencing this data set.
*****************************************************************************/

libname sasdata "/folders/myfolders";

*Recall what the data looks like.;
proc print data = sasdata.bigcomp;
run;

*Now, let's contruct a boxplot for the Profits variable.;
proc sgplot data = sasdata.bigcomp;
	vbox Profits;
run;

/****************************************************************************** 
VBOX is used to construct a Vertical Boxplot. This plot looks nice, but
it might be more informative to see this broken down by country. 
*****************************************************************************/

proc sgplot data = sasdata.bigcomp;
	vbox Profits / category = Country;
run;

/****************************************************************************** 
Notice that the option is specified after being separated by a "/";

Suppose we wanted to overlay a boxplot of Profits with a boxplot of Sales.
We can do this by specifying them in the same procedure step. This particular
graph may not be the most informative, but notice how nice and easy it is to
combine graphics. Because they might be overlapping, I've increased the 
transparency value so they're easier to see and distinguish. Feel free to play
around with these values.
*****************************************************************************/

proc sgplot data = sasdata.bigcomp;
	vbox Profits / transparency = .5;
	vbox Sales / transparency = .5;
run;


/****************************************************************************** 
Just like many other SAS procedures, PROC SGPLOT has a multitude of options
that can be used to customize its output. A good description of these can be 
found here:

https://support.sas.com/documentation/cdl/en/grstatproc/62603/HTML/default/viewer.htm#sgplot-chap.htm

In the space below write a few of your own SGPLOT procedures to do the 
following for the Big Company data:

- Create a histogram for at least two variables
- Create a scatterplot of Profits vs. Sales
- Use the WHERE statement within PROC SGPLOT to create overlaid histograms
of Sales and Assets for only the United States (you may want to 
play around with the transparency)
*****************************************************************************/


*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;

/* this crates a library*/

libname hw7 "/folders/myshortcuts/sf_MY_FOLDER/";

/* this makes a histogram for assets*/

proc sgplot data= hw7.bigcomp;

histogram assets / binwidth = 100 showbins scale = count;

title "Assets";

run;

/* this makes a histogram for marketvalue*/

proc sgplot data= hw7.bigcomp;

histogram marketvalue / binwidth = 10 showbins scale = count;

title "Market Value";

run;


/* this makes a scatter plot of profits vs. sales*/

proc sgplot data= hw7.bigcomp;

/* this assigns the x and y variables form the data for the scatter plot*/

scatter x= profits y= sales;

title "Profits vs. Sales";

run;

/* this makes a overlaid histograms plot*/

proc sgplot data= hw7.bigcomp;

/* this tells the program to only use date from the united states*/

where country = "United States";

/* this makes the first histogram */

histogram sales / binwidth = 100 transparency = 0.5 name = "sales" legendlabel = "Sales";

/* this makes the seconds histogram*/

histogram assets / binwidth = 100 transparency = 0.5 name = "assets" legendlabel = "Assest";

/* this gives the graph a legend*/

keylegend "sales" "assets" / across=1 position=TopRight location=Inside;

title "Sales and Assets for US";

run;


/****************************************************************************** 
Once your code looks good, run the script and verify the output.;
*****************************************************************************/


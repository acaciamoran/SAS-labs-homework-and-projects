/*****************************************************************************
* Name: Acacia Moran
* Assignment:  Homework 1-1
*****************************************************************************/

*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;



/*****************************************************************************
Let's get started!  These SAS scripts will introduce you to the basics of 
programming in SAS.

Take some time to acquaint yourself with the SAS interface.  Locate the toolbar 
at the top: menus and buttons for opening, running, and saving SAS scripts among 
other things.

The left hand part of your window is used for navigating the results of your scripts 
and the folders of your computer.  The majority of your SAS window are taken up by the 
Log, Output/Results Viewer, and Editor/Code sub-windows. Though  you may not be able 
to see all of these at once.


On to SAS...Almost all SAS scripts involve a DATA step and PROC step.

Left click the running man icon at the top to run this SAS script. Observe the output 
and then navigate back from the output window to this script.
*****************************************************************************/

data firstprogram;
greeting = "Hello World!";
run;

proc print data = firstprogram;
run;


/*****************************************************************************
In the space below write your own DATA and PROC PRINT steps. Feel free
to change the name of your data set to something other than 'firstprogram'. 
Change the greeting to something new as well. Be sure to use the same data
set name in your PROC PRINT that you did in your DATA step.
*****************************************************************************/

*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;
* this created my first program;
data myprogram1;

* this created a program;
greeting = "Welcome to my Computer";

*this runs my program;
run;

* this prints out the table;
proc print data = myprogram1;

* this runs the pro;
run;










/*****************************************************************************
Left click the running man icon once again. Notice that this runs the entire
SAS script we're working in. So both SAS data sets are printed. You should see
"Hello World!" in addition to your own greeting.
*****************************************************************************/




/*****************************************************************************
NOTE: It's OKAY (and encouraged) to include commented code as shown below in 
case something doesn't work ... that way I can provide at least some partial 
credit!
*****************************************************************************/

/*****************************************************************************
EXAMPLE: Here's what I tried for Part A but there's an error:

data firstprogram;
greeting = "Hello World!;
run;

proc prit data = firstprogram;
run;
/*****************************************************************************



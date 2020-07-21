/*****************************************************************************
* Name:        YOUR NAME HERE
* Assignment:  Homework 14-23
*****************************************************************************/

*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;

/****************************************************************************** 
It is common for data to be stored or collected across multiple files. Yet we 
still want to work with or analyze the collection of all observations (across 
all of the data sets). We've talked extensively about how to import a raw data set 
into SAS, but now we'd like to combine data sets (stored in separate files) into 
one large data set.

Consider the following two small data sets with ID and name.  You can think of
these as students from two sections of STAT 330.  When I get my STAT 330 official 
rosters, they are separated by sections, so I have two different data files 
containing student names and IDs.  To be able to analyze their data simulataneously, 
like to caclulate grades, I need to 'stack' the data sets.
******************************************************************************/

data section1;
input id name $ section;
datalines;
156 jim    1
453 janet  1
989 margot 1
;
run;

data section2;
input id name $ section;
datalines;
297 bob    2
635 denise 2
842 warren 2
;
run;

/****************************************************************************** 
We can stack these two data sets using the SET statement as follows:
******************************************************************************/

data allstudents;
	set section1 section2;
run;

proc print data = allstudents;
run;

/****************************************************************************** 
Sometimes when I examine my student data, I want to know if there are trends 
with regards to performance in my class.  Is better performance related to GPA,
major, or previous coding experience? This data contains student id and other variables, like GPA and
whether or not they are a statistics major.  
******************************************************************************/

data qx;
input id gpa statmajor $;
datalines;
297 3.545 Y
635 2.897 Y
156 3.678 N
453 3.291 Y
989 2.789 N
842 3.184 N
;
run;


proc print data=qx; run;


/****************************************************************************** 
To get one data set with both official roster information and the GPA/major
data, I need to `merge' the two data sets.  Note that both my qx data set and 
my allstudents data set have a common identifier - ID.  Prior to performing the
merge, both data sets should be sorted on the identifying variable.
******************************************************************************/

proc sort data=allstudents; 
	by id; 
run;

proc print data=allstudents; run;

proc sort data=qx; 
	by id; 
run;

proc print data=qx; run;

/****************************************************************************** 
Now we can combine the student data sets as follows:
--MERGE tells SAS to combine the data sets horizontally (a SET statement combines
  data sets vertically)
--BY tells SAS which variable(s) we to use to combine the data sets
******************************************************************************/

data students_with_qx;
	merge allstudents qx;
	by id;
run;

proc print data=students_with_qx; run;


/****************************************************************************** 
Voila!  Now I have combined my official roster data with the GPA/major data.
******************************************************************************/

/****************************************************************************** 
An example of data that might require merging is in clinical trials.  Often,
clinical trials are conducted double-blind, which means that neither the patient
nor the doctor administering treatment knows if the patients is in the 
placebo or the treatment group.  Suppose we randomly assign patients to two groups
- a group that receives a new treatment and a group that receives a placebo,
and we measure their systolic blood pressure (sbp) before and after treatment
is administered.

Consider the following three data sets:
- the placebo data set contains IDs of patients assigned to the placebo treatment
- the treatment data set contains IDs of patients assigned to the new treatment
- the results data set contains IDs of all patients and their blood pressure
  measurements before and after treatement
******************************************************************************/


data placebo;
input id $ group $10.;
datalines;
Z45U placebo
A943 placebo
Q8W2 placebo
B902 placebo
;
run;

data treatment;
input id $ group $10.;
datalines;
G832 treatment
U2I9 treatment
B0R3 treatment
N213 treatment
;
run;

data results;
input id $ sbp_before sbp_after ;
datalines;
Z45U 103 84 
A943 165 135
Q8W2 95  108
B902 84  78
G832 154 135
U2I9 89  65
B0R3 110 115 
N213 119 108
;
run;


/****************************************************************************** 
Now it is your turn to practice:
-Stack the placebo and treatment data sets
-Sort the stacked data and the results data by ID
-Merge the stacked data with the results data by ID
-In the merged data, calculate the difference between the two SBP meaurements
-Use a PROC to calculate the average SBP difference among the placebo and 
 treatment groups (separately).  Which medication (treatment or placebo) appears to 
 have the largest impact on change in SBP?
******************************************************************************/

data both;

	set treatment placebo;
	
run;

proc print data = both;

run;

proc sort data=both;
 
	by id;
	
run;

proc sort data=results;
 
	by id;
	
run;

proc print data = both;

run;

proc print data= results;

run;

data results_with_both;

	merge both results;
	
	by id;
	
run;

proc print data= results_with_both;

run;

proc print data= results_with_both; 

run;

data diff;

	set results_with_both;
	
	difference = sbp_before - sbp_after;

run;

/* the diff for A943 group was 30 and the diff for the B0R3 id was -5*/


proc print data = results_with_both;

run;

proc means data = diff mean;

var difference;

class group;

run;

/* the treatment group seems to have the biggest impact on the 
the change in sbp because it has a mean of 12.25 while the placebo
has a mean on 10.5*/



*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;


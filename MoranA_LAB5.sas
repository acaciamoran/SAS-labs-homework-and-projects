/*****************************************************************************
* Name: Acacia Moran
* Assignment:  Lab 5
*****************************************************************************/
/* this gets creates a library*/

libname desktop "/folders/myshortcuts/sf_MY_FOLDER/";

/* this creates the data set*/

data mydata;

/* this put the newyear data in*/

set desktop.NewYears;

/* this creates arrays for in and out times and the difference*/

array intime (119) inday1-inday119;

array outtime (119) outday1-outday119;

array difference (119) minutes1-minutes119;

/* this creates a loop for calculating diffference array*/

	do i=1 to 119;
	
	/* thi gets the difference in in and out times*/
	
		difference[i] = outtime[i] - intime[i];
	
	/* this converts to minutes*/
	
		difference[i] = difference[i]/60;
		
	/* this ends the loop*/
	
	end;
		
		/* this sums up all the differences for each observation*/
		
		total = sum(of difference(*));
		
		/* this divides by the total number of visits to get the average*/
		
		averagetime = total/119;
		
		/* this does the same thing for intime*/
		
		check = sum(of intime[*]);
		
		checkin = check/119;
	
	/* this categorizes as early bird afternooner or latenighter*/
	
	if (18000 < = checkin < 36000) then typeofperson = "Early-Birds";
		else if (36000 < = checkin < = 61200) then typeofperson = "Afternooners";
		else typeofperson = "Late-Nighters";
	
/* this runs the data step*/

run;

/* this creates temporary data sets for each category of people*/
data earlybirds;
	
set work.mydata;

	if typeofperson = "Early-Birds";
run;
/* Early-Birds has 99 obersevations*/

data afternooners;
	
set work.mydata;

	if typeofperson = "Afternooner";
/* this keeps only the variables we want*/

keep averagetime typeofperson checkin;

run;

/* Afternooners has 42 observations*/

proc print data = afternooners;

/* this formates the data*/

format checkin time.;

run;


data latenight;
	
set work.mydata;

	if typeofperson = "Late-Nighte";
run;

/* Late-Nighters has 104 observations*/

/* if we want all the data we can comment this in*/
/*proc print data = mydata;

run;*/
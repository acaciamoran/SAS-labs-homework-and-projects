/*****************************************************************************
* Name:        Acacia Moran
* Assignment:  LAB 4
*****************************************************************************/
/* Step One*/

/* this creates the data set*/

data studentloans;

/* this inputs the categories of the data*/

input name $ school $ loan interest collegestart years salary payment;
/* this initilizes the months of payment*/

month = 0;

/* this creates an initial loop for the loan*/

do until (loan =< 0);

	/* this takes off the payment each month*/
	loan = loan - payment;

	/* this add one to months*/

	month = month + 1;

	/* this adds the interest into the loan*/

	loan = loan*(interest/12) + loan;
	
	/* this ends the loop*/
	
	end;

/* this gets the years it took*/

 yearstopayoff = month/12;

/* this gets years after graduation*/

 yearsincegrad = ceil(years + yearstopayoff + collegestart);

 drop yearstopayoff;

/* this stores the data*/

datalines;
Hank ParkU 45000 .059 2012 4 70000 850
Sarah BlueMtn 40000 .058 2014 4 85000 900
Steve Vassar 204000 .06 2012 5 80000 1200
Chris Trinity 180000 .055 2010 4 90000 925
Emily Amherst 120000 .058 2014 4 75000 950
Jessica Berea 6000 .05 2013 5 65000 800
Mark Rust 38000 .0575 2011 4 60000 850
;

/* this runs the data lines*/
run;

/* this prints the observations to the screen*/

proc print data = studentloans;

 /* this puts a title to the data table*/

title "Student Loans";

/* this runs the proc and title*/

run;


/* Step Two*/

/* this creates the data set*/

data studentloans;

/* this inputs the categories of the data*/

input name $ school $ loan interest collegestart years salary payment;
/* this initilizes the months of payment*/

month = 0;

/* this creates an initial loop for the loan*/

do until (loan =< 0);

	/* this takes off the payment each month*/
	loan = loan - payment;

	/* this add one to months*/

	month = month + 1;

	/* this adds the interest into the loan*/

	loan = loan*(interest/12) + loan;
	
	/* this sees if its been a year8*/
	
	beenyear = mod(month,12);
	
	/* this checks if its been and year and if so runs through the loop*/
	
	if (beenyear = 0) then do;
	
		/* this increases the persons salary if its been a year*/
	
		salary = salary + (salary*.03);

		/* this increases the persons payment if its been a year*/
	
		payment = payment + (payment*.03);
		end;
	end;

/* this gets the years it took*/

 yearstopayoff = month/12;

/* this gets years after graduation*/

 yearsincegrad = ceil(years + yearstopayoff + collegestart);

 drop yearstopayoff;

/* this stores the data*/

datalines;
Hank ParkU 45000 .059 2012 4 70000 850
Sarah BlueMtn 40000 .058 2014 4 85000 900
Steve Vassar 204000 .06 2012 5 80000 1200
Chris Trinity 180000 .055 2010 4 90000 925
Emily Amherst 120000 .058 2014 4 75000 950
Jessica Berea 6000 .05 2013 5 65000 800
Mark Rust 38000 .0575 2011 4 60000 850
;

/* this runs the data lines*/
run;

/* this prints the observations to the screen*/

proc print data = studentloans;

 /* this puts a title to the data table*/

title "Student Loans";

/* this runs the proc and title*/

run;
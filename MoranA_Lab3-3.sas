/*****************************************************************************
* Name:        Acacia Moran
* Assignment:  LAB 3
*****************************************************************************/

*Part 1;

*this creates the macro with one parameter;

%macro daycounter (d=);

	*this initializes the data;
	data lab3;

	* this initializes the variable sunday;
	letterday = 0;

	* this goes through all the days;
	do date = '01JAN1901'd to '31DEC2000'd;

		* this gets the day of the week;
		dayofweek = weekday(date);

	*this checks if its a Sunday;
	if dayofweek = &d then do;
	
	*this gets the day of the month it is;
		day = day(date);
		
			*this checks if the day is the first;
			if day = 1 then do;

				*this adds one to sunday counter;
				letterday = letterday + 1;
				output;
end;
end;
end;

run;

proc print data = lab3;
format date MMDDYY10.;
title "The day of the week is &d";

run;

*this ends the macro;

%mend daycounter;

*this tries the different days;

%daycounter(d=1);

%daycounter(d=2);

%daycounter(d=3);

%daycounter(d=4);

%daycounter(d=5);

%daycounter(d=6);

%daycounter(d=7);

/*Part two*/

/*This makes the macro with 5 parameters*/

%macro biggestsample(n1=, n2=, C= , a=, b=);
	/* the actual mean is 5 and the sd for 50 is 2.89/squareroot(50) = .408*/
	/* the actual mean is 5 and the sd for 150 is 2.89/squareroot(150) = .236*/

	/* this makes the data step*/

	data samplelarge;

	/* this makes some arrays to store the data in*/

	array sampleA (&C);

	array sampleB (&C);

	/* this creates an array to fun through and get 500 means*/

	do j = 1 to &C;

		/* this is the old code*/

		/* this sets the seed*/

		call streaminit(1);

		/* this creats the array for the sample of 50*/
		array smallsample (&n1);

		/* this makes the two uniform distribution*/

		do i = 1 to &n1;

			/* this gennerates values from the uniform distribution into my array*/

 			smallsample(i) = rand("uniform", &a, &b);
 
 		/* this ends the loop*/

 		end;
 
 		/* this creates the array for the sample of 150*/

		array largesample (&n2);

		/* this makes the two uniform distribution*/

		do i = 1 to &n2;

			/* this gennerates values from the uniform distribution into my array*/

			largesample(i) = rand("uniform", &a, &b);
 
		* this ends the loop;

		end;

		/* this finds the mean of both samples*/

		mean50 = mean(of smallsample(*));

		mean150 = mean(of largesample(*));

		/* this finds the sd of both samples*/

		sd50 = std(of smallsample(*));

		sd150 = std(of largesample(*));

		/* the sd and mean are very close to the*/
		/*actual mean and sd of a uniform distribution*/ 
		/*within about .1 for the sd and 1 for the mean*/
		
		/* this is the end of the old code;

		/*this is storing the means in my means of means array*/

		sampleA[j] = mean50;

		sampleB[j] = mean150;

		/* this gets the mean of means*/

		mean1 = mean(of sampleA(*));

		mean2 = mean(of sampleB(*));

		/* this finds the sd of both samples*/

		sd1 = std(of sampleA(*));

		sd2 = std(of sampleB(*));

		/* the only keeps the means and sd's*/

	keep mean1 mean2 sd1 sd2;

	end;

	/* the mean of means and the sd*/
	/*were extremely close to the actual ones we calculated in a*/
	/*The mean was within .001 of the actual mean for both samples*/
	/*The sd for 50 was within .002*/
	/*The sd for 150 was within .02*/
	run;

	proc print data=samplelarge;
	title "Sample size one is &n1 and sample size two is &n2 with a repeated &B times";
 
	run;

/* this ends the macro*/

%mend biggestsample;

/*these run the macro*/

%biggestsample(n1=50, n2=150, C=500, a=0, b=10);
%biggestsample(n1=10, n2=200, C=1000, a=0, b=40);

/*Part 3*/

*this makes the macro with 3 parameters;

%macro celebrations(month=, day=, year=, n=);

	/* this creates the data set*/

	data birthdayfun;
	
	/*this gets the year to stop*/
	 yearstop = &year + &n;
	
	/* this gets the day of the week for each year*/
	
	do i = &year to yearstop;
	
		/* this takes in the birthday*/
	
		birthday = mdy(&month, &day, i);
		
		/* this gets the 2nd friday of the birthday month*/
		
		friday2 = nwkdom(2, 6, &month, i);
	
		/* this gets the 4th friday of the birthday month*/
		
		friday4 = nwkdom(4, 6, &month, i);
		
		/*this checks the day of the week*/
		
		dayofweek = weekday(birthday);
		
		output;
		
	/* this ends the do loop for years*/
	
	end;
	
	/* this gets rid of non wanted variables*/
	drop i yearstop;
	
	/* this puts it to the screen*/
	
	proc print data = birthdayfun;
	
	/*this fixes the format*/
	
	format birthday MMDDYY10.;
	
	format friday2 MMDDYY10.;
	
	format friday4 MMDDYY10.;
	
	/* this runs the proc print*/
	run;
	
/* this ends the macro*/

%mend celebrations;

/*this plugs in variables*/

%celebrations(month=10, day=14, year=1997, n=10);

%celebrations(month=10, day=14, year=1997, n=20);	

	





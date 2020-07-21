/*****************************************************************************
* Name: Acacia Moran
* Assignment:  Lab 2
*****************************************************************************/
* STEP 1;


* this makes my data;

data lab2;

* this initializes the variable sunday;
sunday = 0;

* this goes through all the days;
do date = '01JAN1901'd to '31DEC2000'd;

* this gets the day of the week;
	dayofweek = weekday(date);

*this checks if its a Sunday;
	if dayofweek = 1 then do;
	
*this gets the day of the month it is;
		day = day(date);
		
*this checks if the day is the first;
		if day = 1 then do;

*this adds one to sunday counter;
		sunday = sunday + 1;
		output;
end;
end;
end;

run;

proc print data = lab2;
format date MMDDYY10.;

run;



*STEP 2;

* this makes the data step;

data distribution;

* this sets the seed;
call streaminit(1);

* this creats the array for the sample of 50;
array smallsample (50);

* this makes the two uniform distribution;

do i = 1 to 50;

* this gennerates values from the uniform distribution into my array;

 smallsample(i) = rand("uniform", 0, 10);
 
 * this ends the loop;

 end;
 
 * this creates the array for the sample of 150;
array largesample (150);

* this makes the two uniform distribution;

do i = 1 to 150;

* this gennerates values from the uniform distribution into my array;

largesample(i) = rand("uniform", 0, 10);
 
* this ends the loop;

end;

* this finds the mean of both samples;

mean50 = mean(of smallsample(*));

mean150 = mean(of largesample(*));

* this finds the sd of both samples;

sd50 = std(of smallsample(*));

sd150 = std(of largesample(*));

* the sd and mean are very close to the;
*actual mean and sd of a uniform distribution; 
*within about .1 for the sd and 1 for the mean;

keep mean50 mean150 sd50 sd150;
run;

proc print data=distribution;
 
run;


*STEP 3;

* the actual mean is 5 and the sd for 50 is 2.89/squareroot(50) = .408;
* the actual mean is 5 and the sd for 150 is 2.89/squareroot(150) = .236;

* this makes the data step;

data samplelarge;

* this makes some arrays to store the data in;

array sampleA (500);

array sampleB (500);

* this creates an array to fun through and get 500 means;

do j = 1 to 500;

* this is the old code;

* this sets the seed;

call streaminit(1);

* this creats the array for the sample of 50;
array smallsample (50);

* this makes the two uniform distribution;

do i = 1 to 50;

* this gennerates values from the uniform distribution into my array;

 smallsample(i) = rand("uniform", 0, 10);
 
 * this ends the loop;

 end;
 
 * this creates the array for the sample of 150;

array largesample (150);

* this makes the two uniform distribution;

do i = 1 to 150;

* this gennerates values from the uniform distribution into my array;

largesample(i) = rand("uniform", 0, 10);
 
* this ends the loop;

end;

* this finds the mean of both samples;

mean50 = mean(of smallsample(*));

mean150 = mean(of largesample(*));

* this finds the sd of both samples;

sd50 = std(of smallsample(*));

sd150 = std(of largesample(*));

* the sd and mean are very close to the;
*actual mean and sd of a uniform distribution; 
*within about .1 for the sd and 1 for the mean;

* this is the end of the old code;

*this is storing the means in my means of means array;

sampleA[j] = mean50;

sampleB[j] = mean150;

* this gets the mean of means;

mean1 = mean(of sampleA(*));

mean2 = mean(of sampleB(*));

* this finds the sd of both samples;

sd1 = std(of sampleA(*));

sd2 = std(of sampleB(*));

* the only keeps the means and sd's;

keep mean1 mean2 sd1 sd2;

end;

* the mean of means and the sd;
*were extremely close to the actual ones we calculated in a;
*The mean was within .001 of the actual mean for both samples;
*The sd for 50 was within .002;
*The sd for 150 was within .02;
run;

proc print data=samplelarge;
 
run;


/*****************************************************************************
* Name: Acacia Moran
* Assignment:  Lab 11
*****************************************************************************/

/* STEP 1 */

/* this gets creates a library*/

libname olympics "/folders/myshortcuts/MY_FOLDER/";

/* STEP 2 */

/* this creates the data set*/

data athlete;

/* this put the 02012 data in*/

set olympics.o2012;

run;

/* this gives us counts of the data by variables*/

proc freq data = athlete;

run;

/* each data point represents a person in the olympics that won a medal. 
There are 496 obseravations.*/

/* STEP 3 */

/* this open the data in another data set and stores it in this new one*/

proc sort data = athlete out = bycountry;

/* this sorts the data by country*/

by country;

run;

/* step 4 a */

/* this creates the data step*/

data newvariables;

/* this brings in the sorted data*/

  set bycountry;
  


/* this sorts the data by country*/
 
by country;

/* this creates a conditional by country*/
	
if first.country then do;

/* this sets the tracking totals to zero*/
	num_nomisswt = 0;
    num_medalists =0;
    num_total=0;
    num_silver=0;
	num_gold=0;
    num_bronze =0;
	num_medals=0;
    max_medals=0;
      
/* this ends the if statment*/

end;

/* STEP 4B PART 2*/

/* this checks if we have found the max number of medals*/

if (total > max_medals) then max_medals = total;	

/* this retains the count*/

retain max_medals;

/* STEP 3A */

num_gold + gold;

num_silver + silver;

num_bronze + bronze;

/* this moves the number up one*/

   num_medals +1;
   
/* this creates the new variable*/

num_total + total;

/* this moves the number up one*/

   num_medalists +1;
   
/* STEP 6C */

/* this checks if the weight it missing 
and if it is not then it adds to the count for num_nomisswt*/

if weight > 0 then do;

/* this incriments the counter if the person has weight value*/

	num_nomisswt + 1;
	
/* this tracks the the total weight when the obsevations have weight*/

	totalweight + weight;
	
end;

/* STEP 4B PART 1*/

/* this finds the last country and uses it to find the ratio*/
 
if last.country then do;

/* this creates the ratio variable*/

	ratio = num_total/num_medalists;
	
/* STEP 6D */

/* this calculates the average weight using the two variables 
that are adjusted for by having weight values*/	

	ave_wt_fixed = totalweight/ num_nomisswt;
	
end;

/* step 4 c part two*/

/* this checks if the person is male or female*/

if gender = "M" then do;

/* this adds a value to count if they are male*/

	count + 1;
	
/* this ends the if stament */

end;

/* this checks if its the last country*/

totalwt + weight;
totalage + age;
totalheight + height;


if last.country then do;

/* this finds the proportion of males for each country */

/*STEP 4C*/

		prop_m = count/num_medalists;

/* this finds the averages using the total found earlier*/
		
		ave_age = totalage/num_medalists;
		
		ave_wt = totalwt/num_medalists;
		
		ave_ht = totalheight/num_medalists;
/* this sets the count back to zero*/

		count = 0;
		
		totalweight = 0;
		
		totalage = 0;
		
		totalwt = 0;
		
		totalheight = 0;
		
		
/* this ends the if statement*/
	
end;

/* this runs the data by country*/

run;



/* this print the data*/

proc print data = newvariables;

run;


/* STEP 5A*/

/* is does not make sense for the ratio to be less than one because all
the athletes have at least one medal therefore the ratio of total medals 
to athletes has to be at least one because each athlete contributes 
at least one medal*/

/* STEP 5B */

/*the countries with ratios less than one are Great Britain, Spain, and Pakistan*/

/* STEP 5C */

proc print data = newvariables;

where ratio between 0 and .99;

var country name total num_total num_medalists ratio;

run;

/* they have a ratio of less than one because they were missing data on
on on certain people Great Britain's Peter Bakare was missing data on him
Pakistan was 0 because Imran Butt was missing data Spain was less than one because 
Albert Espanol Lifante was missing data*/

/* STEP 6A */

/* this gets the data to print*/

proc print data = newvariables;

/* this tells proc print to only print data where weight is missing*/

where weight is missing;

/* this tells it what variables to print it for */

var sport;


run;

/* Rowing, Shooting, Gymnastics - Artistic, Cycling - Road, Fencing, Trampoline */

/* STEP 6B */

/* Gymnastics-Artistic has the most missing data for weight */

/* STEP 7A */

data oneobs;

/* this takes only the variables needed*/

set newvariables (keep = country num_nomisswt ave_wt_fixed num_medalists 
num_gold num_silver num_bronze num_total ratio max_medals ave_age 
ave_wt ave_ht prop_m);

/* this gets the data by country*/

by country;

/* this picks only the last observations*/

if last.country then output;

run;

/* STEP 7B */

/* the round function makes it only two decimal places*/

proc print data = oneobs round;

run;



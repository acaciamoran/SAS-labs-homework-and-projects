/*****************************************************************************
* Name: Acacia Moran
* Assignment:  Lab 6
*****************************************************************************/
/* Step 1*/

/* this gets creates a library*/

libname beer "/folders/myshortcuts/MY_FOLDER/";

/* Step 2*/

/* about 13.59 oz is the average size of a craft beer*/

/* Step 3*/

/* about 6.00% is the average abv of craft beer*/

proc  means data = beer.craftbeer mean;

var abv oz;

Title "Problem 2 and 3";

run;

/* Step 4*/

/* Brewery Vivant has the most beers 62 and a bunch of brewery's only have one beer*/

proc freq data = beer.craftbeer order=freq;

table brewery;

title "Problem 4";

run;

/* Step 5*/

/*Port Side Brewery had the highest avg abv of .099*/
/*South Hampton Publick House had the lowest avg abv of .035*/

proc means data = beer.craftbeer;

var abv;

class brewery;

title "Problem 5";

proc sort data = beer.craftbeer;
by brewery;

run;

/* Step 5 a*/

/* Uncommon Brewers has the lowest abv (.001)*/

/* Upslope Brewing Company had the highest abv (.128)*/

proc means data = beer.craftbeer;

class abv brewery;

title "Problem 5a";

run;

/* Step 6*/

/*Colorado produces 265 craft beers*/
/*Delaware and West Virgina only produce 2*/

proc means data = beer.craftbeer;

class state;

title "Problem 6";

run;

/* Step 7*/

proc means data = beer.craftbeer;

where style contains "Lager";

var abv oz;

title "Problem 7 Lager";

run;

/* Lager has 158 observations with a mean abv of .050 and mean oz of 13.165*/

proc means data = beer.craftbeer;

where style contains "Ale";

var abv oz;

title "Problem 7 Ale";
run;

/* Ale has 976 observations with a mean abv of .057 and mean oz of 13.473*/

proc means data = beer.craftbeer;

where style contains "IPA";

var abv oz;

title "Problem 7 IPA";

run;

/* IPA has 571 observations with a mean abv of .069 and mean oz of 13.754*/

/* Ale makes up 976 of all the beer in the data*/

/* Step 8*/

proc format;

value size 16 = "Pint"
		0-<16 = "Sub-Pint"
		16<-HIGH = "Super-Pint";
		

proc print data = beer.craftbeer;

format oz size.;

title "Problem 8";

run;
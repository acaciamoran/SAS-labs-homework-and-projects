/*****************************************************************************
* Name: Acacia Moran
* Assignment:  Lab 9
*****************************************************************************/
/* this creates the library */

libname mario "/folders/myshortcuts/MY_FOLDER/";

/* Step 1*/

/* this gives the tables a title*/

title 'Extreme Observations';

/* this tells the computer to use extreme observations*/

ods select ExtremeObs;

/* this uses the data from the library*/

proc univariate data=mario.mariokart;

/* this tells which variable to search*/

	var totalPr;
	
/* this runs the proc univariate*/
run;
/* obs # 65 with 118.50 and obs # 20 326.51 
they are outliers because they are much larger 
than the mean of the data*/

/* step 2*/

/* this gives the data a new name*/

data game;

/* this sets the data into game*/

set mario.mariokart;

/* Step 3*/

/* this creates the indicator variables*/

if cond = "new" then  condI = 1;

else condI = 0;

if stockphoto = "yes" then photoI = 1;

else photoI = 0;

/* Step 4*/

if wheels => 2 then wheelsnew = "2+";

else if wheels = 1 then wheelsnew = 1;

else if wheels = 0 then wheelsnew = 0;

/* these remove the data that are outliers*/

   if totalPr=118.50 then delete;
   
   if totalPr=326.51 then delete;

/* this runs the data step*/
run;
/* Step 5a*/

/* this runs the data into proc freq*/

proc freq data = game;

/* thsi uses the variables give*/

tables totalPr wheelsnew;

/* this runs the proc freq*/

run;

/* since the sample sizes are all greater than 30
and we can assume independence and variance is similar 
than we can use proc anova. The data is unbalanced 
because the sample sizes are different but we can still
use proc anova*/

/* Step 5b */

/* this runs the data into theh proc anova*/

proc anova data = game;

/* this defines the cat var*/

class wheelsnew;

/* this defines the model*/

model totalPr = wheelsnew;

/* this tells which way to test*/

/* step 5c*/

means wheelsnew / tukey;

/* requires quit*/

/* rejected the null with a p value of <.0001 at the .05 sig level
we reject the null and provide eveidence that the population average 
total selling price (totalPr) differs by the number of wheels 
a package comes with (wheelsnew)*/

/* All the pairwise comparisons were significant at the .05 significnace level*/
quit;



/* step 5d*/

/* this will give me the plots for all of the data*/

proc glm data=game plot=diagnostics;

/* this is the cat variables*/

   class wheelsnew;
   
/* this is the model we are testing*/
  
   model totalPr = wheelsnew;

/* this runs the proc glm*/

run;

/* normality is ok there is no obvious cure to the data
and the data follows closely to the line in the normality plot*/
/* equal variance is ok there is no obvious fan shape to the data and 
there is a even spread above and below the data*/
/* independence might be violated because the selling price of one game
might effect the selling price of another game with similar number of wheels*/


/* Step 6a*/

/* this turns the graphics on*/

ods graphics on;

/* this gives the data a title*/

title 'Total Selling Price Data';

/* this does a correlation procedure plots= scatter makes the scatter plots*/

PROC CORR DATA=game plots=scatter;

/* this tell the main vaiable*/

    VAR totalPr;

/* this tells what variable to compare the main one to*/

    WITH duration nBids startPr shipPr SellerRate;
    
/* this runs proc corr*/

RUN;

/* this turns the graphics off*/

ods graphics off;

/* step 6b*/

/* duration had the strongest linear association with totalPr
with negative linear association of .37416*/


/* step 6c 6d*/

/* thsi turns the graphics on*/

ods graphics on;

/* this runs a regression of the data*/

proc reg data=game;

/* this tells it what variables to use*/

   model totalPr=duration;
   
/* this runs the proc reg*/

quit;

/* thsi turns the graphics off*/

ods graphics off;

/* totalPr = 52.37 + -1.31716*duration */
/* 1.observations are independent, resonable to assume that the duration of one action
would affect another
2. linear relationship between x and y. found in part 6c
3. normally distributed errors about the regression line, The normal quantile plot
doesnt curve off the line
4. constant variability in y about the regression line (constant variance), ok there is no obvious fan shape to the data and 
there is a even spread above and below the data*/

/* step 6e*/

/* this turns the graphics on*/
ods graphics on;

/* this runs a regression on the data*/

proc reg data=game;

/* this tells it what variables to use and slection tells it what type
find the best model*/

model totalpr = duration nBids startPr shipPr
                SellerRate wheels condI photoI
    / selection = stepwise
;

/* this runs the regression*/

quit;

/* this turns the graphics off*/

ods graphics off;


proc print data= game;
run;




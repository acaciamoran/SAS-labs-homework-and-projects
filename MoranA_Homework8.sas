/*****************************************************************************
* Name:        Acacia Moran
* Assignment:  Homework 8-17
*****************************************************************************/

*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;

/****************************************************************************** 
Let's learn about how to use the statistical procedures PROC TTEST and PROC CORR.

The SAS data set cereals contains various nutritional information on
breakfast cereals in a typical grocery store. 
*****************************************************************************/
libname flash "/folders/myfolders";

proc contents data=flash.cereals varnum;
run;

/****************************************************************************** 
Suppose we wanted to test the hypothesis that the average amount of Calories 
per serving for cereals at this store is greater than 100 at the 5% 
significance level.

H0: Mu=100 vs HA: Mu>100

PROC TTEST can be used for one-sample, two-sample, and paired t-tests. 
Specifying one variable tells SAS to do a one-sample test.  We can also 
specify the null and alternative hypotheses to test with PROC TTEST.
*****************************************************************************/

proc ttest data = flash.cereals H0 = 100 sides = U alpha = .05;
var calories;
run;

/****************************************************************************** 
Review the syntax and optional statements for PROC TTEST here:

http://support.sas.com/documentation/cdl/en/statug/63033/HTML/default/viewer.htm#statug_ttest_sect001.htm

Below are templates for how to execute the paired t-test and the two-sample
t-test.  Note that the template code below won't work because
we haven't inserted data set names and variables.
*****************************************************************************/

* For a paired t-test follow this template;
proc ttest data = <data-set name> alpha = .05; 
paired <var1>*<var2>;
run;

* For the two sample t-test follow this template;
proc ttest data = <data-set name> alpha = .05; 
var <var1>;
class <categorical variable that defines groups>;
run;

/****************************************************************************** 
Suppose we wanted to investigate the relationship between the amount Sugar
per serving and the amount of Calories per serving in these cereals (both 
quantitative variables). We've already seen how we could create a scatterplot
to visualize this, and we can use the correlation to measure the strength of the 
linear association. We can compute use PROC CORR to compute the correlation.
*****************************************************************************/

proc corr data = flash.cereals;
var Sugar Calories;
run;


/****************************************************************************** 
By default, PROC CORR generates some summary statistics as well as a
correlation matrix with correlations between all pairs of variables 
specified in the VAR statement.

If we want to restrict our output to only correlations between specific
pairs of variables we can use the WITH statement. This will produce 
correlations between all of the variables in the VAR statement and all of 
the variables in the WITH statement.
*****************************************************************************/

proc corr data = flash.cereals;
var Sugar TotalFat;
with Calories Carbs; 
run;

/****************************************************************************** 
Notice that the output also includes a p-value for the hypothesis test that the 
population correlation (rho) is equal to 0.

H0: rho = 0 vs HA: rho =/= 0
*****************************************************************************/


/****************************************************************************** 
In the space below write your own PROC TTEST and PROC CORR steps to:

- Test if the mean amount of Sugar per serving is different from 10g
at the 1% significance level (=/= ---> means not equal!)

		H0: Mu=10 vs HA: Mu=/=10

- Test if the mean amount of TotalFat is different among
cereals that have trans-fat and cereals that do not (TRANS)

	    H0: Mu_yes=Mu_no vs HA: Mu_yes=/=Mu_no

- Compute the correlation between protein and fiber SEPARATELY for the
TRANS classification of cereals (YES/NO).  (Hint: use a where statement.)
*****************************************************************************/

*<--- TYPE CODE WITHIN THESE BOUNDS  ----  TYPE CODE WITHIN THESE BOUNDS --->;
*1234567890123456789012345678901234567890123456789012345678901234567890123456;

/* this gets the data from my folder and puts it in the library I made*/

libname sig "/folders/myshortcuts/MY_FOLDER/";

/* ( Varnum) Print a list of the variables by their position in the data set. 
By default, the CONTENTS statement lists the variables alphabetically.*/

proc contents data=sig.cereals varnum;

run;

/* the t test runs like a hypothesis*/

/* HO is the amount being tested, sides is either 
U(upper), L(lower), 2 (one sided, twosided)*/
/* alpha is the significance level*/
/* var specifies the variable*/

/* step one*/

proc ttest data = sig.cereals H0 = 10 sides = 2 alpha = .01;

var sugar;

title "H0: Mu=10 vs HA: Mu=/=10";

run;


/* step 2*/

/* there is not HO because your just comparing the groups*/

proc ttest data = sig.cereals alpha = .05; 

/* this is variable being tested*/

var totalfat;

/* this is the categorical variables its beign seperated out by*/

class trans;

title "H0: Mu_yes=Mu_no vs HA: Mu_yes=/=Mu_no";

run;

/* step 3*/

/* without Transfat */

proc corr data = sig.cereals;

var protein fiber;

/* specifies to use only cereals with no transfat*/

where trans = "NO";

title "No TransFat";

run;

/* with Transfat */

proc corr data = sig.cereals;

var protein fiber;

/* specifies to use only cereals with transfat*/

where trans = "YES";

title "Has TransFat";

run;




/****************************************************************************** 
When your code looks good, run the script and verify the output.
*****************************************************************************/


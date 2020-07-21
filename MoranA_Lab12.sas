/*****************************************************************************
* Name: Acacia Moran
* Assignment:  Lab 12
*****************************************************************************/

/* this creates the macro*/

/* part 1*/

%let location = /folders/myshortcuts/MY_FOLDER/;


/* part 2 a */

/* some of the problems that need to be addressed about reading in the data 
are that the data is all in one column, the date has both letters and numbers
and its seperated by a dash. Also there are some spaces in the team name and
dashes as well. The names are also different lenghts. There is also a and symbol
in one of the lines*/

/* part 2b */

data football ;

infile "&location.rosebowl.dat" ; 

/* part 2c  */

input date date10. @13 team1 : &$22. score1 team2 : &$22. score2;

/* part 2d */

/* this sees if the score1 is greater and if so sets result to team one wins*/

if score1 > score2 then result = "team 1 wins";

/* this sees if the score2 is greater and if so sets result to team two wins*/
	
else if score2 > score1 then result = "team 2 wins";

/* this sees if the teams tie if so sets result equal to tie*/
	
else result = "tie";

run;

/* part 2e */

proc print data = football;

/* this only picks the data that is a tie game*/

where result = "tie";

/* this applies a format to to the date variable*/

format date mmddyy10.;

run; 

proc contents data = football;

run;

/* part 2 f */

/* this takes the data set and makes a new one*/

proc sort data = football out = teamsort;

/* this sorts the data by result*/

by team1;

run;

data totals;

set teamsort;

by team1;

/* this checks if its the first team and if it
is it sets the total wins to zero*/

if first.team1 then totalwins = 0;

/* if the result is a win for team one it adds one to team one*/

if result = "team 1 wins" then totalwins + 1;

/* this checks if it the last team1 and if it is it outputs*/

if last.team1 then output;

run;

/* part 2g */

proc print data = totals;

/* this only prints the data that is the variables we asked for */

var team1 totalwins;

run;

/* part 3a */

/* The ben and jerry's data has some special charateristics in
the name we need to take care of. Also there are alot of missing data
and the descrition is super long . The last vairable has blank lines.
In on of the numeric variables there is a < sign*/

/* part 3b */

data icecream ;

infile "&location.BenAndJerrys2.dat" dlm = "," dsd truncover; 

/* step 3c*/

input flavor : $30. portion calories fatcalories fat satfat tranfat cholesterol sodium

tcarbohydrate dietaryfiber $ sugar protein yearin :$4. yearre :$4. description : $100. notes : $200.;

/* step 3d this gets rid of the data with shop Exclusive*/

if notes ne "Scoop Shop Exclusive" then output;

run;

proc print data= icecream;

run;

/* step 3e*/

proc sgplot data = icecream;

/* this gives the graph axis and colors the dots by color */

scatter x = fat y = calories / colorresponse = tcarbohydrate

	markerattrs = (symbol = CircleFilled size= 10);
	
/* this gives the graph a title*/

title "Grocery Store Ben and Jerrys flavors";

run;


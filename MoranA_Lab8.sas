/*****************************************************************************
* Name: Acacia Moran
* Assignment:  Lab 8
*****************************************************************************/
/* this creates the library */

libname poison "/folders/myshortcuts/MY_FOLDER/";

/* Step 1a */
/* 1) paired 2)t=3.76 p = .0003. With a p value of .0003 
we would reject the null that the average lead blood 
concentration did not changed between 1972 (Ld72) and 1973 (Ld73)
and provide evidence that the average lead blood concentration 
did change between 1972 and 1973*/

proc ttest data = poison.lead H0 = 0 alpha = .05 sides=2;
	
	paired Ld72*Ld73;

run;

/* Step 1b */

/* 1) 1 sample t test 2)t=29.95 p <.0001.
we would reject the null hypothesis that 
the the population average in 1973 did not 
exceed the safe limit of 5 and provide evidence
that the average lead blood in 1973 exceed's the safe limit.*/

proc ttest data = poison.lead H0 = 5 alpha = .05 sides=2;
	
	var Ld73;

run;

/* Step 1c */

/* p < .0001 which means we have strong evidence to 
reject the null and provide evidence that their is 
an association between verbal IQ and performance IQ*/

proc corr data = poison.lead;

	var Iqv;
	
	with Iqp;

run;

/* Step 1d */

/* p1 = 0.0794 p2 = 0.0919 since both p values were
greater than .05 we would fail to reject the null 
that the population average left hand finger wrist 
tapping ability differ by whether or not children 
were in the lead or control group */

proc ttest data = poison.lead alpha=.05 sides=2;

	var FWT_l;
	
	class Group;

run;

/* Step 2a */

%macro leadp (dsn= , quantvar= , catvar=, siglev=, doplot=);

/* Step 2b*/

/* this gives the data a title*/

title "Two sample t test with &quantvar seperated by &catvar with a &siglev 
significance level with &doplot plots";

/* Step 2c */

/* this creates a if statement for if the data is supposed to have plots or not*/

%if &doplot = Y %then %do;

/* this runs a two sample t test*/

	proc ttest data = poison.lead alpha=&siglev sides=2 plots = all;

/* this gets the quant var*/

		var &quantvar;
	
/* this seperates by the cat var*/
		class &catvar;

	run;

/* this ends the if and else statement*/

	%end;

/* goes here if you do not want plots*/
	
%else %do;

	proc ttest data = poison.lead alpha=&siglev sides=2 plots = none;

	
		var &quantvar;
	
		class &catvar;

	run;
	%end;

/* this ends the macro*/

%mend leadp;

/* this tests the two hypothesis*/

%leadp(dsn= poison.lead, quantvar= Visrea_l , catvar= Sex, siglev= .05, doplot= Y);
%leadp(dsn= poison.lead, quantvar= Iqf , catvar= Pica, siglev= .01, doplot= N);
/* Step 2d */

/* this tests the ones I came up with*/

%leadp(dsn= poison.lead, quantvar= Audrea_r , catvar= Group, siglev= .05, doplot= Y);
%leadp(dsn= poison.lead, quantvar= Audrea_l , catvar= Group, siglev= .05, doplot= Y);
%leadp(dsn= poison.lead, quantvar= FWT_r , catvar= Group, siglev= .05, doplot= Y);
/* Audrea_l had the smallest p value of .1124 so the strongest association but none of the 
variables were significant at the .05 sig level*/

/* Step 3 */

/* old code*/

%macro leadp (dsn= , quantvar= , catvar=, siglev=, doplot=);

/* new code*/
	proc freq data = &dsn;
		table &catvar/nopercent out=varfreqs;
		title"Frequency";
	run;

	data temp; 
		set varfreqs;
		if _n_ = 1 then do;
			call symputx("n1", count);
		end;
		else do;
			call symputx ("n2", count);
		end;
	run;
	
	%if &n1 < 30 or &n2 <30 %then %do;
		proc print data = &dsn;
			title "Two sample ttest of &quantvar by &catvar at alpha = &siglev";
			title2 "Warning; sample size of &n1 and &n2 may be too small for valid inference";
		run;
	%end;
	%else %do;
		proc print data = &dsn;
			title "Two sample ttest of &quantvar by &catvar at alpha = &siglev";
		run;
	%end;
/* old code*/

%if &doplot = Y %then %do;
	proc ttest data = poison.lead alpha=&siglev sides=2 plots = all;
		var &quantvar;
		class &catvar;
	run;
	%end;
%else %do;
	proc ttest data = poison.lead alpha=&siglev sides=2 plots = none;
		var &quantvar;
		class &catvar;
	run;
	%end;
%mend leadp;
%leadp(dsn= poison.lead, quantvar= Visrea_l , catvar= Sex, siglev= .05, doplot= Y);
%leadp(dsn= poison.lead, quantvar= Iqf , catvar= Pica, siglev= .01, doplot= N);
%leadp(dsn= poison,lead, quantvar= Audrea_r , catvar= Group, siglev= .05, doplot= Y);
%leadp(dsn= poison.lead, quantvar= Audrea_l , catvar= Group, siglev= .05, doplot= Y);
%leadp(dsn= poison.lead, quantvar= FWT_r , catvar= Group, siglev= .05, doplot= Y);

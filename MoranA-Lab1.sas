/*****************************************************************************
* Name: Acacia Moran
* Assignment:  Lab 1
*****************************************************************************/
* this changes the cut off dte to 1950;

options yearcutoff=1950;

* this makes my data;

data lab1;

	* this gets the number of days from 1950 till their birthday;
	
	joe = mdy(03, 15, 13);
	
	mitch = mdy(01, 15, 10);
	
	scott = mdy(11, 25, 06);
	
	* this gets today dates in days since 1950;
	
	today = today();
	
	* this gets their ages in years;

	joesage =yrdif(joe, today, 'ACT/360');
	
	mitchsage =yrdif(mitch, today, 'ACT/360');
	
	scottsage =yrdif(scott, today, 'ACT/360');
	
	* this gets their 16th birthday;

	joe16b = mdy( 03, 15, 29);
	
	mitch16b = mdy( 01, 15, 26);
	
	scott16b = mdy( 11, 25, 22);
	
	* this gets their 18th birthday;

	joe18b = mdy( 03, 15, 31);
	
	mitch18b = mdy( 01, 15, 28);
	
	scott18b = mdy( 11, 25, 24);
	
	* this gets years till 16;

	joe16 =yrdif(today, joe16b, 'AGE');
	
	mitch16 =yrdif(today, mitch16b, 'AGE');
	
	scott16 =yrdif(today, scott16b, 'AGE');
	
	* this gets years till 18;

	joe18 =yrdif(today, joe18b, 'AGE');
	
	mitch18 =yrdif(today, mitch18b, 'AGE');
	
	scott18 =yrdif(today, scott18b, 'AGE');
	
	* this gets the total investment of car;
	
	joecar = 600*((1.02)**(joe16)) + 600*((((1.02)**(joe16)) - 1) / .02);
	
	mitchcar = 600*((1.02)**(mitch16)) + 600*((((1.02)**(mitch16)) - 1) / .02);
	
	scottcar = 600*((1.02)**(scott16)) + 600*((((1.02)**(scott16)) - 1) / .02);
	
	* this gets the total investment of college;
	
	joecollege = 12000*((1.03)**(joe18)) + 10000*((((1.03)**(joe18)) - 1) / .03);

	mitchcollege = 12000*((1.03)**(mitch18)) + 10000*((((1.03)**(mitch18)) - 1) / .03);
	
	scottcollege = 12000*((1.03)**(scott18)) + 10000*((((1.03)**(scott18)) - 1) / .03);
	
	* this tells them the good or bad news for car;

	if joecar >= 10000 then joecarnews = "Good News";
	
	else joecarnews = "Bad News";
	
	if mitchcar >= 10000 then mitchcarnews = "Good News";
	
	else mitchcarnews = "Bad News";
	
	if scottcar >= 10000 then scottcarnews = "Good News";
	
	else scottcarnews = "Bad News";
	
	* this tells them the good or bad news for college;

	if joecollege >= 100000 then joecollegenews = "Good News";
	
	else joecollegenews = "Bad News";
	
	if mitchcollege >= 100000 then mitchcollegenews = "Good News";
	
	else mitchcollegenews = "Bad News";
	
	if scottcollege >= 100000 then scottcollegenews = "Good News";
	
	else scottcollegenews = "Bad News";
	
	
	
	
	
	
	
	
	run;
	
proc print data = lab1;
run;
	
	

IMPORT std;
IMPORT getCodes, getCovidDS, getFlightsDS from dataset;

// country and date range to inspect
country_name := 'United States of America';
min_date := '20200601';
max_date := '20200630';
country_code := getCodes.codes(name=country_name)[1].alpha_2;

// split data into subsets for easier processing
flights2019Subset := getFlightsDS.flights2019_DS(
	(ArriveCountryCode=country_code OR DepartCountryCode=country_code)
	AND EffectiveDate BETWEEN min_date and max_date
);

flights2020Subset := getFlightsDS.flights2020_DS(
	(ArriveCountryCode=country_code OR DepartCountryCode=country_code)
	AND EffectiveDate BETWEEN min_date and max_date
);

// count number of flights that arrived to the country
num_arrive := SUM(COUNT(flights2019Subset(
	ArriveCountryCode=country_code
))) + SUM(COUNT(flights2020Subset(
	ArriveCountryCode=country_code
)));

// count number of flights that departed from the country
num_depart := SUM(COUNT(flights2019Subset(
	DepartCountryCode=country_code
))) + SUM(COUNT(flights2020Subset(
	DepartCountryCode=country_code
)));

// US is listed in covid dataset as US instead of United States of America
covidSubset := getCovidDS.covid_DS(
	country=STD.Str.ToUpperCase(country_name)
	OR country=country_code
);

// calculate number of cases in the month by the difference of the start
// data and end data
covidStart := covidSubset(update_date=min_date);
covidEnd := covidSubset(update_date=max_date);

err1 := IF (SUM(COUNT(covidStart))=0, ERROR('Start date not in dataset.'), 1);
ASSERT(err1=1);
err2 := IF (SUM(COUNT(covidEnd))=0, ERROR('End date not in dataset.'), 1);
ASSERT(err2=1);

covidStartTable := TABLE(
	covidStart,
	{
		STRING	  country 		:= country_name,
		STRING	  country_code	:= country_code,
		UNSIGNED4 num_confirmed := SUM(GROUP, confirmed),
		UNSIGNED4 num_deaths 	:= SUM(GROUP, deaths),
		UNSIGNED4 num_recovered := SUM(GROUP, recovered),
		UNSIGNED4 num_active 	:= SUM(GROUP, active),
	}
);

covidEndTable := TABLE(
	covidEnd,
	{
		STRING	  country 		:= country_name,
		STRING	  country_code	:= country_code,
		UNSIGNED4 num_confirmed := SUM(GROUP, confirmed),
		UNSIGNED4 num_deaths 	:= SUM(GROUP, deaths),
		UNSIGNED4 num_recovered := SUM(GROUP, recovered),
		UNSIGNED4 num_active 	:= SUM(GROUP, active),
	}
);

total_confirmed := covidEndTable[1].num_confirmed 
	- covidStartTable[1].num_confirmed;
total_deaths 	:= covidEndTable[1].num_deaths 
	- covidStartTable[1].num_deaths;
total_recovered := covidEndTable[1].num_recovered 
	- covidStartTable[1].num_recovered;
total_active 	:= covidEndTable[1].num_active 
	- covidStartTable[1].num_active;

covidTable := DEDUP(TABLE(
	covidSubset,
	{
		STRING	  country 		:= country_name,
		STRING	  country_code	:= country_code,
		STRING	  start_date 	:= min_date;
		STRING	  end_date		:= max_date;
		UNSIGNED4 num_confirmed := total_confirmed,
		UNSIGNED4 num_deaths 	:= total_deaths,
		UNSIGNED4 num_recovered := total_recovered,
		UNSIGNED4 num_active 	:= total_active,
		UNSIGNED4 num_arrive	:= num_arrive,
		UNSIGNED4 num_depart	:= num_depart,
	}
));

result := covidTable;

OUTPUT(
    CHOOSEN(result, 100),
    NAMED('output'));
	
OUTPUT(
    CHOOSEN(covidStartTable, 10),
    NAMED('covid_start'));

OUTPUT(
    CHOOSEN(covidEndTable, 10),
    NAMED('covid_end'));

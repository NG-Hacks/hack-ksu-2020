IMPORT std;
IMPORT getCodes, getCovidDS, getFlightsDS FROM dataset;
IMPORT resultRecMod FROM dataset.rec;

EXPORT buildTableMod := MODULE
	
	UNSIGNED4 difference (UNSIGNED4 a, UNSIGNED4 b) := FUNCTION
		// if either of the numbers is zero, return zero.
		// else, return the difference
		RETURN IF((a=b AND a=0), 0, a-b);
	END;

	EXPORT resultRecMod.resultRec buildTable (
		STRING country_name,
		STRING min_date,
		STRING max_date) := FUNCTION

		country_code := getCodes.codes(name=country_name)[1].alpha_2;

		// split data into subsets for easier processing
		flights2019Subset := getFlightsDS.flights2019_DS(
			(ArriveCountryCode=country_code OR DepartCountryCode=country_code)
			AND EffectiveDate BETWEEN min_date AND max_date
		);

		flights2020Subset := getFlightsDS.flights2020_DS(
			(ArriveCountryCode=country_code OR DepartCountryCode=country_code)
			AND EffectiveDate BETWEEN min_date AND max_date
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

		err1 := IF(SUM(COUNT(covidStart))=0, ERROR('Start date not in dataset.'), 1);
		err2 := IF(SUM(COUNT(covidEnd))=0, ERROR('End date not in dataset.'), 1);

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

		total_confirmed := difference(covidEndTable[1].num_confirmed, covidStartTable[1].num_confirmed);
		total_deaths 	:= difference(covidEndTable[1].num_deaths, covidStartTable[1].num_deaths);
		total_recovered := difference(covidEndTable[1].num_recovered, covidStartTable[1].num_recovered);
		total_active 	:= difference(covidEndTable[1].num_active, covidStartTable[1].num_active);

		res := DATASET(
				[{
					country_name, country_code, min_date, max_date, total_confirmed,
					total_deaths, total_recovered, total_active, num_arrive, num_depart
				}],
				resultRecMod.resultRec
			);

		RETURN res;
	END;
END;
IMPORT std;
IMPORT getCovidDS FROM dataset;
IMPORT casesRecMod FROM funcs.rec;

EXPORT covidCasesMod := MODULE

	UNSIGNED4 difference (UNSIGNED4 a, UNSIGNED4 b) := FUNCTION
		// if either of the numbers is zero, return zero.
		// else, return the difference
		RETURN IF((a=0 OR b=0), 0, a-b);
	END;
    	
    EXPORT casesRecMod.casesRec covidCases (
		STRING country_name,
		STRING country_code,
		UNSIGNED4 min_date,
		UNSIGNED4 max_date) := FUNCTION

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

		startTable := TABLE(
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

		endTable := TABLE(
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

		total_confirmed := difference(endTable[1].num_confirmed, startTable[1].num_confirmed);
		total_deaths 	:= difference(endTable[1].num_deaths, startTable[1].num_deaths);
		total_recovered := difference(endTable[1].num_recovered, startTable[1].num_recovered);
		total_active 	:= difference(endTable[1].num_active, startTable[1].num_active);

		res := DATASET(
            [{
                total_confirmed, total_deaths, total_recovered, total_active
            }],
            casesRecMod.casesRec
        );

		RETURN res;
	END;
END;
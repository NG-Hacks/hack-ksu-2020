IMPORT std;
IMPORT getCodes FROM dataset;
IMPORT effectiveFlightsMod, discontinuedFlightsMod, covidCasesMod FROM funcs;
IMPORT resultRecMod FROM funcs.rec;

EXPORT resultMod := MODULE
    EXPORT resultRecMod.resultRec effectiveFlights(
		STRING country_name,
		UNSIGNED4 min_date,
		UNSIGNED4 max_date) := FUNCTION

        country_code := getCodes.codes(name=country_name)[1].alpha_2;
        effective_flights := effectiveFlightsMod.effectiveFlights(
            country_name, min_date, max_date);
        covid_cases := covidCasesMod.covidCases(
            country_name, min_date, max_date);

        res := DATASET(
            [{
                country_name,
                country_code,
                min_date,
                max_date, 
                covid_cases[1].total_confirmed,
                covid_cases[1].total_deaths,
                covid_cases[1].total_recovered,
                covid_cases[1].total_active,
                effective_flights[1].num_arrive,
                effective_flights[1].num_depart
            }],
            resultRecMod.resultRec
        );

        RETURN res;
    END;

    EXPORT resultRecMod.resultRec discontinuedFlights(
		STRING country_name,
		UNSIGNED4 min_date,
		UNSIGNED4 max_date) := FUNCTION

        country_code := getCodes.codes(name=country_name)[1].alpha_2;
        discontinued_flights := discontinuedFlightsMod.discontinuedFlights(
            country_name, min_date, max_date);
        covid_cases := covidCasesMod.covidCases(
            country_name, min_date, max_date);

        res := DATASET(
            [{
                country_name,
                country_code,
                min_date,
                max_date, 
                covid_cases[1].total_confirmed,
                covid_cases[1].total_deaths,
                covid_cases[1].total_recovered,
                covid_cases[1].total_active,
                discontinued_flights[1].num_arrive,
                discontinued_flights[1].num_depart
            }],
            resultRecMod.resultRec
        );

        RETURN res;
    END;
END;
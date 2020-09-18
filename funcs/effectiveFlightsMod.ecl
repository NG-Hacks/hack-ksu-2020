IMPORT std;
IMPORT getCodes, getCovidDS, getFlightsDS FROM dataset;
IMPORT numFlightsRecMod FROM funcs.rec;

EXPORT effectiveFlightsMod := MODULE
	EXPORT numFlightsRecMod.numFlightsRec effectiveFlights (
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

		res := DATASET(
			[{
				num_arrive, num_depart
			}],
			numFlightsRecMod.numFlightsRec
		);

		RETURN res;
	END;
END;
IMPORT std;
IMPORT getCovidDS, getFlightsDS FROM dataset;
IMPORT numFlightsRecMod FROM funcs.rec;

EXPORT discontinuedFlightsMod := MODULE
	EXPORT numFlightsRecMod.numFlightsRec discontinuedFlights (
		STRING country_name,
		STRING country_code,
		UNSIGNED4 min_date,
		UNSIGNED4 max_date) := FUNCTION

		// split data into subsets for easier processing
		flights2019Subset := getFlightsDS.flights2019_DS(
			(ArriveCountryCode=country_code OR DepartCountryCode=country_code)
			AND DiscontinueDate BETWEEN min_date AND max_date
		);

		flights2020Subset := getFlightsDS.flights2020_DS(
			(ArriveCountryCode=country_code OR DepartCountryCode=country_code)
			AND DiscontinueDate BETWEEN min_date AND max_date
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
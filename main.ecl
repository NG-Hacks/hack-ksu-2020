IMPORT std;
IMPORT getCodes, getCovidDS, getFlightsDS from dataset;

country := 'Afghanistan';
country_code := getCodes.codes(name=country)[1].alpha_2;

flightsSubset := getFlightsDS.flights2019_DS;

covidTable := TABLE(
	getCovidDS.covid_DS,
	{
		country,
		update_date,
	}
);

result := getCodes.codes;

OUTPUT(
    country_code,
    NAMED('output'));
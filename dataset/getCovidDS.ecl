IMPORT STD;
IMPORT covidRecMod from dataset.rec;

EXPORT getCovidDS := MODULE
	country_name := 'United States of America';
	country_code := 'US';
	EXPORT covid_DS := DATASET(
		'~hpccsystems::ksuhackathon::jhu_covid19.csv',
		covidRecMod.covidRec,
		CSV(HEADING(1)))(country=STD.Str.ToUpperCase(country_name)
			OR country=country_code);
END;
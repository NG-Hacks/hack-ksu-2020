IMPORT STD;
IMPORT covidRecMod from dataset.rec;

EXPORT getCovidDS := MODULE
	EXPORT covid_DS := DATASET(
		'~hpccsystems::ksuhackathon::jhu_covid19.csv',
		covidRecMod.covidRec,
		CSV(HEADING(1)));
END;
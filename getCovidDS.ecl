IMPORT covidRecMod;

EXPORT getCovidDS := MODULE

  EXPORT covid_DS := DATASET(
                               '~hpccsystems::ksuhackathon::jhu_covid19.csv',
                               covidRecMod.covidRec,
	                             CSV);
END;
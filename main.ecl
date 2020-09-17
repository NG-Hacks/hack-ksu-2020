IMPORT std;
IMPORT getCovidDS;

result := SORT(
        getCovidDS.covid_DS, update_date
        );

OUTPUT(
    CHOOSEN(result, 100),
    NAMED('country_codes'));
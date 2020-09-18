IMPORT std;
IMPORT resultMod FROM funcs;

// country and date range to inspect
country_name := 'United States of America';
min_date := '20200601';
max_date := '20200630';

t1 := resultMod.effectiveFlights(country_name, min_date, max_date);

OUTPUT(
    t1,
    NAMED('output'));

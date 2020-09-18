IMPORT std;
IMPORT resultMod FROM funcs;
IMPORT datesMod FROM funcs.dates;

// country and date range to inspect
country_name := 'United States of America';
min_date := 20200601;
max_date := datesMod.endMonth(min_date);
min_2 := datesMod.oneMonth(min_date);
max_2 := datesMod.endMonth(min_2);

t1 := resultMod.effectiveFlights(country_name, min_date, max_date);
t2 := resultMod.effectiveFlights(country_name, min_2, max_2);
res := t1+t2;

OUTPUT(
    res,
    NAMED('output'));

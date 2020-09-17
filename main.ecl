IMPORT buildTableMod FROM funcs;

// country and date range to inspect
country_name := 'United States of America';
min_date := '20200601';
max_date := '20200630';

OUTPUT(
    CHOOSEN(buildTableMod.buildTable(country_name, min_date, max_date), 100),
    NAMED('output'));

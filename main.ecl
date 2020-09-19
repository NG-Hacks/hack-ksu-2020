#OPTION('outputlimit', 100);
IMPORT std;
IMPORT getFlightsDS, getDates, getCodes FROM dataset;
IMPORT datesRecMod FROM dataset.rec;
IMPORT resultMod FROM funcs;
IMPORT resultRecMod from funcs.rec;
IMPORT datesMod FROM funcs.dates;

// country and date range to inspect
country := 'China';
country_code := getCodes.codes(name=country)[1].alpha_2;
dates := getDates.dates(start_date > 0 AND end_date > 0);

myrec := RECORD
    datesRecMod.datesRec;
    resultRecMod.resultRec;
END;

myrec xform (datesRecMod.datesRec Le) := TRANSFORM
    SELF.start_date := Le.start_date;
    SELF.end_date := Le.end_date;
    r := resultMod.effectiveFlights(
        country,
        Le.start_date,
        Le.end_date)[1];
    SELF.country := r.country;
    SELF.country_code := r.country_code;
    SELF.num_confirmed := r.num_confirmed;
    SELF.num_deaths := r.num_deaths;
    SELF.num_recovered := r.num_recovered;
    SELF.num_active := r.num_active;
    SELF.num_arrive := r.num_arrive;
    SELF.num_depart := r.num_depart;
END;

mydata := PROJECT(
    dates,
    xform(LEFT),
    PARALLEL
);

OUTPUT(
    mydata,,
    '~ngardn10::project::'+country_code,
    THOR,
    EXPIRE(20),
    OVERWRITE);

IMPORT std;
IMPORT getFlightsDS, getDates FROM dataset;
IMPORT datesRecMod FROM dataset.rec;
IMPORT resultMod FROM funcs;
IMPORT resultRecMod from funcs.rec;
IMPORT datesMod FROM funcs.dates;

// country and date range to inspect
country := 'United States of America';
dates := getDates.dates(start_date > 0 AND end_date > 0);

myrec := RECORD
    resultRecMod.resultRec r;
END;

// myrec := RECORD
//     datesRecMod.datesRec;
//     resultRecMod.resultRec;
// END;

// myrec xform (datesRecMod.datesRec Le) := TRANSFORM
//     SELF.start_date := Le.start_date;
//     SELF.end_date := Le.end_date;
//     r := resultMod.effectiveFlights(
//         country,
//         Le.start_date,
//         Le.end_date)[1];
//     SELF.country := r.country;
//     SELF.country_code := r.country_code;
//     SELF.num_confirmed := r.num_confirmed;
//     SELF.num_deaths := r.num_deaths;
//     SELF.num_recovered := r.num_recovered;
//     SELF.num_active := r.num_active;
//     SELF.num_arrive := r.num_arrive;
//     SELF.num_depart := r.num_depart;
// END;

// mydata := PROJECT(
//     dates,
//     xform(LEFT)
// );

t1 := resultMod.effectiveFlights(
        country,
        getDates.dates[1].start_date,
        getDates.dates[1].end_date)[1];

t2 := resultMod.effectiveFlights(
        country,
        getDates.dates[2].start_date,
        getDates.dates[2].end_date)[1];

t3 := resultMod.effectiveFlights(
        country,
        getDates.dates[3].start_date,
        getDates.dates[3].end_date)[1];

t4 := resultMod.effectiveFlights(
        country,
        getDates.dates[4].start_date,
        getDates.dates[4].end_date)[1];

t5 := resultMod.effectiveFlights(
        country,
        getDates.dates[5].start_date,
        getDates.dates[5].end_date)[1];

t6 := resultMod.effectiveFlights(
        country,
        getDates.dates[6].start_date,
        getDates.dates[6].end_date)[1];

t7 := resultMod.effectiveFlights(
        country,
        getDates.dates[7].start_date,
        getDates.dates[7].end_date)[1];

t8 := resultMod.effectiveFlights(
        country,
        getDates.dates[8].start_date,
        getDates.dates[8].end_date)[1];

t9 := resultMod.effectiveFlights(
        country,
        getDates.dates[9].start_date,
        getDates.dates[9].end_date)[1];

t10 := resultMod.effectiveFlights(
        country,
        getDates.dates[10].start_date,
        getDates.dates[10].end_date)[1];

t11 := resultMod.effectiveFlights(
        country,
        getDates.dates[11].start_date,
        getDates.dates[11].end_date)[1];

t12 := resultMod.effectiveFlights(
        country,
        getDates.dates[12].start_date,
        getDates.dates[12].end_date)[1];

t13 := resultMod.effectiveFlights(
        country,
        getDates.dates[13].start_date,
        getDates.dates[13].end_date)[1];

t14 := resultMod.effectiveFlights(
        country,
        getDates.dates[14].start_date,
        getDates.dates[14].end_date)[1];

t15 := resultMod.effectiveFlights(
        country,
        getDates.dates[15].start_date,
        getDates.dates[15].end_date)[1];

t16 := resultMod.effectiveFlights(
        country,
        getDates.dates[16].start_date,
        getDates.dates[16].end_date)[1];

t17 := resultMod.effectiveFlights(
        country,
        getDates.dates[17].start_date,
        getDates.dates[17].end_date)[1];

t18 := resultMod.effectiveFlights(
        country,
        getDates.dates[18].start_date,
        getDates.dates[18].end_date)[1];

t19 := resultMod.effectiveFlights(
        country,
        getDates.dates[19].start_date,
        getDates.dates[19].end_date)[1];

t20 := resultMod.effectiveFlights(
        country,
        getDates.dates[20].start_date,
        getDates.dates[20].end_date)[1];

t21 := resultMod.effectiveFlights(
        country,
        getDates.dates[21].start_date,
        getDates.dates[21].end_date)[1];

t22 := resultMod.effectiveFlights(
        country,
        getDates.dates[22].start_date,
        getDates.dates[22].end_date)[1];

t23 := resultMod.effectiveFlights(
        country,
        getDates.dates[23].start_date,
        getDates.dates[23].end_date)[1];

t24 := resultMod.effectiveFlights(
        country,
        getDates.dates[24].start_date,
        getDates.dates[24].end_date)[1];

t25 := resultMod.effectiveFlights(
        country,
        getDates.dates[25].start_date,
        getDates.dates[25].end_date)[1];

t26 := resultMod.effectiveFlights(
        country,
        getDates.dates[26].start_date,
        getDates.dates[26].end_date)[1];

t27 := resultMod.effectiveFlights(
        country,
        getDates.dates[27].start_date,
        getDates.dates[27].end_date)[1];

t28 := resultMod.effectiveFlights(
        country,
        getDates.dates[28].start_date,
        getDates.dates[28].end_date)[1];
                                                          
tb := DATASET([
    {t1}, {t2}, {t3}, {t4}, {t5}, {t6}, 
    {t7}, {t8}, {t9}, {t10}, {t11}, {t12},
    {t13}, {t14}, {t15}, {t16}, {t17}, {t18},
    {t19}, {t20}, {t21}, {t22}, {t23}, {t24},
    {t25}, {t26}, {t27}, {t28} ], myrec);

OUTPUT(
    tb,
    NAMED('output'));

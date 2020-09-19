IMPORT STD;
IMPORT covidRecMod from dataset.rec;
IMPORT covidCasesMod, resultMod FROM funcs;
IMPORT casesRecMod FROM funcs.rec;
IMPORT getCodes, getCovidDS FROM dataset;
IMPORT datesMod FROM funcs.dates;

EXPORT covidCases := MODULE
    EXPORT INTEGER testCountry (STRING country_name) := FUNCTION
        country_code := getCodes.codes(name=country_name)[1].alpha_2;
        start_date := 20200401;
        end_date := datesMod.endMonth(start_date);

        res := covidCasesMod.covidCases(country_name, country_code, start_date, end_date)[1];

        RETURN IF(res.total_confirmed!=0, 0, 1);
    END;

    EXPORT INTEGER testChina () := FUNCTION
        country_name := 'China';
        country_code := getCodes.codes(name=country_name)[1].alpha_2;
        start_date := 20200401;
        end_date := datesMod.endMonth(start_date);

        res := covidCasesMod.covidCases(country_name, country_code, start_date, end_date)[1];

        RETURN IF(res.total_confirmed=1595, 0, 1);
    END;

    EXPORT INTEGER testUS () := FUNCTION
        country_name := 'United States of America';
        country_code := getCodes.codes(name=country_name)[1].alpha_2;
        start_date := 20200401;
        end_date := datesMod.endMonth(start_date);

        res := covidCasesMod.covidCases(country_name, country_code, start_date, end_date)[1];

        RETURN IF(res.total_confirmed=856052, 0, 1);
    END;

    EXPORT INTEGER testMexico () := FUNCTION
        country_name := 'Mexico';
        country_code := getCodes.codes(name=country_name)[1].alpha_2;
        start_date := 20200401;
        end_date := datesMod.endMonth(start_date);

        res := covidCasesMod.covidCases(country_name, country_code, start_date, end_date)[1];
        RETURN SUM(
            IF(res.total_confirmed=18009, 0, 1),
            IF(res.total_deaths=1830, 0, 1),
            IF(res.total_recovered=11388, 0, 1),
            IF(res.total_active=4791, 0, 1)
        );
    END;
END;
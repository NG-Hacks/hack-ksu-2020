EXPORT resultRecMod := MODULE
    EXPORT resultRec := RECORD
        STRING	  country,
        STRING	  country_code,
        STRING	  start_date,
        STRING	  end_date,
        UNSIGNED4 num_confirmed,
        UNSIGNED4 num_deaths,
        UNSIGNED4 num_recovered,
        UNSIGNED4 num_active,
        UNSIGNED4 num_arrive,
        UNSIGNED4 num_depart,
    END;
END; 
EXPORT casesRecMod := MODULE
    EXPORT casesRec := RECORD
        UNSIGNED4   total_confirmed;
        UNSIGNED4   total_deaths;
        UNSIGNED4   total_recovered;
        UNSIGNED4   total_active;
    END;
END;
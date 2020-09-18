//Modules are not executable, please don't try to run them.
//For to how to run a module please check view2019Flights.
EXPORT datesRecMod := MODULE
    //Creat covid record layout
    EXPORT datesRec := RECORD
        UNSIGNED4   start_date;
      	UNSIGNED4   end_date;
    END;
END;

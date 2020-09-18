//Modules are not executable, please don't try to run them.
//For to how to run a module please check view2019Flights.
EXPORT covidRecMod := MODULE
    //Creat covid record layout
    EXPORT covidRec := RECORD
      	VARSTRING		fips;
      	VARSTRING		admin;
      	VARSTRING 		state;
      	VARSTRING		country;
      	UNSIGNED4		update_date;
      	UNSIGNED		geo_lat;
      	UNSIGNED		geo_long;
      	INTEGER			confirmed;
      	INTEGER			deaths;
      	INTEGER			recovered;
      	INTEGER			active;
      	VARSTRING		combined_key;
    END;
END;

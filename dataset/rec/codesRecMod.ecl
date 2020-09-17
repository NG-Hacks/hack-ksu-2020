EXPORT codesRecMod := MODULE
    //Creat covid record layout
    EXPORT codesRec := RECORD
      	VARSTRING		name;
      	VARSTRING		alpha_2;
      	VARSTRING 	    alpha_3;
      	VARSTRING		country_code;
      	VARSTRING		iso_31662;
      	VARSTRING		region;
      	VARSTRING		sub_region;
      	VARSTRING		intermediate_region;
      	VARSTRING		region_code;
      	VARSTRING		sub_region_code;
      	VARSTRING		intermediate_region_code;
    END;
END;
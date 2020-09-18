IMPORT datesRecMod from dataset.rec;

EXPORT getDates := MODULE
	EXPORT dates := DATASET(
		'~ngardn10::flights_workshop::daterangemonth.csv',
		datesRecMod.datesRec,
		CSV(HEADING(1)));
END;
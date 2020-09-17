IMPORT codesRecMod from dataset.rec;

EXPORT getCodes := MODULE
	EXPORT codes := DATASET(
		'~ngardn10::flights_workshop::all.csv',
		codesRecMod.codesRec,
		CSV(HEADING(1)));
END;
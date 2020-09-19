IMPORT covidCases from tests;

ASSERT(covidCases.testUS()     = 0);
ASSERT(covidCases.testChina()  = 0);
ASSERT(covidCases.testMexico() = 0);

ASSERT(covidCases.testCountry('Canada') = 0);
ASSERT(covidCases.testCountry('Spain')  = 0);
ASSERT(covidCases.testCountry('Italy')  = 0);
ASSERT(covidCases.testCountry('Greece') = 0);

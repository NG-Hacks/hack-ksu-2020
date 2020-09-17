
# packages
import numpy as np
import pandas as pd


def Union(lst1, lst2):
    final_list = list(set(lst1) | set(lst2))
    return final_list


def load_df(path: str):
    '''
        Inputs:
            path: path to the file to load into dataframe
    '''
    df = pd.DataFrame()
    for chunk in pd.read_csv(path, chunksize=1000):
        df = pd.concat([df, chunk], ignore_index=True)
    return df


# load datasets
base_path = "./data"
flights_2019_df = load_df(f'{base_path}/2019_GSEC.csv')
flights_2020_df = load_df(f'{base_path}/2020_GSEC.csv')
covid_df = pd.read_csv(f'{base_path}/JHU_Covid19.csv')
iata_country_codes_df = pd.read_csv(f'{base_path}/all.csv')

print(covid_df.info)
covid_df.drop(columns=[
    'fips',
    'admin2',
    'state',
    'combined_key',
    'geo_lat',
    'geo_long'], inplace=True)
covid_df['country'] = covid_df['country'].str.rstrip()
print(covid_df.head())

flights_2019_df.sort_values(by=['effectivedate'], inplace=True)
flights_2020_df.sort_values(by=['effectivedate'], inplace=True)
print(flights_2019_df.info())
print(flights_2020_df.info())

fl_2019_coun_list = list(flights_2019_df['departcountrycode'].unique())
fl_2020_coun_list = list(flights_2020_df['departcountrycode'].unique())
fl_coun_list = Union(fl_2019_coun_list, fl_2020_coun_list)
fl_coun_list.pop(0)
print(len(fl_coun_list))


iata_country_codes_df = iata_country_codes_df[['name', 'alpha-2']]
iata_country_codes_df.rename(
    columns={
        "name": "Country",
        "alpha-2": "CountryCode"}, inplace=True)
iata_country_codes_df['Country'] = iata_country_codes_df['Country'].str.lower()
print(iata_country_codes_df['Country'].head())

cc_dict = dict(zip(
    iata_country_codes_df.Country,
    iata_country_codes_df.CountryCode))
covid_df['country'] = covid_df['country'].str.lower()
covid_df['CountryCode'] = covid_df['country'].map(cc_dict)

covid_df.sort_values(by=['update_date'], inplace=True)
covid_df.reset_index(drop=True, inplace=True)
indexNames = []
for i, x in enumerate(covid_df['CountryCode']):
    if not(x in fl_coun_list):
        print('Country not in flights list: ', x)
        indexNames.append(i)

#print(flights_2019_df.head(10))
flights_2019_df['eff_dis_date_range'] = flights_2019_df['discontinuedate'] - flights_2019_df['effectivedate']

* the main tabula file for cca_managedonly, cca_owned_managed and cca_leased had all three combined together. Cut out the three sections into their own csv-s for easier cleaning. Also stripped random headings like facility name etc manually because there were only a few handful.
    - for cca_leased I appended toprow+bottomrow for two 'years' from 'term' just because these were the only two rows that broke the clean script. The rows were F1 and F16.
* in cca_leased.csv I added an empty row between A2 and A3 to make my code simpler (to be able to count count+=3)

* for cca_owned_managed i combined B58 and B59 into B57 just because this was the only glitchy anomaly. i then deleted the rows.
* headers were removed for clarity. I should make arrangements of keeping them and cleaning them instead.

* turned New Mexico Womenâ€™s Correctional  into New Mexico Womens Correctional because this one thing was bugging up my code
* got rid of a '.' from D Ray James Correctional Facility and Robert A Deyton Detention Facility from the abbreviations to make it easier for me to code
* got rid of the header in geo_city.csv and geo_state.csv to make life easier. The first said CITY and the second said STATE
* 

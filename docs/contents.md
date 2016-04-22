* import.sh imports from raw/ and dumps in processed/ import.sh also runs clean.py
* requests is the the main table
* cities/ contains detailed breakdown .md of all the cities we found relevant.
    - lists the det_facility, lift_reason and count for each of the facilities in the city
    - list the count by year as well
* views listed in summarize.sh
    - declined_requests_per_facility
    - total_requests_per_facility
    - percent_declined_per_facility
    - byyear where lift_reason = 'Detainer Declined by LEA'
    - everything_but_declined which is linked to declined_vs_everythingelse.csv

* americans.sh
    - both view and table
      - americans
      - americans_by_city
      - americans_by_state
      - americans_by_year
      - residents
      - residents_by_city
      - residents_by_state
      - residents_by_year

* unique_facilities is drawn upon by facility_breakdown.sh

* declines_per_year.sh finds out the number declined as a percentage of the total

* 

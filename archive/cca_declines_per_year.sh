#!/bin/bash
CCAFACILITIES=("STEWART DETENTION CENTER" "LAREDO PROCESSING CENTER" "MARION COUNTY JAIL" "WHITEVILLE CORRECTIONAL FACILITY" "MCRAE CORRECTIONAL FACILITY, CCA" "LAKE ERIE CORRECTIONAL" "ADAMS COUNTY" "CCA, FLORENCE CORRECTIONAL CENTER" "HARDEMAN COUNTY JAIL" "LEAVENWORTH USP" "PRAIRIE CORRECT. FACILITY" "HUERFANO COUNTY JAIL" "EL PASO SPC" "KIT CARSON COUNTY" "SOUTH CENTRAL CORR.FAC." "NORTHEAST CORR CENTER" "DIAMONDBACK CORR FACILITY" "MARION USP" "CORPUS CHRISTI FACILITY" "CROWLEY COUNTY JAIL" "BENT COUNTY JAIL")

for facility in "${CCAFACILITIES[@]}"
do
echo ${facility}

psql sanctuary -c "create or replace view declined_requests_by_facility as
select to_char(date, 'YYYY') as year, det_facility, city, state, count(*)
from requests
where lift_reason = 'Detainer Declined by LEA'
and det_facility = '$facility'
group by year, det_facility, city, state;"

psql sanctuary -c "create or replace view total_requests_by_facility as
select to_char(date, 'YYYY') as year, det_facility, city, state, count(*)
from requests
where det_facility = '$facility'
and lift_reason is not null
group by year, det_facility, city, state;"

psql sanctuary -c "select a.year, (a.count::float / b.count::float) * 100 as percent_declined from declined_requests_by_facility as a inner join total_requests_by_facility as b on (a.year = b.year) order by year;"
done

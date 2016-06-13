#!/bin/bash
GEOFACILITIES=("ARIZONA STATE PRISON-KINGMAN" "ARIZONA STATE PRISON-PHOENIX WEST" "SOUTH TEXAS DETENTION COMPLEX" "EAST HIDALGO DETENTION CENTER" "BROWARD TRANSITIONAL CENTER" "RIVERS CORRECTIONAL INSTITUTION" "PINE PRAIRIE CORRECTIONAL CENTER" "RIO GRANDE DETENTION CENTER" "GRACEVILLE CORRECTIONAL FACILITY" "SOUTH BAY CORRECTIONAL FACILITY" "MOSHANNON VALLEY CORRECTIONAL" "GREAT PLAINS CORRECTIONAL" "BALDWIN PARK POLICE DEPT." "GARDEN GROVE POLICE DEPT." "MONTEBELLO POLICE DEPT." "ONTARIO COUNTY JAIL" "LAWTON CORRECTIONAL FAC." "DESERT VIEW" "ALLEN CORRECTION CENTER" "MCFARLAND CCF" "MESA VERDE CCF" "GUADALUPE CTY JAIL" "REEVES COUNTY JAIL" "JOE CORLEY DET. FACILITY" "LEA COUNTY JAIL" "BLACKWATER RIVER CORR. FAC.")

for facility in "${GEOFACILITIES[@]}"
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

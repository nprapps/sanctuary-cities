#!/bin/bash
MTCFACILITIES=("NORTH CENTRAL CORR." "OTERO CO PROCESSING CENTER" "ARIZONA STATE PRISON COMP")

for facility in "${MTCFACILITIES[@]}"
do
echo ${facility}
psql sanctuary -c "select det_facility, lift_reason, count(*) from requests where det_facility = '${facility}' and lift_reason is not null group by lift_reason, det_facility order by count desc;"
done

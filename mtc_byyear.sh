#!/bin/bash
MTCFACILITIES=("NORTH CENTRAL CORR." "OTERO CO PROCESSING CENTER" "ARIZONA STATE PRISON COMP")

for facility in "${MTCFACILITIES[@]}"
do
echo ${facility}
psql sanctuary -c "select year, det_facility, count(*) from byyear where det_facility = '${facility}' group by year, det_facility order by count desc;"
done

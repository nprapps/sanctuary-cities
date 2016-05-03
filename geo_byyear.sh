#!/bin/bash
GEOFACILITIES=("ARIZONA STATE PRISON-KINGMAN" "ARIZONA STATE PRISON-PHOENIX WEST" "SOUTH TEXAS DETENTION COMPLEX" "EAST HIDALGO DETENTION CENTER" "BROWARD TRANSITIONAL CENTER" "RIVERS CORRECTIONAL INSTITUTION" "PINE PRAIRIE CORRECTIONAL CENTER" "RIO GRANDE DETENTION CENTER" "GRACEVILLE CORRECTIONAL FACILITY" "SOUTH BAY CORRECTIONAL FACILITY" "MOSHANNON VALLEY CORRECTIONAL" "GREAT PLAINS CORRECTIONAL" "BALDWIN PARK POLICE DEPT." "GARDEN GROVE POLICE DEPT." "MONTEBELLO POLICE DEPT." "ONTARIO COUNTY JAIL" "LAWTON CORRECTIONAL FAC." "DESERT VIEW" "ALLEN CORRECTION CENTER" "MCFARLAND CCF" "MESA VERDE CCF" "GUADALUPE CTY JAIL" "REEVES COUNTY JAIL" "JOE CORLEY DET. FACILITY" "LEA COUNTY JAIL" "BLACKWATER RIVER CORR. FAC.")

for facility in "${GEOFACILITIES[@]}"
do
echo ${facility}
psql sanctuary -c "select year, det_facility, count(*) from byyear where det_facility = '${facility}' group by year, det_facility order by count desc;"
done

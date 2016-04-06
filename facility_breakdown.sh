FACILITIES=("SANTA CLARA CO MAIN JAIL/" "SANTA CLARA COUNTY JAIL" "SNJ HOLD ROOM")

for facility in "${FACILITIES[@]}"
do
    echo ${facility}
    psql sanctuary -c "select det_facility, lift_reason, count(*) from requests where det_facility like '${facility}' and lift_reason is not null group by lift_reason, det_facility order by count desc;"
done

FACILITIES=("PACIFIC FURLOUGH FACILITY" "GEORGE BAILEY DETENT FACI" "GEO WESTERN REG. DET. FAC." "CORR.CORP.OF AMERICA - SAN DIEGO" "SAN DIEGO MCC" "S.D. COUNTY PROBATION" "CASA SAN JUAN" "SAN DIEGO COUNTY JAIL" "SAN DIEGO CENTRAL JAIL" "FACILITY 8 DETENTION FACILITY" "SAN DIEGO COUNTY JUV.HALL" "RJ DONOVAN CORREC FAC" "SND DISTRICT STAGING" "EAST MESA DETENT FACILITY")

for facility in "${FACILITIES[@]}"
do
    echo ${facility}
    psql sanctuary -c "select det_facility, lift_reason, count(*) from requests where det_facility = '${facility}' and lift_reason is not null group by lift_reason, det_facility order by count desc;"
done


FACILITIES=("CHICAGO MCC" "COOK COUNTY JAIL" "COOK COUNTY HOSPITAL" "CHICAGO HOLD ROOM" "US MARSHAL, N. DIST IL" "CATHOLIC CHARITIES, CHI" "TRAVELERS & IMMIGRANT AID" "HEARTLAND INTERNATIONAL YOUTH CTR")

for facility in "${FACILITIES[@]}"
do
    echo ${facility}
    psql sanctuary -c "select det_facility, lift_reason, count(*) from requests where det_facility like '${facility}' and lift_reason is not null group by lift_reason, det_facility order by count desc;"

done

FACILITIES=("US MARSHALS, COLORADO" "DENVER HOLD ROOM" "MONTE VIEW JUVENILE FACIL" "DGH WARD 18" "DENVER JUSTICE CENTER" "GILLIAM YOUTH CENTER" "DALHIA STREET YOUTH CENTE" "DENVER COUNTY JAIL" "REGAL 8 INN")

for facility in "${FACILITIES[@]}"
do
    echo ${facility}
    psql sanctuary -c "select det_facility, lift_reason, count(*) from requests where det_facility like '${facility}' and lift_reason is not null group by lift_reason, det_facility order by count desc;"
done

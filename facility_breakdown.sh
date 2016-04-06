#!/bin/bash
IFS=$'"'
arr=($(./unique_facilities.sh $1 $2))
unset IFS

for facility in "${arr[@]}"
do
    echo ${facility}
    psql sanctuary -c "select det_facility, lift_reason, count(*) from requests where det_facility like '${facility}' and lift_reason is not null group by lift_reason, det_facility order by count desc;"
done

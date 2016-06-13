#!/bin/bash
IFS=$'"'
arr=($(./unique_facilities.sh $1 $2))
unset IFS

for facility in "${arr[@]}"
do
    echo ${facility}
    psql sanctuary -c "COPY(select year, det_facility, lift_reason, count(*)
    from california
    where det_facility
    like '${facility}' and lift_reason is not null
    group by lift_reason, det_facility, year order by year, count desc)

    TO '`pwd`/export/california/$1.csv' DELIMITER ',' CSV HEADER;"
done

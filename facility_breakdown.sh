#!/bin/bash
IFS=$'"'
arr=($(./unique_facilities.sh $1 $2))
unset IFS

for facility in "${arr[@]}"
do
    if [[ ${facility} =~ .[a-z]*. ]]
    then
        echo ${facility}

        echo "Total reason counts"
        psql sanctuary -c "select det_facility, lift_reason, count(*)
        from requests
        where det_facility
        like '${facility}' and lift_reason is not null
        group by lift_reason, det_facility order by count desc;"

        echo "Percent declined per year"
        psql sanctuary -c "create or replace view declined_requests_by_facility as
            select extract(year from date) as year, det_facility, city, state, count(*)
            from requests
            where lift_reason = 'Detainer Declined by LEA'
            and det_facility = '${facility}'
            group by year, det_facility, city, state;
        create or replace view total_requests_by_facility as
            select extract(year from date) as year, det_facility, city, state, count(*)
            from requests
            where det_facility = '${facility}'
            and lift_reason is not null
            group by year, det_facility, city, state;
        select b.det_facility, b.year, coalesce(a.count, 0) as declined, b.count as total, coalesce((a.count::float / b.count::float) * 100, 0) as percent_declined from declined_requests_by_facility as a right outer join total_requests_by_facility as b on (a.year = b.year) order by year;"

        psql sanctuary -c "drop view declined_requests_by_facility;
        drop view total_requests_by_facility;"
    fi
done

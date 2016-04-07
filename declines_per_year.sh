psql sanctuary -c "create or replace view declined_requests_by_facility as
select to_char(date, 'YYYY') as year, det_facility, city, state, count(*)
from requests
where lift_reason = 'Detainer Declined by LEA'
and det_facility = '$1'
group by year, det_facility, city, state;"

psql sanctuary -c "create or replace view total_requests_by_facility as
select to_char(date, 'YYYY') as year, det_facility, city, state, count(*)
from requests
where det_facility = '$1'
and lift_reason is not null
group by year, det_facility, city, state;"

psql sanctuary -c "select a.year, (a.count::float / b.count::float) * 100 as percent_declined from declined_requests_by_facility as a inner join total_requests_by_facility as b on (a.year = b.year) order by year;"

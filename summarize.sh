psql sanctuary -c "create or replace view declined_requests_per_facility as
select det_facility, city, state, count(*)
from requests
where lift_reason = 'Detainer Declined by LEA'
group by det_facility, city, state;"

psql sanctuary -c "create or replace view total_requests_per_facility as
select det_facility, city, state, count(*)
from requests
group by det_facility, city, state;"

psql sanctuary -c "create or replace view percent_declined_per_facility as
select a.det_facility, a.city, a.state, (a.count::float / b.count::float) as percent_declined
from declined_requests_per_facility as a
inner join total_requests_per_facility as b
on (a.det_facility = b.det_facility and a.city = b.city and a.state = b.state and b.count > 100);"

psql sanctuary -c "create or replace view byyear as
select to_char(date, 'YYYY') as year, det_facility, city, state, count(*) from requests
where lift_reason = 'Detainer Declined by LEA'
and det_facility is not null
group by year, det_facility, city, state
order by year, count desc;"

echo "Overall declined versus overall entertained"

psql sanctuary -c "create or replace view everything_but_declined as
select det_facility, to_char(date, 'YYYY') as year, count(lift_reason) from requests
where lift_reason != 'Detainer Declined by LEA' and det_facility is not null
group by det_facility, year order by det_facility desc;"

psql sanctuary -c "COPY (select * from byyear a
left outer join everything_but_declined b
on a.det_facility = b.det_facility and a.year = b.year
group by a.year,a.det_facility, a.city, a.state, a.count,
b.det_facility, b.year, b.count
order by b.year desc)
TO '`pwd`/export/declined_vs_everythingelse.csv' DELIMITER ',' CSV HEADER;"

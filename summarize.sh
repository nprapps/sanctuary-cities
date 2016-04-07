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

echo "Overall declines across the country"
psql sanctuary -c "
create or replace view overall_declined_per_year
as select to_char(date, 'YYYY') as year, count(*)
from requests
where lift_reason = 'Detainer Declined by LEA'
group by year;

create or replace view total_requests_per_year as
select to_char(date, 'YYYY') as year, count(*)
from requests
where lift_reason is not null
group by year;

create or replace view overall_percent_declined_per_year as
select a.year, (a.count::float / b.count::float) * 100 as percent_declined
from declined as a inner join total_requests_per_year as b on (a.year = b.year) order by year;
"
echo "Declines since 2014 grouped by detention facility"
psql sanctuary -c "create or replace view declined_requests_per_facility as
select det_facility, city, state, count(*)
from requests
where lift_reason = 'Detainer Declined by LEA' and date > '2013-12-31'
group by det_facility, city, state;
create or replace view total_requests_per_facility as
select det_facility, city, state, count(*)
from requests
where date > '2013-12-31' and lift_reason is not null
group by det_facility, city, state;
create or replace view percent_declined_per_facility as
select a.det_facility, a.city, a.state, (a.count::float / b.count::float) as percent_declined
from declined_requests_per_facility as a inner join total_requests_per_facility as b on (a.det_facility = b.det_facility and a.city = b.city and a.state = b.state and b.count > 100)
order by percent_declined desc;
"

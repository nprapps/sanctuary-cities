#!/bin/bash

psql sanctuary -c "create or replace view all_detainers_by_year as
select
  to_char(date, 'YYYY') as year,
  count(*) as count
from requests
group by year
order by year;"

psql sanctuary -c "COPY (select * from all_detainers_by_year) TO '`pwd`/export/all_detainers_by_year.csv' DELIMITER ',' CSV HEADER;"

psql sanctuary -c "create or replace view lifted_detainers_by_year as
select
  to_char(date, 'YYYY') as year,
  count(*) as count
from requests
where lift_reason is not null
group by year
order by year;"

psql sanctuary -c "COPY (select * from lifted_detainers_by_year) TO '`pwd`/export/lifted_detainers_by_year.csv' DELIMITER ',' CSV HEADER;"


psql sanctuary -c "create or replace view detainers_by_type_and_year as
select
  to_char(date, 'YYYY') as year,
  detainer_type,
  count(*) as count
from requests
where detainer_type is not null
group by year, detainer_type
order by year;"

psql sanctuary -c "COPY (select * from detainers_by_type_and_year) TO '`pwd`/export/detainers_by_type_and_year.csv' DELIMITER ',' CSV HEADER;"


psql sanctuary -c "create or replace view detainers_by_lift_reason_and_year as
select
  to_char(date, 'YYYY') as year,
  lift_reason,
  count(*) as count
from requests
where lift_reason is not null
group by year, lift_reason
order by year;"

psql sanctuary -c "COPY (select * from detainers_by_lift_reason_and_year) TO '`pwd`/export/detainers_by_lift_reason_and_year.csv' DELIMITER ',' CSV HEADER;"

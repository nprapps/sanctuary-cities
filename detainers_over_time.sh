#!/bin/bash

psql sanctuary -c "create or replace view detainers_by_year_and_month as
select
  to_char(date, 'YYYY-MM') as year_month,
  count(*) as count,
  city,
  state
from requests
group by year_month, city, state
order by year_month;"

psql sanctuary -c "COPY (select * from detainers_by_year_and_month) TO '`pwd`/export/detainers_by_year_and_month.csv' DELIMITER ',' CSV HEADER;"

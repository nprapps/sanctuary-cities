echo "Generate csv for americans"
psql sanctuary -c"copy(
select * from requests where lift_reason = 'United States Citizen Interviewed'
) to '`pwd`/export/americans.csv' DELIMITER ',' CSV HEADER"

echo "Generate csv for americans by state"
psql sanctuary -c"copy(
select state, count(*) from americans group by state order by count desc
) to '`pwd`/export/americans_by_state.csv' DELIMITER ',' CSV HEADER"

echo "Generate csv for americans by city"
psql sanctuary -c"copy(
SELECT city, state, count(*) from americans group by city, state order by count desc
) to '`pwd`/export/americans_by_city.csv' DELIMITER ',' CSV HEADER"

echo "Generate csv for americans by year"
psql sanctuary -c"copy(
Select to_char(date, 'YYYY') as year,
      count(*)
      from americans group by year order by year
) to '`pwd`/export/americans_by_year.csv' DELIMITER ',' CSV HEADER"

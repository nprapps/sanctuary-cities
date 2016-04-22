echo "Create view of americans geting detainers"
psql sanctuary -c "create or replace view americans as
select * from requests
where lift_reason = 'United States Citizen Interviewed';"
psql sanctuary -c "create or replace view americans_by_city as
select city, state, count(*) from americans
group by city, state order by count desc;"
psql sanctuary -c "create or replace view americans_by_state as
select state, count(*) from americans
group by state order by count desc;"
psql sanctuary -c "create or replace view americans_by_year as
select to_char(date, 'YYYY') as year, count(*) from americans
group by year order by count desc;"

echo "Create view of residents getting detainers"
psql sanctuary -c "create or replace view residents as
select * from requests
where lift_reason = 'Alien Not Subject to Deportation';"
psql sanctuary -c "create or replace view residents_by_city as
select city, state, count(*) from residents
group by city, state order by count desc;"
psql sanctuary -c "create or replace view residents_by_state as
select state, count(*) from residents
group by state order by count desc;"
psql sanctuary -c "create or replace view residents_by_year as
select to_char(date, 'YYYY') as year, count(*) from residents
group by year order by count desc;"

echo "Export American views"
psql sanctuary -c "COPY (select * from americans) TO '`pwd`/export/americans.csv' DELIMITER ',' CSV HEADER"
psql sanctuary -c "COPY (select * from americans_by_city) TO '`pwd`/export/americans_by_city.csv' DELIMITER ',' CSV HEADER"
psql sanctuary -c "COPY (select * from americans_by_state) TO '`pwd`/export/americans_by_state.csv' DELIMITER ',' CSV HEADER"
psql sanctuary -c "COPY (select * from americans_by_year) TO '`pwd`/export/americans_by_year.csv' DELIMITER ',' CSV HEADER"

echo "Export residents views"
psql sanctuary -c "COPY (select * from residents) TO '`pwd`/export/residents.csv' DELIMITER ',' CSV HEADER"
psql sanctuary -c "COPY (select * from residents_by_city) TO '`pwd`/export/residents_by_city.csv' DELIMITER ',' CSV HEADER"
psql sanctuary -c "COPY (select * from residents_by_state) TO '`pwd`/export/residents_by_state.csv' DELIMITER ',' CSV HEADER"
psql sanctuary -c "COPY (select * from residents_by_year) TO '`pwd`/export/residents_by_year.csv' DELIMITER ',' CSV HEADER"

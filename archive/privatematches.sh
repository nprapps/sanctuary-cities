psql sanctuary -c "create or replace view allfacilities as
select distinct det_facility from requests order by det_facility asc;"


psql sanctuary -c "copy(
select * from allfacilities)
to '`pwd`/export/allfacilities.csv' DELIMITER ',' CSV HEADER;"

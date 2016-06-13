echo "exporting table containing only those from the database which are private facilities"
psql sanctuary -c "copy(select * from allpvtfacility, requests
where allpvtfacility.det_facility =requests.det_facility)
to '`pwd`/export/privatefacility/joinpvtfacility.csv' DELIMITER ',' CSV HEADER;"

echo "importing the same table "
psql sanctuary -c "drop table if exists joinpvtfacility;"
psql sanctuary -c "create table joinpvtfacility(
det_facility_a varchar,
pvt_facility_date varchar,
pvt_facility_lift_reason varchar,
det_facility_b varchar,
city varchar,
state varchar,
detainer_type varchar
);"

psql sanctuary -c "copy joinpvtfacility from '`pwd`/export/privatefacility/joinpvtfacility.csv' DELIMITER ',' CSV HEADER;"

echo "creating a table with no pvt facility"
echo "first we join allpvtfacility with requests and export"
psql sanctuary -c "copy(
select requests.* as a, allpvtfacility.det_facility as b
from requests
left outer join allpvtfacility
on
requests.det_facility = allpvtfacility.det_facility)
to '`pwd`/export/privatefacility/joinwithrequests.csv' DELIMITER ',' CSV HEADER;"

echo "...then import again"

psql sanctuary -c "create table joinwithrequests(
date varchar,
lift_reason varchar,
det_facility varchar,
city varchar,
state varchar,
detainer_type varchar,
b varchar
);"

psql sanctuary -c "copy joinwithrequests from '`pwd`/export/privatefacility/joinwithrequests.csv' DELIMITER ',' CSV HEADER;"

echo "clean all pvt facilities"
psql sanctuary -c "create view nopvtfacility as select * from joinwithrequests where b is null;"
psql sanctuary -c "copy(select * from nopvtfacility) to '`pwd`/export/privatefacility/nopvtfacility.csv' DELIMITER ',' CSV HEADER;"

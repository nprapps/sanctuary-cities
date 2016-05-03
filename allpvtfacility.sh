echo "Import all table "
psql sanctuary -c "DROP TABLE if exists cca_matches;"
psql sanctuary -c "CREATE TABLE cca_matches(
pvt_facility varchar,
det_facility varchar
);"

psql sanctuary -c "COPY cca_matches FROM '`pwd`/processed/dedupe/cca_matches.csv' DELIMITER ',' CSV HEADER;"

echo "Import all table "
psql sanctuary -c "DROP TABLE if exists geo_matches;"
psql sanctuary -c "CREATE TABLE geo_matches(
pvt_facility varchar,
state varchar,
capacity varchar,
det_facility varchar
);"

psql sanctuary -c "COPY geo_matches FROM '`pwd`/processed/dedupe/geo_matches.csv' DELIMITER ',' CSV HEADER;"

echo "Import all table "
psql sanctuary -c "DROP TABLE if exists mtc_matches;"
psql sanctuary -c "CREATE TABLE mtc_matches(
pvt_facility varchar,
det_facility varchar
);"

psql sanctuary -c "COPY mtc_matches FROM '`pwd`/processed/dedupe/mtcmatches.csv' DELIMITER ',' CSV HEADER;"


psql sanctuary -c "DROP TABLE if exists allpvtfacility;"
psql sanctuary -c "CREATE TABLE allpvtfacility(
det_facility varchar
);"

psql sanctuary -c "insert into allpvtfacility select det_facility from cca_matches;"
psql sanctuary -c "insert into allpvtfacility select det_facility from geo_matches;"
psql sanctuary -c "insert into allpvtfacility select det_facility from mtc_matches;"
psql sanctuary -c "delete from allpvtfacility where det_facility = 'MONTEBELLO POLICE DEPT.' OR
det_facility = 'GARDEN GROVE POLICE DEPT.' OR
det_facility = 'BALDWIN PARK POLICE DEPT.';"

psql sanctuary -c "copy(
select * from allpvtfacility
);
"

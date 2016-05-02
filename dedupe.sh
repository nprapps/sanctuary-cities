echo "Import cca_all table "

psql sanctuary -c "CREATE TABLE cca_all(
pvt_facility varchar,
city_or_state varchar,
customer varchar,
capacity varchar,
security_level varchar,
facility_type varchar,
term varchar,
renewal_option varchar,
cca_involvement varchar
);"

psql sanctuary -c "insert into cca_all select * from cca_managedonly;"
psql sanctuary -c "insert into cca_all select * from cca_owned_managed;"
psql sanctuary -c "insert into cca_all select * from cca_leased;"


echo "Import geo_all table"

psql sanctuary -c "copy(
select pvt_facility, state from geo_city
) to '`pwd`/processed/geo_city_for_combining.csv' DELIMITER ',' CSV HEADER;"

psql sanctuary -c "DROP TABLE if exists temp_geo_city;"
psql sanctuary -c "create table temp_geo_city(
pvt_facility varchar,
geo_city varchar
);"

psql sanctuary -c "COPY temp_geo_city FROM '`pwd`/processed/geo_city_for_combining.csv' DELIMITER ',' CSV HEADER;"

psql sanctuary -c "alter table temp_geo_city add column capacity varchar;"

psql sanctuary -c "alter table temp_geo_city alter column capacity set default null;"

psql sanctuary -c "copy(
select * from temp_geo_city
) to '`pwd`/processed/geo_city_temp.csv' DELIMITER ',' CSV HEADER;"

psql sanctuary -c "DROP TABLE if exists geo_all;"
psql sanctuary -c "CREATE TABLE geo_all(
pvt_facility varchar,
state varchar,
capacity varchar null
);"

psql sanctuary -c "insert into geo_all select * from temp_geo_city;"
psql sanctuary -c "insert into geo_all select * from geo_federal;"
psql sanctuary -c "insert into geo_all select * from geo_state;"


psql sanctuary -c "copy(
select * from cca_all
) to '`pwd`/export/cca_all.csv' DELIMITER ',' CSV HEADER;"


psql sanctuary -c "copy(
select * from geo_all
) to '`pwd`/export/geo_all.csv' DELIMITER ',' CSV HEADER;"

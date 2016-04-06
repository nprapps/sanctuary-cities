echo "Create database"
dropdb --if-exists sanctuary
createdb sanctuary

echo "Import all table "
psql sanctuary -c "CREATE TABLE requests(
date timestamp,
lift_reason varchar,
det_facility varchar,
city varchar,
state varchar,
detainer_type varchar
)"

cat processed/FY*.csv | psql sanctuary -c "COPY requests FROM stdin DELIMITER ',' CSV HEADER;"

echo "Import fed_bp_list table "
psql sanctuary -c "Create table fed_bp_list
facility varchar
)"

psql sanctuary -c "COPY fed_bp_list FROM '`pwd`/dataimport/fed_bp_list.csv' DELIMITER ',' CSV HEADER;"

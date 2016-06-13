python clean.py

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

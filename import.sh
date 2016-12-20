#!/bin/bash

echo "Create database"
dropdb --if-exists sanctuary
createdb sanctuary

echo "Set up requests table"
psql sanctuary -c "CREATE TABLE requests(
    date timestamp,
    lift_reason varchar,
    det_facility varchar,
    city varchar,
    state varchar,
    detainer_type varchar
)"

echo "Import data"
cat processed/lea-detainers*.csv | psql sanctuary -c "COPY requests FROM stdin DELIMITER ',' CSV HEADER;"

echo "Copy and combine additional files"
csvstack processed/lea-detainers*.csv > processed/lea-detainers-2007_2015.csv
cp data/ice-detention-outcomes.csv processed/ice-detention-outcomes.csv

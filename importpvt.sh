python cleanpvt.py

echo "Create database"
dropdb --if-exists sanctuary
createdb sanctuary

echo "Import cca_managedonly table"
psql sanctuary -c "CREATE TABLE cca_managedonly(
  pvt_facility varchar,
  city_or_state varchar,
  customer varchar,
  capacity varchar,
  security_level varchar,
  facility_type varchar,
  term varchar,
  renewal_option varchar
);"

psql sanctuary -c "COPY cca_managedonly FROM '`pwd`/processed/cca_managedonly.csv' DELIMITER ',' CSV HEADER;"

echo "Import cca_owned_managed table"
psql sanctuary -c "CREATE TABLE cca_owned_managed(
  pvt_facility varchar,
  city_or_state varchar,
  customer varchar,
  capacity varchar,
  security_level varchar,
  facility_type varchar,
  term varchar,
  renewal_option varchar
);"

psql sanctuary -c "COPY cca_managedonly FROM '`pwd`/processed/cca_owned_managed.csv' DELIMITER ',' CSV HEADER;"

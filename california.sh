
echo "making by-year breakdown files for california "
psql sanctuary -c "create or replace view california as
select to_char(date, 'YYYY') as year, det_facility, city, state, lift_reason
from requests where state = 'CALIFORNIA';"

psql sanctuary -c "create or replace view california_cities as
select * from california where city = 'TEHACHAPI'
or city = 'RIDGECREST'
or city = 'DELANO'
or city = 'WASCO'
or city = 'SHAFTER'
or city = 'MCFARLAND'
or city = 'CALIFORNIA CITY'
or city = 'TAFT'
or city = 'BAKERSFIELD'
or city = 'PLEASANT HILL'
or city = 'RICHMOND'
or city = 'MARTINEZ'
or city = 'CONCORD'
or city = 'LEMON GROVE'
or city = 'SANTEE'
or city = 'VISTA'
or city = 'EL CAJON'
or city = 'CHULA VISTA'
or city = 'PLEASANT HILL'
or city = 'RICHMOND'
or city = 'MARTINEZ'
or city = 'CONCORD'
or city = 'SAN FRANCISCO'
or city = 'SAN DIEGO';"


psql sanctuary -c "COPY(select * from california_cities )
to '`pwd`/export/california.csv' DELIMITER ',' CSV HEADER;"


echo "creating a count of all requests received by the california_cities"

psql sanctuary -c "copy(
select city, count (*) from california where city = 'TEHACHAPI'
or city = 'RIDGECREST'
or city = 'DELANO'
or city = 'WASCO'
or city = 'SHAFTER'
or city = 'MCFARLAND'
or city = 'CALIFORNIA CITY'
or city = 'TAFT'
or city = 'BAKERSFIELD'
or city = 'PLEASANT HILL'
or city = 'RICHMOND'
or city = 'MARTINEZ'
or city = 'CONCORD'
or city = 'LEMON GROVE'
or city = 'SANTEE'
or city = 'VISTA'
or city = 'EL CAJON'
or city = 'CHULA VISTA'
or city = 'RICHMOND'
or city = 'MARTINEZ'
or city = 'CONCORD'
or city = 'SAN FRANCISCO'
or city = 'SAN DIEGO'

group by city order by count desc
)

to '`pwd`/export/californiacount.csv' DELIMITER ',' CSV HEADER;"

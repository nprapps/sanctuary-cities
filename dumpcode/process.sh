echo "Generate csv for americans"
psql sanctuary -c"copy(
select * from requests where lift_reason = 'United States Citizen Interviewed'
) to '`pwd`/export/americans.csv' DELIMITER ',' CSV HEADER"

create or replace view americans as select * from requests where lift_reason = 'United States Citizen Interviewed';

select state, count(*) from americans group by state order by count desc;

CALIFORNIA               |   170
 TEXAS                    |   114
 PENNSYLVANIA             |    61
 ARIZONA                  |    47
 GEORGIA                  |    39
 FLORIDA                  |    37
  blank?                        |    34
 RHODE ISLAND             |    19
 NEW YORK                 |    16
 NORTH CAROLINA           |    13
 COLORADO                 |    12
 MARYLAND                 |    11
 NEW JERSEY               |    10

SELECT city, count(*) from americans group by city order by count desc;

city       | count
------------------+-------
HUNTSVILLE       |    42
PHOENIX          |    36
                 |    34
PHILIPSBURG      |    22
LOS ANGELES      |    21
CRANSTON         |    19
SAN DIEGO        |    19
WHITE DEER       |    19
FRENCH CAMP      |    13
ATLANTA          |    13
FRESNO           |    10
SAN ANTONIO      |     9
MODESTO          |     8
EDINBURG         |     8
TRACY            |     7
TALLAHASSEE      |     7
CALIPATRIA       |     7
ORLANDO          |     7
ROCKVILLE        |     6
NATCHEZ          |     5
DALLAS           |     5
PECOS            |     5
ELMHURST         |     5
TAMPA            |     5
RALEIGH          |     5
FLORENCE         |     5
CHOWCHILLA       |     5

SELECT city, state, count(*) from americans group by city, state order by count desc;

city       |          state           | count
------------------+--------------------------+-------
HUNTSVILLE       | TEXAS                    |    42
PHOENIX          | ARIZONA                  |    36
              |                          |    34
PHILIPSBURG      | PENNSYLVANIA             |    22
LOS ANGELES      | CALIFORNIA               |    21
SAN DIEGO        | CALIFORNIA               |    19
CRANSTON         | RHODE ISLAND             |    19
WHITE DEER       | PENNSYLVANIA             |    19
ATLANTA          | GEORGIA                  |    13
FRENCH CAMP      | CALIFORNIA               |    13
FRESNO           | CALIFORNIA               |    10

select state, select extract (year from date) as year, count(*) from americans group by date order by count desc;

create view year_american as
Select state, to_char(date, 'YYYY') as year,
      count(*)
      from americans group by state, year order by count desc;

      Select to_char(date, 'YYYY') as year,
            count(*)
            from americans group by year order by year;

            year | count
            ------+-------
             2012 |   150
             2011 |   103
             2010 |   101
             2009 |    76
             2008 |    76
             2014 |    76
             2013 |    58
             2015 |    38
             2007 |    15

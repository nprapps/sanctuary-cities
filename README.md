__Sanctuary Cities__
====================

__Requirements__
----------------

* bash
* Python
* Postgresql
* csvdedupe ( <code> pip install csvdedupe </code> )

__Import the data__
-------------------

To clean the data and build the tables, run:

<code>import.sh</code> imports from <code>raw/</code> and dumps in <code>processed/</code>

__Analysis__
-------------------

So far there have been three overarching analysis we have been doing with the sanctuary city data. 

__1__ __What's happening in the counties of San Francisco, Contra Costa, Kern, San Diego ?__

* Make a subset of the cities of the above mentioned counties
* Get a count of the total number of detainers received by each city

Run:

<code>california.sh</code>

* Get a breakdown of all the facilities of each of the cities 

<code>california_facility_year_breakdown.sh</code> 

__2__ __How is the behavior of private prisons different from those which are not private?__

* Run <code> total.sh </code>

This script will find out: 
* identify the private prisons in the main table
* isolate the private prisons into another table thus creating two tables - one containing only pvt facilities and the other containing none

* Run <code> 160504_detentions.R </code> and <code>detentions2PercentagesAndAverages.R</code> to find out the percentage of each type of detainer-response for each facility and the average percentage of each type of detainer response across all facilities. This separates the two into private facilities and non-private facilities. This analysis suffers the problem of the law of large numebrs - we are comparing two datasets of very uneqal sizes.

* Run <code> cca_byyear.sh geo_byyear.sh mtcbyyear.sh </code> to find out by-year count of each type of detainer-response of the private facilities

* Run <code> cca_declines_per_year.sh geo_declines_per_year.sh </code> to find out by-year count of how many detainers the private facilities declined

* Run <code> cca_detainercount.sh geo_detainercount.sh mtc_detainercount.sh </code> to find out total overall count of each type of detainer-response of the private facilities

__3__ __Americans and people not subject to deportation being issued detainers__

* Run <code> american.sh </code> to get americans getting detainers, residents getting detainers 

* Run <code> americans_export.sh </code> to get americans getting detainers by state, city, year

__4__ __What are the sanctuary cities?__



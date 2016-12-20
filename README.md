Sanctuary Cities
================

What is this?
-------------

This project began as a much more expansive analysis, captured on the many messy branches that still exist. The current form exists only to calculate a few numbers for an NPR story on U.S. citizens detained by U.S. Immigration and Customs Enforcement (ICE).

This codebase is licensed under the [MIT open source license](http://opensource.org/licenses/MIT). See the ``LICENSE`` file for the complete license.

The data contained in the `data` and `processed` directories were obtained via Freedom of Information Act (FOIA) requests to ICE and is, to the best of our knowledge, in the public domain.

There are two datasets in the `data` directory:

* One is a series of files that compromise all detainers issued to local law enforcement agencies from Oct 1, 2007 to July 19, 2015 and their outcome. In the final database, null `lift_reason` columns are cases that are still pending or for which no paper was filed with ICE. The files belonging to this dataset have filenames that currently begin with `FY`.
* The other was obtained via FOIA by Jacqueline Stevens from Northwestern University. The file represents all cases of ICE detention where the detainee claimed U.S. citizenship and includes cases completed between 2008 and 2013. The data includes some manual processing from graduate students to string together sequential outcomes for all cases (as the final outcome of many cases is not the initial ruling).

Requirements
------------

* bash
* Python 2.7 (not tested on Python 3.x)
* Postgresql

One shot operation
------------------

```bash
./process.sh
```

Individual scripts
------------------

* ``clean.py``: Clean source data and exported to `processed` directory.
* ``export.sh``: Run the counter queries, U.S. citizens in ICE custody and U.S. citizens issued detainers while in local law enforcement agency custody.
* ``ice_detention_counter.py``: Count detentions of U.S. citizens in ICE custody.
* ``import.sh``: Put the law enforcement agency data into a Postgresql database.


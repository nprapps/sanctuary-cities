#!/usr/bin/python

import csv

def process_csv(filename):
    with open('raw/%s' % filename, 'rU') as f:
        reader = csv.reader(f)
        data = list(reader)
        writecsv(data, filename)

def writecsv(data, filename):
    fieldnames = ['pvt_facility',
                  'city_or_state',
                  'customer',
                  'capacity',
                  'security_level',
                  'facility_type',
                  'term',
                  'renewal_option']
    i = 0
    processed_data = []
    while i < len(data) - 1:
        facility_row = data[i]
        location_row = data[i+1]
        customer = '{0} {1}'.format(facility_row[1].strip(), location_row[1].strip())
        security_level = '{0} {1}'.format(facility_row[3].strip(), location_row[3].strip())
        facility_type = '{0} {1}'.format(facility_row[3].strip(), location_row[3].strip())

        full_row = {
            'pvt_facility': facility_row[0].strip(),
            'city_or_state': location_row[0].strip(),
            'customer': customer,
            'capacity': facility_row[2].strip(),
            'security_level': security_level,
            'facility_type': facility_type,
            'term': facility_row[5].strip(),
            'renewal_option': facility_row[6].strip()
        }
        processed_data.append(full_row)
        i += 2

    with open('processed/%s' % filename, 'w+') as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)

        writer.writerows(processed_data)

if __name__ == '__main__':
    for filename in ['cca_managedonly.csv','cca_owned_managed.csv']:
        process_csv(filename)

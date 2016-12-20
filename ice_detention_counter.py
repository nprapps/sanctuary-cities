import csv


def count():
    """
    Count up US citizens
    """
    out = []
    with open('data/ice-detention-outcomes.csv') as f:
        reader = csv.DictReader(f)
        for row in reader:
            if (row['Custody1'].lower() == 'detained' or row['Custody2'].lower() == 'detained') and row['Outcome3'].lower() == 'terminated':
                out.append(row)

    return out


if __name__ == '__main__':
    data = count()
    print(len(data))

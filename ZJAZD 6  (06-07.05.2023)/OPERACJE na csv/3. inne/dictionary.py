import csv

filename = 'username.csv'

our_dialect = csv.excel
our_dialect.delimiter = ';'

with open(filename, encoding='utf-8', newline='') as user_file:
    headers = ['jeden', 'dwa', 'trzy', 'cztery', 'piec']
    reader = csv.DictReader(user_file, dialect=our_dialect, fieldnames=headers)

    for row in reader:
        print(row)
import csv

filename = 'username.csv'

with open(filename, encoding='utf-8', newline='') as csv_file:

    #tworzymy sniffera (niuchacza) - węszyciela
    sample = csv_file.read() #1 metoda z .read
    # sample = csv_file.readlines() #2 metoda z .readlines
    file_dialect = csv.Sniffer().sniff(sample)

    #Wracamy na początek plkiku, bo musimy oddczytwac dane, do tego słuzy seek
    csv_file.seek(0)
    csv_file.readline().strip('\n').split(file_dialect.delimiter)


    #przekazujemy dialekt, który został znaleziony przez sniffera
    reader = csv.reader(csv_file, quoting=csv.QUOTE_NONNUMERIC, dialect=file_dialect)


    for row in reader:
        print(row)

print(f"Delimiter: {file_dialect.delimiter}")
print(f"Escape: {file_dialect.escapechar}")
print(f"Line terminator: {repr(file_dialect.lineterminator)}")

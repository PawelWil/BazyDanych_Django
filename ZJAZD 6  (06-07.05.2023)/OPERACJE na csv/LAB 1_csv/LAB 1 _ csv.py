# Za pomocą 'DictReader', po wpisaniu w konsoli nazwy kraju lub kodu 2 znakowego
# na konsoli print pojawi się: Stolica, strefa czasowa, waluta i kod kierunkowy


import csv

filename = 'country_info.txt'

countries = {} # tworzymy mapę 'Countries'

dialect = csv.excel
dialect.delimiter = '|'

with open(filename, encoding='utf-8') as country_file:
    headers = country_file.readline().rstrip('\n').split(dialect.delimiter)

    for index, header in enumerate (headers):
        headers[index] = header.casefold()


    reader = csv.DictReader(country_file, dialect=dialect, fieldnames=headers)

    for row in reader:
        countries[row['country'].casefold()] = row
        countries[row['cc'].casefold()] = row


while True:
    selected_country = input("Podaj kraj lub kod: ")

    if selected_country == '0':
        break

    result = countries.get(selected_country.casefold())
    if result:
        print (f"Stolica: {result['capital']}", f"Strefa czasowa: {result['timezone']}"
            f"Kod kierunkowy: {result['iac']}", f"Waluta: {result['currency']}", sep='\n\t')
    else:
        print(f'Nie ma takiego klucza jak {selected_country}')


filename = 'country_info.txt'
# teraz otwieramy go szybciej niz poprzednio w lekcji 1

with open(filename, encoding='utf-8') as country_file:
    for row in country_file:
        print(row)  # dzięki temu kodowi jest zaczytywany  plik 'country info;
        data = row.strip().split('|')
        print(data)

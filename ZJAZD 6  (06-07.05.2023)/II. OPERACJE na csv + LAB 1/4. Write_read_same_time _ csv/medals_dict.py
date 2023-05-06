import csv

medals_table=[
	{'athlete': 'CASLAVSKA, Vera', 'gold': 7, 'silver': 4, 'bronze': 0, 'country': 'Czechoslovakia', 'Total': None},
	{'athlete': 'FISCHER, Birgit', 'gold': 8, 'silver': 4, 'bronze': 0, 'country': 'East Germany', 'Total': None},
	{'athlete': 'NURMI, Paavo', 'gold': 9, 'silver': 3, 'bronze': 0, 'country': 'Finland', 'Total': None},
	{'athlete': 'VAN ALMSICK, Franziska', 'gold': 0, 'silver': 4, 'bronze': 6, 'country': 'Germany', 'Total': None},
	{'athlete': 'GEREVICH, Aladar', 'gold': 7, 'silver': 1, 'bronze': 2, 'country': 'Hungary', 'Total': None},
	{'athlete': 'KELETI, Agnes', 'gold': 5, 'silver': 3, 'bronze': 2, 'country': 'Hungary', 'Total': None},
	{'athlete': 'MANGIAROTTI, Edoardo', 'gold': 6, 'silver': 5, 'bronze': 2, 'country': 'Italy', 'Total': None},
	{'athlete': 'GAUDINI, Giulio', 'gold': 3, 'silver': 4, 'bronze': 2, 'country': 'Italy', 'Total': None},
	{'athlete': 'ONO, Takashi', 'gold': 5, 'silver': 4, 'bronze': 4, 'country': 'Japan', 'Total': None},
	{'athlete': 'KATO, Sawao', 'gold': 8, 'silver': 3, 'bronze': 1, 'country': 'Japan', 'Total': None},
	{'athlete': 'NAKAYAMA, Akinori', 'gold': 6, 'silver': 2, 'bronze': 2, 'country': 'Japan', 'Total': None},
	{'athlete': 'COMANECI, Nadia', 'gold': 5, 'silver': 3, 'bronze': 1, 'country': 'Romania', 'Total': None},
	{'athlete': 'NEMOV, Alexei', 'gold': 4, 'silver': 2, 'bronze': 6, 'country': 'Russia', 'Total': None},
	{'athlete': 'LATYNINA, Larisa', 'gold': 9, 'silver': 5, 'bronze': 4, 'country': 'Soviet Union', 'Total': None},
	{'athlete': 'ANDRIANOV, Nikolay', 'gold': 7, 'silver': 5, 'bronze': 3, 'country': 'Soviet Union', 'Total': None},
	{'athlete': 'SHAKHLIN, Boris', 'gold': 7, 'silver': 4, 'bronze': 2, 'country': 'Soviet Union', 'Total': None},
	{'athlete': 'CHUKARIN, Viktor Ivanovich', 'gold': 7, 'silver': 3, 'bronze': 1, 'country': 'Soviet Union', 'Total': None},
	{'athlete': 'ASTAKHOVA, Polina', 'gold': 5, 'silver': 2, 'bronze': 3, 'country': 'Soviet Union', 'Total': None},
	{'athlete': 'DITYATIN, Aleksandr', 'gold': 3, 'silver': 6, 'bronze': 1, 'country': 'Soviet Union', 'Total': None},
	{'athlete': 'SCHERBO, Vitaly', 'gold': 6, 'silver': 0, 'bronze': 4, 'country': 'Unified team', 'Total': None},
	{'athlete': 'PHELPS, Michael', 'gold': 14, 'silver': 0, 'bronze': 2, 'country': 'United States', 'Total': None},
	{'athlete': 'THOMPSON, Jenny', 'gold': 8, 'silver': 3, 'bronze': 1, 'country': 'United States', 'Total': None},
	{'athlete': 'TORRES, Dara', 'gold': 4, 'silver': 4, 'bronze': 4, 'country': 'United States', 'Total': None},
	{'athlete': 'BIONDI, Matthew', 'gold': 8, 'silver': 2, 'bronze': 1, 'country': 'United States', 'Total': None},
	{'athlete': 'COUGHLIN, Natalie', 'gold': 3, 'silver': 4, 'bronze': 4, 'country': 'United States', 'Total': None},
	{'athlete': 'OSBURN, Carl Townsend', 'gold': 5, 'silver': 4, 'bronze': 2, 'country': 'United States', 'Total': None},
	{'athlete': 'SPITZ, Mark', 'gold': 9, 'silver': 1, 'bronze': 1, 'country': 'United States', 'Total': None},
	{'athlete': 'HALL, Gary Jr.', 'gold': 5, 'silver': 3, 'bronze': 2, 'country': 'United States', 'Total': None},
	{'athlete': 'LEWIS, Carl', 'gold': 9, 'silver': 1, 'bronze': 0, 'country': 'United States', 'Total': None},
]

# teraz zapisanie go
# column_names = ['athlete', 'gold', 'silver', 'bronze', 'Country' ,'Total']
column_names = ['athlete', 'gold', 'silver', 'bronze', 'Total']
filename = 'athlete_medals_write.csv'

def sort_key(d: dict) -> str:
	return d['athlete']

with open(filename, 'w', encoding='utf-8', newline='') as output_file:
	writer = csv.DictWriter(output_file, fieldnames=column_names, quoting=csv.QUOTE_NONNUMERIC, extrasaction='ignore') # poprzez extrasaction możemy sobie wyciąć coś z listy,
	# np. wycięliśmy 'Country' kóry to następnie się nie wyświetla w 'athlete_medals_write'
	writer.writeheader()
	writer.writerows(sorted(medals_table, key=sort_key))



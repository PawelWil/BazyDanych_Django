animals_array = [
    "Kot - Ssak",
    "Pies - Ssak",
    "Wąż - Gad",
    "Dziobak - Ssak",
    "Sowa - Ptak",
    "Komodo - Gad",
    "Szerszeń - Owad",
    "Tarantula - Gad",
    "Żaba - Płaz",
    "Miś - Ssak",
    "Koń - Ssak",
    "Pszczoła - Owad",
    "Kukułka - Ptak",
    "Mucha - Owad",
]

animals_filename = 'animals.txt'  # utworzyl sie plik tekstowy - animal.txt - ale tylko na razie sam folder, w którym jeszcze sie nie zapisały te dane

with open(animals_filename, 'w', encoding='utf-8') as animals:
    for animal in animals_array:
        # print(animal, file=animals, end='') # jak dalem file=animals, to wtdy te wszystkie dane tam się zapisały, a po endzie w jednej linii
        animals.write(animal)
# napisać różnicę miedzy print a write

# -- 1. wykorzyastanie TRy, exception i Finally
#
# try:
#
#     lord_of_the_rings = open('lor.txt', 'r')
#
#     for line in lord_of_the_rings:
#         print(line)
#         raise ValueError
# except Exception:
#     print("EXCEPTION!!")
# finally:
#     print("Będę zamykał plik")
#     lord_of_the_rings.close()


# text = "'Trzy Pierścienie dla królów elfów pod otwartym niebem,\n" #-- sprawdzenie długosci linii
# print(len(text))


# -- 2. White space (biały znak) - np. tab, spacja, koniec linii itd.
# teraz chcemy te white spaces nie wyświetlać, które z defaultu się printują i dlatego są wolne liniie pomiedzy wiearszami
lord_of_the_rings = open('lor.txt', 'r', encoding='utf-8') # encoding - odczytaj plik lor.txt  z kodowaniem UTF-8. Raczej większość plików tak jest kodowanych -
# robaczki zamienia na literki. Jak sobie usunę 'encoding' to będzie tekst z robaczkami - linia poniżej:
# lord_of_the_rings = open('lor.txt', 'r')

for line in lord_of_the_rings:
    # print(line.strip(), end='')
    print(line.rstrip()) # dzięki endowi pozbyliśmy się wolnych/pustych linii (linia po linii)
    # zas metoda strip wykryje wite spaces i je wytnie - ale przez to text zrobi się jednolinijkowy, co tez nie do konca nam o to chodzi. Zeby to
    # wyeliminować usuwmay 'end'
    # print(line.rstrip()) # to jest right strip - piszę się od prawej do lewej - to jest tryb do odczytu
    # print(line.lstrip()) # to jest left strip - piszę się od lewej do prawej


lord_of_the_rings.close()






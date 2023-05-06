#Tworzymy klasę główną 'Animal':

#1
class Animal(object):
    pass

class Dog (Animal):
    pass

class Owczarek (Dog):
    pass


class Cat(Animal):
    pass

# print(issubclass(Cat, Animal)) # True bo kot jest podklasą Animal
# print(issubclass(Dog, Animal)) # True bo pies jest podklasą Animal
# print(issubclass(Animal, Animal)) # True bo Animal jest podklasą/klasą Animal
# print(issubclass(Cat, Dog)) # False bo kot  nie jest podklasą Animal
#
# print(issubclass(Owczarek, Dog))
# print(issubclass(Owczarek, Animal))
# print(issubclass(Dog, Owczarek))


#------
# dog = Dog()
# print(isinstance(dog, object))
# print(isinstance(dog, Animal))
# print(isinstance(dog, Dog))
# print(isinstance(dog, Cat))


#------
# dog = Dog()
# dog_1 = Dog()
# dog_2 = dog
#
# print(dog is dog) # True
# print(dog is dog_1)
# print(dog is dog_2)


# #------
# dog = Dog()
# dog_1 = Dog()
# dog_2 = dog
#
# print(dog)
# print(dog_1)
# print(dog_2)
#
# print(__name__)



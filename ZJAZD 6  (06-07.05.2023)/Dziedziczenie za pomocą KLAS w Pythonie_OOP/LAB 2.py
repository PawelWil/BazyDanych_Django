# LAB 1
#A. Chcemy żeby zawsze miały 100 życia I 20 ATAKU (hint: super() ).
#B. Dopisać kolejnego przeciwnika, który
#C. ma zawsze 200 życia, ale różną SIŁA ATAKU.
#D. Nie będzie mógł atakować, jeżeli jego życie spadnie poniżej 20 punktów.
#E. PRZYJMUJE DWA RAZY MNIEJSZE OBRAŻENIA, JEŻELI JEGO ŻYCIE SPADNIE PONIŻEJ 50.

#test asdsadasd
class Enemy:

    def __init__(self, name='Enemy', health=0, hit_power=0):
        self.name = name
        self.health = health
        self.hit_power = hit_power

    def take_damage(self, damage):
        remaining_health = self.health - damage
        if remaining_health > 0:
            self.health = remaining_health
        else:
            self.health = 0
            print("Enemy is dead.")

    def attack (self, additional_attack):
        print((f"Enemy attack with power {self.hit_power}"))

    def __str__(self):
        return  f"Name {self.name}. Health: {self.health}. Hit power: {self.hit_power}"

class Troll(Enemy):
    def __init__(self, name):
        super().__init__(name, 100, 20)

# troll = Troll()
# troll_with_name = Troll("Troll")
# troll_with_health = Troll("Troll", 100)
# troll_with_hit_power = Troll("Troll", 100, 100)




# print(troll)
# print(troll_with_name)
# print(troll_with_health)
# print(troll_with_hit_power)

class Troll(Enemy):

    def take_damage(self, damage, next):
        super().take_damage(damage)
        if self.health == 0:
            self.health == 100

    def attack(self):
        print(f"Troll attack with poweer {self.hit_power}")


troll = Troll("Troll", 100, 100)
troll.attack()
troll.take_damage(50, '')
print(troll)
troll.take_damage(51,'')
print(troll)



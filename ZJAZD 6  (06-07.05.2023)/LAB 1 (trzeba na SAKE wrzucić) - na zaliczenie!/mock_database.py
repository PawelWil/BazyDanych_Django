ingredients = []

def add_ingredient(name, calories, protein, fat, carbs, fiber, ingredient_type) -> None:
    ingredients.append(ingredient(name, calories, protein, fat, carbs, fiber, ingredient_type))


def find_all():
    """
    Find all ingredients in list.
    :return: List of Ingredients
    """
    return ingredients.copy()

def find_by_name_like(name: str):
    """
    Find all ingredients by name
    :param name:
    :return:
    """
    copy = find_all()
    result = []

    for ingredient in copy:
        if name.casefold() in ingredient.name.casefold():
            result.append(ingredient)
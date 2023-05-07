-- tworzymy tabele pod składniki 'Ingredients'

-- "NAME";"CALORIES";"PROTEIN";"FAT";"CARBS";"FIBER";"TYPE"

use wiltos


CREATE TABLE ingredients
(
    ingredient_id   int IDENTITY PRIMARY KEY,
    ingredient_name VARCHAR(255) not null unique,
    Calories        FLOAT(50),
    Protein         FLOAT        NOT NULL,
    fat             FLOAT        NOT NULL,
    carbs           FLOAT        NOT NULL,
    fiber           FLOAT        NOT NULL,
    ingredient_type VARCHAR(100) not null
)

INSERT INTO ingredients (ingredient_name, CALORIES, PROTEIN, FAT, CARBS, FIBER)
VALUES ('ŚĆkjjsdf', 1, 2 ,3, 4)

SELECT * from ingredients;



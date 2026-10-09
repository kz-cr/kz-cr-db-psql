-- Creates the `items` table and loads sample grocery items.
-- Idempotent: safe to run repeatedly. Existing rows are matched on name and
-- updated in place, so re-running never creates duplicates.

BEGIN;

CREATE TABLE IF NOT EXISTS items (
    id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name        TEXT          NOT NULL UNIQUE,
    description TEXT          NOT NULL,
    price       NUMERIC(10,2) NOT NULL CHECK (price >= 0)
);

INSERT INTO items (name, description, price) VALUES
    -- Produce
    ('Bananas', 'Fresh ripe bananas, sold per pound.', 0.59),
    ('Gala Apples', 'Crisp and sweet Gala apples, sold per pound.', 1.99),
    ('Navel Oranges', 'Juicy seedless navel oranges, sold per pound.', 1.49),
    ('Strawberries', 'Fresh strawberries, 1 lb container.', 3.99),
    ('Blueberries', 'Plump blueberries, 6 oz container.', 3.49),
    ('Avocados', 'Ripe Hass avocados, sold each.', 1.25),
    ('Roma Tomatoes', 'Firm Roma tomatoes, sold per pound.', 1.79),
    ('Baby Spinach', 'Pre-washed baby spinach, 5 oz bag.', 2.99),
    ('Carrots', 'Whole carrots, 2 lb bag.', 1.99),
    ('Yellow Onions', 'All-purpose yellow onions, 3 lb bag.', 2.79),
    ('Russet Potatoes', 'Baking potatoes, 5 lb bag.', 4.49),
    ('Broccoli Crowns', 'Fresh broccoli crowns, sold per pound.', 2.29),
    -- Dairy & eggs
    ('Whole Milk', 'Pasteurized whole milk, 1 gallon.', 3.89),
    ('2% Reduced Fat Milk', 'Pasteurized 2% milk, 1 gallon.', 3.79),
    ('Large Eggs', 'Grade A large eggs, dozen.', 3.49),
    ('Unsalted Butter', 'Creamery unsalted butter, 1 lb.', 4.99),
    ('Cheddar Cheese', 'Sharp cheddar cheese block, 8 oz.', 3.29),
    ('Greek Yogurt', 'Plain whole milk Greek yogurt, 32 oz tub.', 5.49),
    ('Mozzarella Cheese', 'Shredded part-skim mozzarella, 8 oz bag.', 2.99),
    -- Bakery
    ('Whole Wheat Bread', 'Sliced whole wheat sandwich loaf, 20 oz.', 3.29),
    ('Sourdough Loaf', 'Artisan sourdough boule, baked daily.', 4.99),
    ('Plain Bagels', 'Fresh plain bagels, 6 count.', 3.99),
    ('Flour Tortillas', 'Soft flour tortillas, 10 count.', 2.89),
    -- Meat & seafood
    ('Chicken Breast', 'Boneless skinless chicken breast, sold per pound.', 4.99),
    ('Ground Beef', '85% lean ground beef, 1 lb.', 5.99),
    ('Atlantic Salmon Fillet', 'Fresh skin-on salmon fillet, sold per pound.', 11.99),
    ('Thick-Cut Bacon', 'Hickory smoked thick-cut bacon, 12 oz.', 6.49),
    ('Large Shrimp', 'Peeled and deveined raw shrimp, 1 lb frozen bag.', 9.99),
    -- Pantry
    ('Spaghetti', 'Dried durum wheat spaghetti, 16 oz box.', 1.69),
    ('Marinara Sauce', 'Classic tomato basil pasta sauce, 24 oz jar.', 3.49),
    ('Long Grain White Rice', 'Enriched long grain white rice, 5 lb bag.', 4.99),
    ('Black Beans', 'Canned black beans, 15 oz can.', 1.19),
    ('Extra Virgin Olive Oil', 'Cold-pressed extra virgin olive oil, 16.9 fl oz.', 8.99),
    ('All-Purpose Flour', 'Unbleached all-purpose flour, 5 lb bag.', 3.99),
    ('Granulated Sugar', 'Pure cane granulated sugar, 4 lb bag.', 3.79),
    ('Peanut Butter', 'Creamy peanut butter, 16 oz jar.', 3.19),
    ('Rolled Oats', 'Old-fashioned rolled oats, 18 oz canister.', 3.99),
    ('Honey', 'Pure clover honey, 12 oz squeeze bottle.', 5.49),
    -- Snacks
    ('Tortilla Chips', 'Lightly salted corn tortilla chips, 13 oz bag.', 3.99),
    ('Salted Almonds', 'Roasted and salted almonds, 10 oz canister.', 6.49),
    ('Dark Chocolate Bar', '70% cacao dark chocolate bar, 3.5 oz.', 2.99),
    ('Granola Bars', 'Oats and honey granola bars, 8 count.', 3.69),
    -- Beverages
    ('Orange Juice', 'Not-from-concentrate orange juice, 52 fl oz.', 4.49),
    ('Sparkling Water', 'Unflavored sparkling water, 12 pack of 12 fl oz cans.', 5.99),
    ('Ground Coffee', 'Medium roast ground coffee, 12 oz bag.', 8.49),
    ('Black Tea Bags', 'English breakfast black tea, 40 count.', 3.99),
    -- Frozen
    ('Frozen Peas', 'Garden peas, 12 oz bag.', 1.79),
    ('Vanilla Ice Cream', 'Classic vanilla ice cream, 48 fl oz tub.', 5.49),
    ('Cheese Pizza', 'Frozen thin-crust cheese pizza, 12 inch.', 6.99),
    -- Household
    ('Paper Towels', 'Two-ply paper towels, 6 rolls.', 8.99),
    ('Dish Soap', 'Lemon scented liquid dish soap, 20 fl oz.', 3.29)
ON CONFLICT (name) DO UPDATE
    SET description = EXCLUDED.description,
        price       = EXCLUDED.price;

COMMIT;

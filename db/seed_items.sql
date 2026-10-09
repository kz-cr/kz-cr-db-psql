-- Creates the `items` table and loads sample grocery items.
-- Idempotent: safe to run repeatedly. Existing rows are matched on name and
-- updated in place, so re-running never creates duplicates.

BEGIN;

CREATE TABLE IF NOT EXISTS items (
    id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name        TEXT          NOT NULL UNIQUE,
    category    TEXT          NOT NULL,
    description TEXT          NOT NULL,
    price       NUMERIC(10,2) NOT NULL CHECK (price >= 0)
);

INSERT INTO items (name, category, description, price) VALUES
    -- Produce
    ('Bananas', 'Produce', 'Fresh ripe bananas, sold per pound.', 0.59),
    ('Gala Apples', 'Produce', 'Crisp and sweet Gala apples, sold per pound.', 1.99),
    ('Navel Oranges', 'Produce', 'Juicy seedless navel oranges, sold per pound.', 1.49),
    ('Strawberries', 'Produce', 'Fresh strawberries, 1 lb container.', 3.99),
    ('Blueberries', 'Produce', 'Plump blueberries, 6 oz container.', 3.49),
    ('Avocados', 'Produce', 'Ripe Hass avocados, sold each.', 1.25),
    ('Roma Tomatoes', 'Produce', 'Firm Roma tomatoes, sold per pound.', 1.79),
    ('Baby Spinach', 'Produce', 'Pre-washed baby spinach, 5 oz bag.', 2.99),
    ('Carrots', 'Produce', 'Whole carrots, 2 lb bag.', 1.99),
    ('Yellow Onions', 'Produce', 'All-purpose yellow onions, 3 lb bag.', 2.79),
    ('Russet Potatoes', 'Produce', 'Baking potatoes, 5 lb bag.', 4.49),
    ('Broccoli Crowns', 'Produce', 'Fresh broccoli crowns, sold per pound.', 2.29),
    -- Dairy & eggs
    ('Whole Milk', 'Dairy and Eggs', 'Pasteurized whole milk, 1 gallon.', 3.89),
    ('2% Reduced Fat Milk', 'Dairy and Eggs', 'Pasteurized 2% milk, 1 gallon.', 3.79),
    ('Large Eggs', 'Dairy and Eggs', 'Grade A large eggs, dozen.', 3.49),
    ('Unsalted Butter', 'Dairy and Eggs', 'Creamery unsalted butter, 1 lb.', 4.99),
    ('Cheddar Cheese', 'Dairy and Eggs', 'Sharp cheddar cheese block, 8 oz.', 3.29),
    ('Greek Yogurt', 'Dairy and Eggs', 'Plain whole milk Greek yogurt, 32 oz tub.', 5.49),
    ('Mozzarella Cheese', 'Dairy and Eggs', 'Shredded part-skim mozzarella, 8 oz bag.', 2.99),
    -- Bakery
    ('Whole Wheat Bread', 'Bakery', 'Sliced whole wheat sandwich loaf, 20 oz.', 3.29),
    ('Sourdough Loaf', 'Bakery', 'Artisan sourdough boule, baked daily.', 4.99),
    ('Plain Bagels', 'Bakery', 'Fresh plain bagels, 6 count.', 3.99),
    ('Flour Tortillas', 'Bakery', 'Soft flour tortillas, 10 count.', 2.89),
    -- Meat & seafood
    ('Chicken Breast', 'Meat and Seafood', 'Boneless skinless chicken breast, sold per pound.', 4.99),
    ('Ground Beef', 'Meat and Seafood', '85% lean ground beef, 1 lb.', 5.99),
    ('Atlantic Salmon Fillet', 'Meat and Seafood', 'Fresh skin-on salmon fillet, sold per pound.', 11.99),
    ('Thick-Cut Bacon', 'Meat and Seafood', 'Hickory smoked thick-cut bacon, 12 oz.', 6.49),
    ('Large Shrimp', 'Meat and Seafood', 'Peeled and deveined raw shrimp, 1 lb frozen bag.', 9.99),
    -- Pantry
    ('Spaghetti', 'Pantry', 'Dried durum wheat spaghetti, 16 oz box.', 1.69),
    ('Marinara Sauce', 'Pantry', 'Classic tomato basil pasta sauce, 24 oz jar.', 3.49),
    ('Long Grain White Rice', 'Pantry', 'Enriched long grain white rice, 5 lb bag.', 4.99),
    ('Black Beans', 'Pantry', 'Canned black beans, 15 oz can.', 1.19),
    ('Extra Virgin Olive Oil', 'Pantry', 'Cold-pressed extra virgin olive oil, 16.9 fl oz.', 8.99),
    ('All-Purpose Flour', 'Pantry', 'Unbleached all-purpose flour, 5 lb bag.', 3.99),
    ('Granulated Sugar', 'Pantry', 'Pure cane granulated sugar, 4 lb bag.', 3.79),
    ('Peanut Butter', 'Pantry', 'Creamy peanut butter, 16 oz jar.', 3.19),
    ('Rolled Oats', 'Pantry', 'Old-fashioned rolled oats, 18 oz canister.', 3.99),
    ('Honey', 'Pantry', 'Pure clover honey, 12 oz squeeze bottle.', 5.49),
    -- Snacks
    ('Tortilla Chips', 'Snacks', 'Lightly salted corn tortilla chips, 13 oz bag.', 3.99),
    ('Salted Almonds', 'Snacks', 'Roasted and salted almonds, 10 oz canister.', 6.49),
    ('Dark Chocolate Bar', 'Snacks', '70% cacao dark chocolate bar, 3.5 oz.', 2.99),
    ('Granola Bars', 'Snacks', 'Oats and honey granola bars, 8 count.', 3.69),
    -- Beverages
    ('Orange Juice', 'Beverages', 'Not-from-concentrate orange juice, 52 fl oz.', 4.49),
    ('Sparkling Water', 'Beverages', 'Unflavored sparkling water, 12 pack of 12 fl oz cans.', 5.99),
    ('Ground Coffee', 'Beverages', 'Medium roast ground coffee, 12 oz bag.', 8.49),
    ('Black Tea Bags', 'Beverages', 'English breakfast black tea, 40 count.', 3.99),
    -- Frozen
    ('Frozen Peas', 'Frozen', 'Garden peas, 12 oz bag.', 1.79),
    ('Vanilla Ice Cream', 'Frozen', 'Classic vanilla ice cream, 48 fl oz tub.', 5.49),
    ('Cheese Pizza', 'Frozen', 'Frozen thin-crust cheese pizza, 12 inch.', 6.99),
    -- Household
    ('Paper Towels', 'Household', 'Two-ply paper towels, 6 rolls.', 8.99),
    ('Dish Soap', 'Household', 'Lemon scented liquid dish soap, 20 fl oz.', 3.29)
ON CONFLICT (name) DO UPDATE
    SET category    = EXCLUDED.category,
        description = EXCLUDED.description,
        price       = EXCLUDED.price;

CREATE INDEX IF NOT EXISTS items_category_idx ON items (category);

COMMIT;

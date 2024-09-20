-- Cross Join
/*1. Suppose every vendor in the `vendor_inventory` table had 5 of each of their products to sell to **every** 
customer on record. How much money would each vendor make per product? 
Show this by vendor_name and product name, rather than using the IDs.

HINT: Be sure you select only relevant columns and rows. 
Remember, CROSS JOIN will explode your table rows, so CROSS JOIN should likely be a subquery. 
Think a bit about the row counts: how many distinct vendors, product names are there (x)?
How many customers are there (y). 
Before your final group by you should have the product of those two queries (x*y).  */

Q. For homework #5 question #1 (cross join), it asks how much money would each vendor make per product. Are we using vendor_inventory.original_price as the sale price per unit to calculate 

SELECT
	vendor_name,
	product_name,
	SUM(5 * original_price) AS [total sales]
FROM (
	SELECT
		vendor_name,
		product_name,
		original_price
	FROM vendor_inventory as vi
	JOIN vendor as v
		ON vi.vendor_id = v.vendor_id
	JOIN product as p
		ON vi.product_id = p.product_id	
	GROUP BY v.vendor_id, p.product_id
)
CROSS JOIN customer
GROUP BY vendor_name, product_name


-- INSERT
/*1.  Create a new table "product_units". 
This table will contain only products where the `product_qty_type = 'unit'`. 
It should use all of the columns from the product table, as well as a new column for the `CURRENT_TIMESTAMP`.  
Name the timestamp column `snapshot_timestamp`. */

DROP TABLE IF EXISTS product_units;

CREATE TABLE IF NOT EXISTS product_units AS
	SELECT *, CURRENT_TIMESTAMP AS snapshot_timestamp
	FROM product
	WHERE product.product_qty_type = 'unit'

/*2. Using `INSERT`, add a new row to the product_units table (with an updated timestamp). 
This can be any product you desire (e.g. add another record for Apple Pie). */

INSERT INTO product_units
	VALUES(24, 'Gummies', '125g', 3, 'unit', CURRENT_TIMESTAMP);

-- DELETE
/* 1. Delete the older record for the whatever product you added. 

HINT: If you don't specify a WHERE clause, you are going to have a bad time.*/

DELETE FROM product_units WHERE product_id = 24;

-- UPDATE
/* 1.We want to add the current_quantity to the product_units table. 
First, add a new column, current_quantity to the table using the following syntax.

ALTER TABLE product_units
ADD current_quantity INT;

Then, using UPDATE, change the current_quantity equal to the last quantity value from the vendor_inventory details.

HINT: This one is pretty hard. 
First, determine how to get the "last" quantity per product. 
Second, coalesce null values to 0 (if you don't have null values, figure out how to rearrange your query so you do.) 
Third, SET current_quantity = (...your select statement...), remembering that WHERE can only accommodate one column. 
Finally, make sure you have a WHERE statement to update the right row, 
	you'll need to use product_units.product_id to refer to the correct row within the product_units table. 
When you have all of these components, you can run the update statement. */

UPDATE product_units
SET current_quantity = inventory.quantity
FROM (
		/*
		 * Create a query of all product_id and their quantity.
		 *
		 * The query is a join of two tables:
		 *
		 * 1) A table of all product_id extracted from vendor_inventory and
		 *    product_units.
		 *
		 * 2) A table of all last known quantity from vendor_inventory
		 */
		SELECT pid.product_id, IFNULL(inventory.last_quantity, 0) as quantity
		FROM (
			/*
			 * Collect all product_id from vendor_inventory and product_units
			 * tables.
			 */
			SELECT DISTINCT product_id FROM vendor_inventory
			UNION
			SELECT DISTINCT product_id FROM product_units
		) pid
		LEFT JOIN (
			/*
			 * Collect last known quantity for all products in the
			 * vendor_inventory table
			 */
			SELECT product_id, quantity as last_quantity
			FROM (
				SELECT
					market_date,
					quantity,
					product_id,
					ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY market_date DESC) AS rank
				FROM vendor_inventory
				ORDER BY product_id, market_date DESC
			) x
			WHERE x.rank = 1
		) inventory
		ON pid.product_id = inventory.product_id
) AS inventory
WHERE product_units.product_id = inventory.product_id
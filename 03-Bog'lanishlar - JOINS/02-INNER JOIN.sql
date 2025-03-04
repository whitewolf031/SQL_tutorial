--Вывести наименование продукта(products), наименование компаниие из доставшиков(supliers), кол-во продукта в продаже (units_in_stock)
--product_name(products), company_name(supliers), sotuvga qo'yilgan tovarlar soni ni chiqaradigan sorov yozing!
SELECT product_name, suppliers.company_name, units_in_stock
FROM products
INNER JOIN suppliers ON products.supplier_id = suppliers.supplier_id
ORDER BY units_in_stock DESC;

-- Сколько единиц товаров в продаже по категории товаров 
-- Mahsulot toifalari bo'yicha sotuvda qancha birlik tovarlar bor
SELECT category_name, SUM(units_in_stock)
FROM products
INNER JOIN categories ON products.category_id = categories.category_id
GROUP BY category_name
ORDER BY SUM(units_in_stock) DESC
LIMIT 5;

-- Сколько единиц товаров в продаже по сумму товара денежном эквиваленте(SUM(unit_price * units_in_stock)) которое нет в продаже и сумму товара болше  5000 и  сортировка по убивание
-- Sotuvda bo'lmagan tovarlar umumiy narxini kategoriyasi bo'yicha chiqarish. Filter tovarlar umumiy narxini 5000 dan kichik va tartiblash kamayish bo'yicha!
SELECT category_name, SUM(unit_price * units_in_stock)
FROM products
INNER JOIN categories ON products.category_id = categories.category_id
WHERE discontinued <> 1
GROUP BY category_name
HAVING SUM(unit_price * units_in_stock) > 5000
ORDER BY SUM(unit_price * units_in_stock) DESC;


-- На каков работников завязаны закази. Вивести order_id, customer_id, last_name, title
-- Buyurtmalar qanday ishchilarga beriladi. order_id, customer_id, last_name, title ustunlarini chiqarish kerak
SELECT order_id, customer_id, first_name, last_name, title
FROM orders
INNER JOIN employees ON orders.employee_id = employees.employee_id;


-- Вывести дату когда был сделан заказ, название заказа, куда его надо доставить, цена заказа,  количество, скидка
-- Buyurtma qilingan sanani, buyurtmaning nomini, qayerga yetkazilishini, buyurtma narxini, miqdorini, chegirmalarini ko'rsating.
SELECT order_date, product_name, ship_country, unit_price, quantity, discount
FROM orders
INNER JOIN order_details ON orders.order_id = order_details.order_id
INNER JOIN products ON order_details.product_id = products.product_id;


-- Вывести contact_name, company_name, phone, first_name, last_name, title, order_date, product_name, ship_country, products.unit_price, quantity, discount , filter ship_country = 'USA'
SELECT contact_name, company_name, phone, first_name, last_name, title,
	order_date, product_name, ship_country, products.unit_price, quantity, discount
FROM orders
JOIN order_details ON orders.order_id = order_details.order_id
JOIN products ON order_details.product_id = products.product_id
JOIN customers ON orders.customer_id = customers.customer_id
JOIN employees ON orders.employee_id = employees.employee_id
WHERE ship_country = 'USA';

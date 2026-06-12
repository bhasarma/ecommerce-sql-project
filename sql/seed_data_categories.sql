INSERT INTO categories (
    category_id,
    parent_category_id,
    category_name,
    category_slug,
    category_description
)
VALUES
(1, NULL, 'Electronics', 'electronics', 'Electronic devices and accessories'),
(2, NULL, 'Fashion', 'fashion', 'Clothing, footwear, and accessories'),
(3, NULL, 'Home & Kitchen', 'home-kitchen', 'Products for home and kitchen'),
(4, NULL, 'Sports & Outdoors', 'sports-outdoors', 'Sports and outdoor equipment'),
(5, NULL, 'Books', 'books', 'Printed and digital books'),

(6, 1, 'Smartphones', 'smartphones', 'Mobile phones and accessories'),
(7, 1, 'Laptops', 'laptops', 'Personal and business laptops'),
(8, 1, 'Headphones', 'headphones', 'Wired and wireless headphones'),

(9, 2, 'Men Clothing', 'men-clothing', 'Clothing for men'),
(10, 2, 'Women Clothing', 'women-clothing', 'Clothing for women'),
(11, 2, 'Shoes', 'shoes', 'Footwear for all genders'),

(12, 3, 'Furniture', 'furniture', 'Home and office furniture'),
(13, 3, 'Kitchen Appliances', 'kitchen-appliances', 'Appliances for kitchen use'),

(14, 4, 'Fitness Equipment', 'fitness-equipment', 'Exercise and fitness products'),
(15, 4, 'Camping Gear', 'camping-gear', 'Camping and hiking equipment'),

(16, 5, 'Fiction', 'fiction', 'Fiction books and novels'),
(17, 5, 'Non-Fiction', 'non-fiction', 'Educational and informational books'),

(18, 6, 'Android Phones', 'android-phones', 'Smartphones running Android'),
(19, 6, 'iPhones', 'iphones', 'Apple smartphones'),
(20, 7, 'Gaming Laptops', 'gaming-laptops', 'High-performance gaming laptops');
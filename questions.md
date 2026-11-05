Migrations
1. Add following columns to the products
a. enabled(boolean), no default value
b. discount_price(decimal)
c. permalink(string)
2. Now change default value of enabled field to false
3. Add following to user
a. email(string)
4. Add following to cart
a. line_items_count(integer), default: 0, not null
5. Make form fields in the product creation form for:
a. enabled(checkbox),
b. discount_price(Input Field),
c. permalink(Input Field)
6. Make input field in user creation form for -
a. email
7. Revise irreversible migration, and make an example of irreversible migration
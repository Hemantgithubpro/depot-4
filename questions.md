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
https://blog.appsignal.com/2018/06/19/activerecords-counter-cache.html

5. Make form fields in the product creation form for:
a. enabled(checkbox),
b. discount_price(Input Field),
c. permalink(Input Field)
6. Make input field in user creation form for -
a. email
7. Revise irreversible migration, and make an example of irreversible migration

articles:
- https://www.theodinproject.com/lessons/ruby-on-rails-migrations
- https://www.railscarma.com/blog/rails-generate-migration-everything-you-need-to-know/
- https://guides.rubyonrails.org/active_record_migrations.html


Q7. Revise irreversible migration, and make an example of irreversible migration
Example of irreversible migration:
remove column without data type, (with data type, it is reversible)
then 
db:migrate will remove the column
and 
db:rollback will not be able to restore the column and its data.

```
remove_column :products, :discount_price
```
it'll remove the column, and when we rollback, it will not be able to restore the column and its data.
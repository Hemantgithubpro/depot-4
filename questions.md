# Migrations
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
- https://www.linkedin.com/pulse/what-permalink-seo-darlene-florrie-xaw0f/


Q7. Revise irreversible migration, and make an example of irreversible migration
Example of irreversible migration:
remove column without data type, (with data type, it is reversible)
then 
db:migrate will remove the column
and 
db:rollback will not be able to restore the column and its data.

```ruby
remove_column :products, :discount_price
```
it'll remove the column, and when we rollback, it will not be able to restore the column and its data.

# Validations
1. In the product model, add validations for the following:

1.1 Permalink
- should be unique
- no special characters or spaces allowed
- minimum 3 words, separated by hyphens

1.2 Price numericality validation should only run if price is present.

1.3 Description should be between 5 and 10 words

1.4 Validate image_url format by using url: true (ActiveModel::EachValidator)

1.5 price should be greater than discount price
- using a custom validator
- without a custom validator

2. LineItem model
- Combination of product_id and cart_id should be unique. A product can be
added only once to a cart.

3. Add following validations in user model
- Uniqueness of email
- Email format

articles:
- https://guides.rubyonrails.org/active_record_validations.html
- https://edgeapi.rubyonrails.org/classes/ActiveModel/EachValidator.html
- https://guides.rubyonrails.org/v6.0.0/active_record_validations.html
- https://stackoverflow.com/questions/923796/how-do-you-validate-uniqueness-of-a-pair-of-ids-in-ruby-on-rails
Rails API Practice
Purpose
This api will allow requests for various imported e-commerce data regarding:

Customers
Merchants
Invoices
Items
Transactions
Their relationships

Versions
Ruby: 2.4.1
Rails: 5.1.7

Configuration
Clone Repo
Run:
bundle install

Database Setup
Run:
rails db:{create,migrate}
rails import:data

Testing
Run:
 bundle exec rspec

> rails g scaffold UserType name:string 

> rails g scaffold User name:string username:string email:string password_digest:string user_type:references

References:
A references column is a shorthand way to add a column that will hold the ID of a related record. It also adds an index to this column by default. This is useful for creating associations between models.

Foreign Key:
A foreign_key constraint ensures that the value in the column must exist in the referenced table. This is a way to enforce referential integrity at the database level.

Key Differences: 
References: Adds a column and an index, and optionally a foreign key constraint, in a single line.
Foreign Key: Specifically adds a foreign key constraint to an existing column.

# Rspec
1. Add gem to development env
  gem 'rspec-rails' 
2. init rspec in project: 
  > rails generate rspec:install
3. generate UserType model test structure
  > rails generate rspec:model UserType
4. run tests 
  > rspec spec/models/user_type_spec.rb

# secure password 
https://medium.com/geekculture/rails-magic-has-secure-password-a9bf0167642d 

# associations 
belongs_to holds the foreign key.
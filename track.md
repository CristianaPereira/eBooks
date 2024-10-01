> rails g scaffold UserType name:string 

> rails g scaffold User name:string username:string email:string password_digest:string user_type:references

> rails g scaffold Orders status:string user:references ebook:references total:decimal

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

# use namesapaces 

1. add gem "rack-cors"

2. setup cors 


# as_json vs to_json

- to_json is a wrapper that includes our as_json option.

- as_json
  - method is used to customize the JSON representation of an object. It returns a hash that represents the object in a JSON-compatible format
  - Customization: can be override to exculde certain attributes or add custom ones 
  - Return Type: Returns a hash, not a JSON string.

- to_json
  - is a wrapper around as_json that calls as_json internally and then converts the resulting hash into a JSON strin
  - Customization: Customizations made in as_json will be reflected in to_json since to_json relies on as_json.
  - Return Type: Returns a JSON string.

Summary: 
- Use as_json when you need to customize the JSON representation of an object or when you need a JSON-compatible hash.
- Use to_json when you need the final JSON string representation of an object, often for rendering JSON responses in controllers.


# Sessions 
- https://www.writesoftwarewell.com/rails-sessions/
- https://github.com/rails/activerecord-session_store 
- https://www.justinweiss.com/articles/how-rails-sessions-work/?ref=writesoftwarewell.com

- You can access sessions in only two places: controllers and views 

- if already logged in? https://stackoverflow.com/a/18263884/4801486

> rails g scaffold company name:string user:references

> rails g scaffold Ebook name:string status:integer seller:references


# filters
https://medium.com/@albertohernndezcerezo/what-will-you-learn-75bbea738fc


# services 
https://medium.com/@thilorusche/service-objects-for-rails-9c5973dc8bc2 
# Quotes

Quotes is a Sinatra application for browsing and submitting IRC quotes. Quotes is designed to be simple and beautiful.

## Features

* Live preview when submitting a quote
* Voting up and down
* Consistent, colourised nicknames for enhancing conversation flow
* Automatic converting for ‘single’ and “double” typographic quotes
* Compliant XHTML, CSS and unobtrusive JavaScript
* Small footprint

## Example

[See a live example of Quotes](http://quotes.tatey.com)

## Dependancies

### Required

* Ruby
* RubyGems
* Sinatra (0.9.4)
* Sequel (3.5.0)

### Optional

Quotes is distributed with an SQLite database containing sample data for development.

* SQLite3
* sqlite3-ruby (1.2.4)

## Setup

### Using database distributed with Quotes

Copy database.yml.example and rename database.yml.

### New database

Create the database and run the migration.

    $ sequel -m db/migrate sqlite:///db/database.db
    
Copy database.yml.example and rename database.yml. Update database.yml. See [Sequel documentation](http://sequel.rubyforge.org/rdoc/files/doc/opening_databases_rdoc.html) for a valid list of URIs. 
    
    development:
      uri: sqlite://db/database.db

## Usage

    $ ruby application.rb

## Authors

* [Tate Johnson](http://tatey.com) (Ruby, JavaScript, XHTML, CSS)
* [Pascal Klein](http://klepas.org) (Design)

## License

Quotes is released under the MIT license. See LICENSE.

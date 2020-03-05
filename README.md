# Postcode Checker

## Technologies

* Rails 6.0.2.1
* Ruby 2.7.0
* Postgres
* RSpec for unit tests
* Capybara for feature tests

## Getting Started

Download the project and navigate to the project root.

Bundle Ruby gems

```
bundle install
```

You will need a local instance of Postgres running.

Using database.yml.example as a template, configure Postgres as follows:

Copy this file without the .example extension, i.e., database.yml and add your postgress credentials.

Create and seed the database with the following commmand. This creates the postcode whitelist with the SH24 1AA and SH24 1AB postcodes.

```
rake db:setup
```

The lsoa whitelist is configured via an env var LSOA_WHITELIST

The service calling the postcodes.io API is configured via an env var POSTCODES_IO_API_URL

The contents of env.yml.example are good to go, you just need to make a copy of the file renaming it as env.yml


Start the rails server:

```
rails server
```

Open browser to http://localhost:3000

You can manage the postcode whitelist from:

http://localhost:3000/postcodes

## Testing

To execute unit tests:

```
bundle exec rspec
```

## Next steps

Regex validation when adding to the posctode whitelist. Should really only accept alpha numberic and space content.

Suppression of warnings emitted by Ruby 2.7
# Sample Blog

![CI](https://github.com/HarvestProfit/sample-blog/workflows/CI Suite/badge.svg)

Incredibly simple api-only blog!

This blog is super simple - it allows you to submit blog posts to the server, and can render them in an API.

## Consuming the API

We have some simple documentation on how to [consume this API](https://documenter.getpostman.com/view/2582145/TzCQbn5S).

## Development

This project was scaffolded with rails.

### Prerequisites
Please install the following:
- [Ruby](https://www.ruby-lang.org/en/downloads/)
  - Feel free to use [RVM](https://rvm.io/) or [Rbenv (recommended)](https://github.com/rbenv/rbenv) for version management
- [Postgres.app](https://postgresapp.com/)

In order to run the project in development, you'll need to install the
required RubyGems and set up your Postgres database:

```bash
bundle install
rails db:setup
```

Then you can start your local server with `rails server` (or `rails s` for short).

## License

This project is [MIT Licensed](./LICENSE.md).

## Deploy to Heroku
[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

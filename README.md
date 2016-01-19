# Streamline

**Important! It's still early proof-of-concept. Use it on your own risk ;)**

Streamline allows you to organize event-based behavior of your app way more simpler.

[![Gem Version](https://badge.fury.io/rb/streamline.svg)](https://badge.fury.io/rb/streamline)
[![Code Climate](https://codeclimate.com/github/atipugin/streamline/badges/gpa.svg)](https://codeclimate.com/github/atipugin/streamline)
[![Build Status](https://travis-ci.org/atipugin/streamline.svg?branch=master)](https://travis-ci.org/atipugin/streamline)

## Installation

Add to your Gemfile:

```ruby
gem 'streamline'
```

And then execute:

```shell
$ bundle
```

Or install it system-wide:

```
$ gem install streamline
```

## Setup

First of all, you have to select a [data store](#data-stores) for your events. Let's take ActiveRecord store for example:

```shell
$ rails generate streamline:stores:active_record
```

It will generate all neccessary files (a model and migration file in this case).

Next, you need to configure ActiveJob adapter (if you haven't done it yet). Streamline uses background jobs a lot and usage of ActiveJob allows us to support [as many queuing backends as possible](http://edgeguides.rubyonrails.org/active_job_basics.html#backends).

Imagine your app already uses Sidekiq. Just add the following line to your `application.rb`:

```ruby
config.active_job.queue_adapter = :sidekiq
```

Then add `streamline` queue to your `sidekiq.yml`.

You're almost done! It's time to set up handlers and track some events.

## Handlers

...

## Event tracking

...

## Data stores

Streamline supports following event stores:

- ActiveRecord (PostgreSQL, MySQL, SQLite etc)

## Contributing

1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request

# README

This is an example app for https://github.com/hauska7/rbrt . Ultimately it is supposed to be a hacker news clone but currently it is a simplified version.

* Description
  Rbrt is a business logic framework for ruby it makes it easier to write business logic then using pure ruby but is still so lightweight that your tests will run blazingly fast.

  This example application is a Rails app but when running rspec tests for use cases Rails will not be loaded so we can say that business logic is not coupled with Rails just interacting with it through interfaces that can be mocked for testing.

  The most important directories would be app/use_cases and app/domain. Also app/queries/queries.rb is crucial for querying both in specs and in live application. app/persistance/persistance.rb would be used for live persistance and spec/doubles/persistance_double.rb would be used in specs.
app/domain contains domain objects much of creating an object handles app/domain/domain_builder.rb which extends domain objects with rbrt modules eg. to make it possible to associate objects.

* Setup

  $ docker-compose build
  $ docker-compose run --rm web bash
  $ rake db:create
  $ rake db:schema:load
  $ exit
  $ docker-compose run --rm --service-ports web
  Browse to localhost:3000

* How to run the test suite

  $ docker-compose run --rm web bash
  $ rspec spec/use_cases

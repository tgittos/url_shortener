# README

## Requirements

This application requires:

* Ruby 2.4.1
* Rails 5.2.1
* Postgres 10.5

## Database Setup

To set up the database, log into your Postgres server using `psql` and run:
`create role url_shortener with createdb login password 'password';`

Once the role has been created, create the db and migrate it with:
`rake db:create`
`rake db:migrate`

## Tests

There is a suite of model, controller and lib tests. The entire test suite can be run with:
`rails test`

## Deployment

This application has never been deployed. However, depending on the scalability desired, it might be deployed as follows:

* The Postgres server can be run on it's own host, possibly sharded if desired.
* This Rails app could be containerized using `docker` or `vagrant`. This would allow horizontal scaling on demand as loads increase.
* The application can be set up behind Kubernetes for container management and load balancing
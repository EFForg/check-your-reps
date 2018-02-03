# Check Your Reps

A platform for congressional scorecards.

## Development

You will need Ruby 2.3.1, Node 6.0.0+, Yarn, and Postgres. Then run:

1. Install packages:
  * `sudo apt-get libpq-dev`
  * `gem install bundler`
  * `bundle install`
  * `yarn install`

2. Add your database credentials:
  * `cp .env.example .env`
  * Fill in postgres username and password

3. Create the default admin user and import Congress members.
  * `rake db:seed`
  * `rake reps:update`

4. `rails s`

You should now be able to login with the default admin credentials:
* User: admin@example.com
* Password: password

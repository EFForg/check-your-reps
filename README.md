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
  * `rake congress:update`

4. `rails s`

You should now be able to login with the default admin credentials:
* User: admin@example.com
* Password: password

You can run all tests and linters with `rake test`.

## Managing content

### Adding admin users
1. Visit [checkyourreps.org/admin/admin_users](https://checkyourreps.org/admin/admin_users)
2. Click "New Admin User" in the top righthand corner.

### Managing scores
1. Visit [checkyourreps.org/admin](https://checkyourreps.org/admin) and enter your username and password.
2. In the top navigation bar, click "Scores".
3. To add a new score, click "New Score" in the top righthand corner.
4. To edit an existing score, find it in the list of scores, hover over the three dots on the righthand side, and click "edit".

# Check Your Reps

A platform for congressional scorecards.

## Development

These instructions run Rails natively on the host and Postgres in a Docker container.

You will need Ruby 2.3.1, Node 6.0.0, Docker, and Docker Compose. Then run:
```
cp .env.example .env
docker-compose up -d
bundle install
rails s
```

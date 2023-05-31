# README

 ```bash
git clone ...
cd ...
cp .env.sample .env
docker compose build
docker compose run --rm web rails db:prepare
docker compose run --rm -e RAILS_ENV=test web rails db:prepare
docker compose up
```

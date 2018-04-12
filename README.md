# PSUPRO
Career orientation for students.

## Components

The system architecture is based on the following components:

* PSQL DB
* Elasticsearch cluster
* [RoR JSON REST API](./api/README.md)
* [Vue.js webapp](./front-vue/README.md)

There is also two deprecated components:

* [Flask Machine Learing micro-service](./scores-ms/README.md)
* [React.js webapp](./front/README.md)

## Development

For local development we use `docker-compose` to easily emulate the production environment and build all components.

### Set up

First you must install docker and docker-compose. Then run:

```bash
sudo docker-compose build
```

And we run our server to check everything is working:

```bash
sudo docker-compose up
```

If elastic search crashes the following command might fix it:

```bash
sudo sysctl -w vm.max_map_count=262144
```

Then set up the database.

```bash
sudo docker-compose run api rails db:migrate
sudo docker-compose run api rails db:seed
```

And set up the search indexes.

```bash
sudo docker-compose run api rails  searchkick:reindex CLASS=University
sudo docker-compose run api rails  searchkick:reindex CLASS=Carreer
```

Now we run the server again and everything should be running.

## Deployment
TODO
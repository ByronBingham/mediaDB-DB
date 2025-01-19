# mediaDB-DB

## Docker Usage

The pipeline for this repo will generate a docker image. The only requirements to run this image is that `/db_config.json` must be mounted to `/db/db_config.json` the first time the container is run and the Postgres admin password env var `POSTGRES_PASSWORD` must be set. Otherwise, this image can be run with normally with `docker run ...` or a docker compose file.

### Behavior

#### First Time Run

The first time you run this container, Postgres will not have any tables or data and must be initialized. This container provides an initialization layer on top of the official Postgres docker image, and can initialize the media DB with a simple JSON config. This config must be mounted to `/db/db_config.json`. The `exampleDatabase.json` file in this repo gives an example of how `db_config.json` should look.

As part of the Postgres container initialization, the container environment variable `POSTGRES_PASSWORD` must be set. This only needs to be done the first time running the container.

Lastly, you will need to set a volume for the container to store the DB data on the host machine. This can be done by setting a volume to point to `/var/lib/postgresql/data` on the container.

#### After Initialization

After the first run initializes the DB, you do not need to specify the JSON config file or the postgres password variable. If the config file is mounted, Postgres will just ignore the .sql script that the initialization layer generates. The Postgres data volume still needs mounted every time so that Postgres remembers its settings and data between container stops/starts.

## Local Usage

### Building

The media DB image can be built using the following command:

```docker build .```

### Running

Use the following command to initialize and run the container:

```docker run -v /d/Documents/_Programming/_GitRepos/mediaDB-DB/db_config.json -p 5433:5432 -v [host data path]:/var/lib/postgresql/data -e POSTGRES_PASSWORD=letmein [image ID]```

The image ID can be found using `docker image ls`.

Use the following command to run the container after it has been previously initialized:

```docker run-p 5433:5432 -v [host data path]:/var/lib/postgresql/data [image ID]```
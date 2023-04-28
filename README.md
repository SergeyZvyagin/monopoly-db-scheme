# monopoly-db-scheme
The database scheme for the Monopoly Game

This repository is the working space for the [pgmigrate](https://github.com/yandex/pgmigrate/blob/master/doc/tutorial.md) migration system.

## Prepare
Need to prepare the database before applying the migration for the first time as follows:
    CREATE DATABASE monopolydb;
	CREATE ROLE mp_client WITH LOGIN PASSWORD 'mp_password';
	GRANT ALL ON DATABASE monopolydb TO mp_client;
## Using
    $ pgmigrate -c 'host=127.0.0.1' -t latest migrate



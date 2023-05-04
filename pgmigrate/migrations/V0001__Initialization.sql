CREATE TABLE users (
		id serial NOT NULL,
		nickname varchar(16) NOT NULL DEFAULT 'Player',
		vk_id int,
		google_id int,
		is_guest bool NOT NULL DEFAULT true,
		rating int NOT NULL DEFAULT 0,
		games_played int NOT NULL DEFAULT 0,
		games_won int NOT NULL DEFAULT 0,
		created_at timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
		last_refresh_at timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
		---------------------------------------------------------
		CONSTRAINT users__pkey PRIMARY KEY (id),
		CONSTRAINT users__vk_id__unique UNIQUE (vk_id)
);


CREATE TABLE lobby_types (
		id serial NOT NULL,
		name varchar(8) NOT NULL,
		-------------------
		CONSTRAINT lobby_types__pkey PRIMARY KEY (id),
		CONSTRAINT lobby_types__name__unique UNIQUE (name)
);

INSERT INTO lobby_types (name) VALUES ('PUBLIC');
INSERT INTO lobby_types (name) VALUES ('PRIVATE');
INSERT INTO lobby_types (name) VALUES ('RANKED');


CREATE TABLE victory_types (
		id serial NOT NULL,
		name varchar(8) NOT NULL,
		-------------------------
		CONSTRAINT victory_types__pkey PRIMARY KEY (id),
		CONSTRAINT victory_types__name__unique UNIQUE (name)
);

INSERT INTO victory_types (name) VALUES ('SCORE');
INSERT INTO victory_types (name) VALUES ('TURN');
INSERT INTO victory_types (name) VALUES ('BOTH');


CREATE TABLE lobbies (
		id serial NOT NULL,
		owner_id int not NULL,
		name varchar(32) NOT NULL,
		lobby_type int NOT NULL DEFAULT 1,
		password varchar(16),
		max_players smallint NOT NULL DEFAULT 6,
		time_for_turn smallint NOT NULL DEFAULT 8,
		victory_type int NOT NULL DEFAULT 1,
		score_victory_value int DEFAULT 2000,
		turn_victory_value int DEFAULT 72,
		is_running bool NOT NULL DEFAULT false,
		game_address varchar(32),
		game_port int,
		------------------------------------------
		CONSTRAINT lobbies__pkey PRIMARY KEY (id),
		CONSTRAINT lobbies__owner_id__fkey FOREIGN KEY (owner_id) REFERENCES users(id),
		CONSTRAINT lobbies__lobby_type__fkey FOREIGN KEY (lobby_type) REFERENCES lobby_types(id),
		CONSTRAINT lobbies__victory_type__fkey FOREIGN KEY (victory_type) REFERENCES victory_types(id)		
);


CREATE TABLE player_states (
		id serial NOT NULL,
		name varchar(16) NOT NULL,
		-------------------------
		CONSTRAINT player_states__pkey PRIMARY KEY (id),
		CONSTRAINT player_states__name__unique UNIQUE (name)
);

INSERT INTO player_states (name) VALUES ('NOT READY');
INSERT INTO player_states (name) VALUES ('READY');
INSERT INTO player_states (name) VALUES ('LOST');
INSERT INTO player_states (name) VALUES ('IN GAME');


CREATE TABLE players_in_lobbies (	
		player_id int NOT NULL,
		lobby_id int NOT NULL,
		player_state int not NULL DEFAULT 1,
		last_action_at timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
		---------------------------------------------------------
		CONSTRAINT players_in_lobbies__player_id__unique UNIQUE (player_id),
		CONSTRAINT players_in_lobbies__lobby_id__fkey FOREIGN KEY (lobby_id) REFERENCES lobbies(id) ON DELETE CASCADE,
		CONSTRAINT players_in_lobbies__player_id__fkey FOREIGN KEY (player_id) REFERENCES users(id) ON DELETE CASCADE,
		CONSTRAINT players_in_lobbies__player_state__fkey FOREIGN KEY (player_state) REFERENCES player_states(id)
);

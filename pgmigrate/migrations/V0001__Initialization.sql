CREATE TABLE users (
		id serial NOT NULL,
		nickname varchar(32) NOT NULL,
		vk_id int,
		is_guest bool NOT NULL DEFAULT true,
		rating int NOT NULL DEFAULT 0,
		games_played int NOT NULL DEFAULT 0,
		games_won int NOT NULL DEFAULT 0,
		created_at timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
		last_action_at timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
		---------------------------------------------------------
		CONSTRAINT users_pkey PRIMARY KEY (id),
		CONSTRAINT users_vk_id_unique UNIQUE (vk_id)
);

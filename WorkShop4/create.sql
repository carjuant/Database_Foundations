CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE users (
	id_number UUID DEFAULT uuid_generate_v4 () PRIMARY KEY,
	musical_genre_fk int NOT NULL,
	contry_fk int NOT NULL,
	name varchar (50) NOT NULL,
	email varchar (30) UNIQUE,
	phone varchar (50),
	nickname varchar (20) UNIQUE NOT NULL,
	password varchar (30) NOT NULL,
	FOREIGN KEY (musical_genre_fk)
	REFERENCES musicalGenre(id_genre),
	FOREIGN KEY (contry_fk)
	REFERENCES country(code)
);

CREATE TABLE community(
	id_community SERIAL PRIMARY KEY,
	description varchar (200)
);

CREATE TABLE community_user_REL(
	community_fk int REFERENCES community(id_community),
	user_fk UUID REFERENCES users(id_number),
	expiration_date int,
	PRIMARY KEY (community_fk,user_fk)
);


CREATE TABLE country (
	code int PRIMARY KEY,
	name varchar(25) UNIQUE NOT NULL
);



CREATE TABLE musicalGenre (
	id_genre SERIAL PRIMARY KEY,
	name varchar(15) NOT NULL,
	description varchar(100)
);

CREATE TABLE channel (
	id_channel SERIAL PRIMARY KEY,
	user_fk UUID,
	name varchar(30) NOT NULL,
	description varchar (200),
	FOREIGN KEY (user_fk)
	REFERENCES users(id_number)
);

CREATE TABLE suscriber_REL(
	user_fk UUID REFERENCES users(id_number),
	channel_fk int REFERENCES channel(id_channel),
	pay bool DEFAULT FALSE,
	pat_coast float,
	date_suscriptions int NOT NULL,
	PRIMARY KEY (user_fk,channel_fk)	
);


CREATE TABLE playlist (
	id_playlist SERIAL PRIMARY KEY,
	user_fk UUID,
	name varchar (30) NOT NULL,
	likes int DEFAULT 0,
	FOREIGN KEY (user_fk)
	REFERENCES users(id_number)
);

CREATE TABLE playlist_video_REL(
	playlist_fk int REFERENCES playlist(id_playlist),
	video_fk int REFERENCES video(id_videos),
	PRIMARY KEY (playlist_fk,video_fk)
);

CREATE TABLE video (
	id_videos SERIAL PRIMARY KEY,
	user_fk UUID,
	genre_fk int,
	channel_fk int,
	name varchar (100) NOT NULL,
	description varchar (200),
	date_upload INT NOT NULL,
	likes int DEFAULT 0,
	dislikes int DEFAULT 0,
	FOREIGN KEY (user_fk)
	REFERENCES users(id_number),
	FOREIGN KEY (genre_fk)
	REFERENCES musicalGenre(id_genre),
	FOREIGN KEY (channel_fk)
	REFERENCES channel(id_channel)
);

CREATE TABLE comment (
	id_comment SERIAL PRIMARY KEY,
	user_fk UUID,
	video_fk int,
	date_creation int NOT NULL,
	likes int DEFAULT 0,
	dislikes int DEFAULT 0,
	FOREIGN KEY (user_fk)
	REFERENCES users(id_number),
	FOREIGN KEY (video_fk)
	REFERENCES video(id_videos)
);


CREATE TABLE bankAccount (
	account_number INT PRIMARY KEY,
	user_fk UUID,
	country_fk  int,
	bank_name varchar (30) NOT NULL,
	FOREIGN KEY (user_fk)
	REFERENCES users(id_number),
	FOREIGN KEY (country_fk)
	REFERENCES country(code)
);
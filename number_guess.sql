--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE numbers_game;
--
-- Name: numbers_game; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE numbers_game WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE numbers_game OWNER TO freecodecamp;

\connect numbers_game

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: games; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.games (
    user_id integer NOT NULL,
    game_id integer NOT NULL,
    guesses integer NOT NULL
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.games_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_game_id_seq OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(22)
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES (1, 1, 5);
INSERT INTO public.games VALUES (1, 2, 15);
INSERT INTO public.games VALUES (1, 3, 23);
INSERT INTO public.games VALUES (2, 4, 83);
INSERT INTO public.games VALUES (2, 5, 48);
INSERT INTO public.games VALUES (1, 6, 9);
INSERT INTO public.games VALUES (5, 7, 895);
INSERT INTO public.games VALUES (5, 8, 662);
INSERT INTO public.games VALUES (6, 9, 795);
INSERT INTO public.games VALUES (6, 10, 877);
INSERT INTO public.games VALUES (5, 11, 712);
INSERT INTO public.games VALUES (5, 12, 984);
INSERT INTO public.games VALUES (5, 13, 984);
INSERT INTO public.games VALUES (1, 14, 12);
INSERT INTO public.games VALUES (7, 15, 478);
INSERT INTO public.games VALUES (7, 16, 525);
INSERT INTO public.games VALUES (8, 17, 539);
INSERT INTO public.games VALUES (8, 18, 644);
INSERT INTO public.games VALUES (7, 19, 283);
INSERT INTO public.games VALUES (7, 20, 434);
INSERT INTO public.games VALUES (7, 21, 979);
INSERT INTO public.games VALUES (9, 22, 737);
INSERT INTO public.games VALUES (9, 23, 939);
INSERT INTO public.games VALUES (10, 24, 452);
INSERT INTO public.games VALUES (10, 25, 727);
INSERT INTO public.games VALUES (9, 26, 808);
INSERT INTO public.games VALUES (9, 27, 863);
INSERT INTO public.games VALUES (9, 28, 397);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (1, 'Eirik');
INSERT INTO public.users VALUES (2, 'James');
INSERT INTO public.users VALUES (3, 'Fred');
INSERT INTO public.users VALUES (4, 'George');
INSERT INTO public.users VALUES (5, 'user_1712059023042');
INSERT INTO public.users VALUES (6, 'user_1712059023041');
INSERT INTO public.users VALUES (7, 'user_1712059117913');
INSERT INTO public.users VALUES (8, 'user_1712059117912');
INSERT INTO public.users VALUES (9, 'user_1712059168347');
INSERT INTO public.users VALUES (10, 'user_1712059168346');


--
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.games_game_id_seq', 28, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 10, true);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: games fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--


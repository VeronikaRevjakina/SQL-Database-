--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.4
-- Dumped by pg_dump version 9.5.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: main_titles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE main_titles (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    title_duration smallint NOT NULL,
    level_of_prestige smallint NOT NULL,
    CONSTRAINT main_titles_level_of_prestige_check CHECK (((level_of_prestige >= 1) AND (level_of_prestige <= 10))),
    CONSTRAINT main_titles_name_check CHECK (((name)::text ~ similar_escape('(A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z)%'::text, NULL::text))),
    CONSTRAINT main_titles_title_duration_check CHECK (((title_duration >= 1) AND (title_duration <= 10)))
);


ALTER TABLE main_titles OWNER TO postgres;

--
-- Name: main_titles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE main_titles_id_seq
    START WITH 33
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE main_titles_id_seq OWNER TO postgres;

--
-- Name: main_titles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE main_titles_id_seq OWNED BY main_titles.id;


--
-- Name: specialization_sportsmen; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE specialization_sportsmen (
    id integer NOT NULL,
    sportsman_id integer NOT NULL,
    type_of_exercise_id smallint NOT NULL
);


ALTER TABLE specialization_sportsmen OWNER TO postgres;

--
-- Name: specialization_sportsmen_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE specialization_sportsmen_id_seq
    START WITH 54
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE specialization_sportsmen_id_seq OWNER TO postgres;

--
-- Name: specialization_sportsmen_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE specialization_sportsmen_id_seq OWNED BY specialization_sportsmen.id;


--
-- Name: sportsmen; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sportsmen (
    id integer NOT NULL,
    number_base_fsi integer NOT NULL,
    last_name character varying(50) NOT NULL,
    name character varying(50) NOT NULL,
    middle_name character varying(50),
    date_of_birth date NOT NULL,
    team_id smallint NOT NULL,
    CONSTRAINT sportsmen_date_of_birth_check CHECK ((date_of_birth <= (('now'::text)::date - 5110))),
    CONSTRAINT sportsmen_last_name_check CHECK ((initcap((last_name)::text) = (last_name)::text)),
    CONSTRAINT sportsmen_middle_name_check CHECK ((initcap((middle_name)::text) = (middle_name)::text)),
    CONSTRAINT sportsmen_name_check CHECK ((initcap((name)::text) = (name)::text)),
    CONSTRAINT sportsmen_number_base_fsi_check CHECK (((length(((number_base_fsi)::character varying)::text) >= 5) AND (length(((number_base_fsi)::character varying)::text) <= 6)))
);


ALTER TABLE sportsmen OWNER TO postgres;

--
-- Name: sportsmen_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sportsmen_id_seq
    START WITH 21
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sportsmen_id_seq OWNER TO postgres;

--
-- Name: sportsmen_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sportsmen_id_seq OWNED BY sportsmen.id;


--
-- Name: teams; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE teams (
    id smallint NOT NULL,
    name_of_country character varying(30) NOT NULL,
    captain_id smallint,
    CONSTRAINT teams_name_capital_of_country_check CHECK ((initcap((name_of_country)::text) = (name_of_country)::text)),
    CONSTRAINT teams_official_name_of_country_check CHECK ((((name_of_country)::text !~~ 'Russia'::text) AND ((name_of_country)::text !~~ 'USA'::text) AND ((name_of_country)::text !~~ 'China'::text) AND ((name_of_country)::text !~~ 'Holland'::text) AND ((name_of_country)::text !~~ 'England'::text)))
);


ALTER TABLE teams OWNER TO postgres;

--
-- Name: teams_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE teams_id_seq
    START WITH 10
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE teams_id_seq OWNER TO postgres;

--
-- Name: teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE teams_id_seq OWNED BY teams.id;


--
-- Name: titles_of_sportsmen; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE titles_of_sportsmen (
    id integer NOT NULL,
    sportsman_id integer NOT NULL,
    title_id integer NOT NULL
);


ALTER TABLE titles_of_sportsmen OWNER TO postgres;

--
-- Name: titles_of_sportsmen_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE titles_of_sportsmen_id_seq
    START WITH 79
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE titles_of_sportsmen_id_seq OWNER TO postgres;

--
-- Name: titles_of_sportsmen_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE titles_of_sportsmen_id_seq OWNED BY titles_of_sportsmen.id;


--
-- Name: types_of_exercises; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE types_of_exercises (
    id smallint NOT NULL,
    name character varying(50) NOT NULL,
    description text NOT NULL,
    year_of_introduction smallint NOT NULL,
    duration_in_seconds smallint,
    CONSTRAINT types_of_exercises_duration_in_seconds_check CHECK (((duration_in_seconds >= 30) AND (duration_in_seconds <= 120))),
    CONSTRAINT types_of_exercises_name_check CHECK ((lower((name)::text) = (name)::text)),
    CONSTRAINT types_of_exercises_year_of_introduction_check CHECK (((year_of_introduction >= 1895) AND ((year_of_introduction)::numeric <= to_number(to_char((('now'::text)::date)::timestamp with time zone, 'YYYY'::text), '9999'::text))))
);


ALTER TABLE types_of_exercises OWNER TO postgres;

--
-- Name: types_of_exercises_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE types_of_exercises_id_seq
    START WITH 7
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE types_of_exercises_id_seq OWNER TO postgres;

--
-- Name: types_of_exercises_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE types_of_exercises_id_seq OWNED BY types_of_exercises.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY main_titles ALTER COLUMN id SET DEFAULT nextval('main_titles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY specialization_sportsmen ALTER COLUMN id SET DEFAULT nextval('specialization_sportsmen_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sportsmen ALTER COLUMN id SET DEFAULT nextval('sportsmen_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY teams ALTER COLUMN id SET DEFAULT nextval('teams_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY titles_of_sportsmen ALTER COLUMN id SET DEFAULT nextval('titles_of_sportsmen_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY types_of_exercises ALTER COLUMN id SET DEFAULT nextval('types_of_exercises_id_seq'::regclass);


--
-- Data for Name: main_titles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY main_titles (id, name, title_duration, level_of_prestige) FROM stdin;
1	All-around champion of the Olympic games 	4	10
2	All-around vice champion of the Olympic games 	4	8
3	Bronze medalist of the Olympic games in all-around competition	4	6
4	World Champion in all-around competition	1	9
5	Vice World Champion 	1	7
6	Bronze medalist of the World Cup	1	5
7	European champion	1	4
8	Vice European champion	1	3
9	Bronze medalist of the European championship	1	2
10	Champion of the P&G Gymnastics Championships	1	4
11	Vice Championof the  P&G Gymnastics Championships	1	3
12	Champion of the Indo-Chinese games	2	4
13	European games champion	4	4
14	Champion of the Olympic games in team 	4	10
15	Champion of the Olympic games on vault	4	9
16	Champion of the Olympic games on beam	4	9
17	Champion of the Olympic games on uneven bars	4	9
18	Champion of the Olympic games on floor exersises	4	9
19	Vice Champion of the Olympic games in team	4	6
20	Vice Champion of the Olympic games on vault	4	6
21	Vice Champion of the Olympic games on beam	4	6
22	Vice Champion of the Olympic games on floor exersises	4	6
23	Bronze medalist of the Olympic games in team	4	5
24	Bronze medalist of the Olympic games on vault	4	4
25	Bronze medalist of the Olympic games on beam	4	4
26	Bronze medalist of the Olympic games on uneven bars	4	4
27	Bronze medalist of the Olympic games on floor exersises	4	4
28	World Champion in team competition 	1	8
29	World Champion on vault	1	7
30	World Champion on beam	1	7
31	World Champion on uneven bars	1	7
32	World Champion on floor exersises	1	7
\.


--
-- Name: main_titles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('main_titles_id_seq', 33, false);


--
-- Data for Name: specialization_sportsmen; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY specialization_sportsmen (id, sportsman_id, type_of_exercise_id) FROM stdin;
1	1	1
2	1	2
3	1	3
4	1	4
5	1	5
6	1	6
7	2	1
8	2	3
9	3	1
10	3	2
11	4	1
12	4	2
13	4	4
14	5	1
15	5	5
16	6	1
17	6	2
18	6	3
19	6	4
20	6	6
21	7	1
22	7	2
23	7	4
24	7	6
25	8	1
26	8	2
27	9	1
28	9	5
29	10	1
30	10	6
31	11	1
32	11	2
33	11	3
34	11	6
35	12	1
36	13	1
37	13	2
38	13	5
39	14	1
40	14	4
41	15	6
42	15	3
43	15	2
44	16	4
45	17	1
46	17	6
47	18	5
48	19	4
49	19	6
50	19	1
51	20	1
52	20	2
53	20	4
\.


--
-- Name: specialization_sportsmen_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('specialization_sportsmen_id_seq', 54, false);


--
-- Data for Name: sportsmen; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sportsmen (id, number_base_fsi, last_name, name, middle_name, date_of_birth, team_id) FROM stdin;
1	123455	Mustafina	Aliya	Farghatovna	1994-09-30	1
2	223456	Paseka	Maria	Valerievna	1995-07-19	1
3	123557	Melnikova	Angelina	Romanovna	2000-07-18	1
4	123458	Tuthalan	Seda	Gurgenovna	1999-07-15	1
5	123459	Spiridonova	Daria	Sergeevna	1998-07-08	1
6	123460	Biles	Simona	\N	1997-03-14	2
7	223461	Alexandra	Raisman	Rose	1994-05-25	2
8	123462	Douglas	Gabrielle	Victoria	1995-12-31	2
9	123463	Kocian	Madison	Taylor	1997-06-15	2
10	123464	Hernandez	Lauren	 Zoe	2000-06-09	2
11	123465	Van	Yen	\N	1999-10-30	3
12	123466	Yi	Mao	\N	1999-09-16	3
13	423467	Chunsong	Shang	\N	1996-03-18	3
14	123468	Yilin	Fan	\N	1999-11-11	3
15	323469	Steingruber	Giulia	\N	1994-03-24	4
16	123470	Wevers	Sanne	\N	1991-09-17	5
17	123471	Tinkler	Amy	Rose	1999-10-27	7
18	123472	Scheder	Sophie	Celina	1997-01-07	8
19	123473	Saraiva	Flavia	Lopes	1999-09-30	9
20	123484	Ponor	Catalina	\N	1987-08-20	6
\.


--
-- Name: sportsmen_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sportsmen_id_seq', 21, false);


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY teams (id, name_of_country, captain_id) FROM stdin;
1	Russian Federation	1
2	United States Of America	6
3	People"S Republic Of China	13
4	Switzerland	15
5	Netherlands	\N
6	Romania	\N
7	Great Britain	17
8	Germany	\N
9	Brasil	19
\.


--
-- Name: teams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('teams_id_seq', 10, false);


--
-- Data for Name: titles_of_sportsmen; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY titles_of_sportsmen (id, sportsman_id, title_id) FROM stdin;
1	1	3
2	1	19
3	1	17
4	2	19
5	2	20
6	3	19
7	4	19
8	5	19
9	6	1
10	6	14
11	6	15
12	6	18
13	6	25
14	7	14
15	7	2
16	7	22
17	8	14
18	9	14
19	9	21
20	10	14
21	11	23
22	12	23
23	13	23
24	14	24
25	16	16
26	17	27
27	18	26
28	19	10
29	1	4
30	1	28
31	1	30
32	1	5
33	1	6
34	2	29
35	2	7
36	2	9
37	3	7
38	4	7
39	4	13
40	5	31
41	5	6
42	5	7
43	6	4
44	6	28
45	6	30
46	6	32
47	6	5
48	6	10
49	7	11
50	7	28
51	7	5
52	7	6
53	8	28
54	8	5
56	9	28
57	9	31
58	10	28
59	10	10
60	11	5
61	11	12
62	12	5
63	13	5
64	13	12
65	14	31
66	14	5
67	14	12
68	15	13
69	15	7
70	15	8
71	15	9
72	17	28
73	19	11
74	20	5
75	20	6
76	20	7
77	20	8
78	20	9
\.


--
-- Name: titles_of_sportsmen_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('titles_of_sportsmen_id_seq', 79, false);


--
-- Data for Name: types_of_exercises; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY types_of_exercises (id, name, description, year_of_introduction, duration_in_seconds) FROM stdin;
1	team competitions	Team all-around competitions, including the competition with five athletes in four rounds. The total score on each shell is the sum of the scores for three gymnasts on the apparatus. Then add up the results for all shells, and place teams are ranked according to this final evaluation. The medals in the case of prizes teams get all gymnasts.	1936	\N
2	individual all around	Absolute all-around includes a competition in four rounds. The total score which is the result of absolute all-around and depending on it calculate the space used by the athlete.	1952	\N
3	vault	In the performance of the reference jump, the athlete runs up the path, then proceeds with a special sloping springy bridge and jumps, during which it needs to produce an additional repulsion from the projectile this can be a gymnastic goat or a special shell. During the jump the athlete performs additional acrobatic elements in the air flips, pirouettes, spins, etc. The performance is evaluated on a difficulty of the performed elements and their clean, no errors. Special attention is paid to the quality of the landing, crash landing or even insecure executed the landing lead to a sharp reduction of the final grade.	1952	60
4	beam	The beam - one of the shells in artistic gymnastics.\nAir goat - horizontal beam length of five meters and a width of ten inches, set at the height of one hundred twenty five centimeters. Shell covered with leather or suede.	1952	90
5	uneven bars	Uneven bars - apparatus used in artistic gymnastics for women. Represent the two horizontal poles are located at different heights. Essentially double shell horizontal bar of men"s gymnastics, which are connected by special fasteners. The difference of bars from the bar is the diameter of the pole, and that pole is wooden and not steel.	1952	90
6	floor exercises	Floor exercises take place at the "carpet" - square platform size twelve to twelve meters with an additional safety border of one meter wide. The platform should have a certain elasticity to soften the landing of the athlete while performing the acrobatic jumps. The special coating of the carpet must eliminate burns to the skin by friction.Women"s floor exercise is one of the only programs of gymnastics, running under the music. The performance of the athlete is assessed according to the complexity of the performed elements and their clean, no errors. In the women"s competition, the judges also take into account the level of choreography preparation.	1952	90
\.


--
-- Name: types_of_exercises_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('types_of_exercises_id_seq', 7, false);


--
-- Name: main_titles_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY main_titles
    ADD CONSTRAINT main_titles_name_key UNIQUE (name);


--
-- Name: main_titles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY main_titles
    ADD CONSTRAINT main_titles_pkey PRIMARY KEY (id);


--
-- Name: specialization_sportsmen_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY specialization_sportsmen
    ADD CONSTRAINT specialization_sportsmen_pkey PRIMARY KEY (id);


--
-- Name: specialization_sportsmen_sportsman_id_type_of_exercise_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY specialization_sportsmen
    ADD CONSTRAINT specialization_sportsmen_sportsman_id_type_of_exercise_id_key UNIQUE (sportsman_id, type_of_exercise_id);


--
-- Name: sportsmen_number_base_fsi_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sportsmen
    ADD CONSTRAINT sportsmen_number_base_fsi_key UNIQUE (number_base_fsi);


--
-- Name: sportsmen_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sportsmen
    ADD CONSTRAINT sportsmen_pkey PRIMARY KEY (id);


--
-- Name: teams_captain_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY teams
    ADD CONSTRAINT teams_captain_id_key UNIQUE (captain_id);


--
-- Name: teams_name_of_country_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY teams
    ADD CONSTRAINT teams_name_of_country_key UNIQUE (name_of_country);


--
-- Name: teams_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: titles_of_sportsmen_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY titles_of_sportsmen
    ADD CONSTRAINT titles_of_sportsmen_pkey PRIMARY KEY (id);


--
-- Name: titles_of_sportsmen_sportsman_id_title_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY titles_of_sportsmen
    ADD CONSTRAINT titles_of_sportsmen_sportsman_id_title_id_key UNIQUE (sportsman_id, title_id);


--
-- Name: types_of_exercises_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY types_of_exercises
    ADD CONSTRAINT types_of_exercises_name_key UNIQUE (name);


--
-- Name: types_of_exercises_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY types_of_exercises
    ADD CONSTRAINT types_of_exercises_pkey PRIMARY KEY (id);


--
-- Name: main_titles_level_of_prestige_title_duration_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX main_titles_level_of_prestige_title_duration_idx ON main_titles USING btree (level_of_prestige, title_duration) WHERE (((level_of_prestige >= 6) AND (level_of_prestige <= 10)) AND (title_duration <= 2));


--
-- Name: sportsmen_last_name_idx_initcap; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sportsmen_last_name_idx_initcap ON sportsmen USING btree (initcap((last_name)::text));


--
-- Name: sportsmen_name_idx_initcap; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sportsmen_name_idx_initcap ON sportsmen USING btree (initcap((name)::text));


--
-- Name: sportsmen_team_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sportsmen_team_id_idx ON sportsmen USING btree (team_id);


--
-- Name: types_of_exercises_duration_in_seconds_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX types_of_exercises_duration_in_seconds_idx ON types_of_exercises USING btree (duration_in_seconds) WHERE (duration_in_seconds IS NOT NULL);


--
-- Name: specialization_sportsmen_sportsman_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY specialization_sportsmen
    ADD CONSTRAINT specialization_sportsmen_sportsman_id_fk FOREIGN KEY (sportsman_id) REFERENCES sportsmen(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: specialization_sportsmen_type_of_exercise_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY specialization_sportsmen
    ADD CONSTRAINT specialization_sportsmen_type_of_exercise_id_fk FOREIGN KEY (type_of_exercise_id) REFERENCES types_of_exercises(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: sportsmen_team_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sportsmen
    ADD CONSTRAINT sportsmen_team_id_fk FOREIGN KEY (team_id) REFERENCES teams(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: teams_captain_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY teams
    ADD CONSTRAINT teams_captain_id_fk FOREIGN KEY (captain_id) REFERENCES sportsmen(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: titles_of_sportsmen_sportsman_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY titles_of_sportsmen
    ADD CONSTRAINT titles_of_sportsmen_sportsman_id_fk FOREIGN KEY (sportsman_id) REFERENCES sportsmen(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: titles_of_sportsmen_title_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY titles_of_sportsmen
    ADD CONSTRAINT titles_of_sportsmen_title_id_fk FOREIGN KEY (title_id) REFERENCES main_titles(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--


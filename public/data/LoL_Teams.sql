--
-- PostgreSQL database dump
--

-- Dumped from database version 14.0
-- Dumped by pg_dump version 14.0

-- Started on 2021-11-02 01:09:49

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

--
-- TOC entry 3377 (class 1262 OID 16394)
-- Name: LoL_Teams; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "LoL_Teams" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Croatian_Croatia.1250';


ALTER DATABASE "LoL_Teams" OWNER TO postgres;

\connect "LoL_Teams"

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
-- TOC entry 209 (class 1259 OID 16484)
-- Name: country; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.country (
    countryid integer NOT NULL,
    countryname character varying(50) NOT NULL
);


ALTER TABLE public.country OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16491)
-- Name: league; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.league (
    leagueid integer NOT NULL,
    leaguename character varying(70) NOT NULL,
    leagueacronym character varying(5) NOT NULL
);


ALTER TABLE public.league OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16580)
-- Name: player; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.player (
    playerid integer NOT NULL,
    ign character varying(16) NOT NULL,
    playername character varying(50) NOT NULL,
    playersurname character varying(50) NOT NULL,
    countryid integer NOT NULL,
    teamid integer NOT NULL,
    roleid integer NOT NULL,
    contractends date NOT NULL
);


ALTER TABLE public.player OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16507)
-- Name: role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role (
    roleid integer NOT NULL,
    rolename character varying(20) NOT NULL
);


ALTER TABLE public.role OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16500)
-- Name: sponsor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sponsor (
    sponsorid integer NOT NULL,
    sponsorname character varying(70) NOT NULL
);


ALTER TABLE public.sponsor OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16557)
-- Name: sponsoredby; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sponsoredby (
    teamid integer NOT NULL,
    sponsorid integer NOT NULL
);


ALTER TABLE public.sponsoredby OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16514)
-- Name: team; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.team (
    teamid integer NOT NULL,
    teamname character varying(30) NOT NULL,
    teamacronym character varying(3) NOT NULL,
    headcoach character varying(100) NOT NULL,
    created date NOT NULL,
    domestictitles integer,
    internationaltitles integer,
    countryid integer NOT NULL,
    leagueid integer NOT NULL,
    CONSTRAINT team_domestictitles_check CHECK ((domestictitles > '-1'::integer)),
    CONSTRAINT team_internationaltitles_check CHECK ((internationaltitles > '-1'::integer))
);


ALTER TABLE public.team OWNER TO postgres;

--
-- TOC entry 3365 (class 0 OID 16484)
-- Dependencies: 209
-- Data for Name: country; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.country (countryid, countryname) VALUES (0, 'United States');
INSERT INTO public.country (countryid, countryname) VALUES (1, 'South Korea');
INSERT INTO public.country (countryid, countryname) VALUES (2, 'Australia');
INSERT INTO public.country (countryid, countryname) VALUES (3, 'Denmark');
INSERT INTO public.country (countryid, countryname) VALUES (4, 'Germany');
INSERT INTO public.country (countryid, countryname) VALUES (5, 'France');
INSERT INTO public.country (countryid, countryname) VALUES (6, 'United Kingdom');
INSERT INTO public.country (countryid, countryname) VALUES (7, 'Poland');
INSERT INTO public.country (countryid, countryname) VALUES (8, 'Croatia');
INSERT INTO public.country (countryid, countryname) VALUES (9, 'Canada');
INSERT INTO public.country (countryid, countryname) VALUES (10, 'Netherlands');
INSERT INTO public.country (countryid, countryname) VALUES (11, 'China');
INSERT INTO public.country (countryid, countryname) VALUES (12, 'Spain');
INSERT INTO public.country (countryid, countryname) VALUES (13, 'Czech Republic');
INSERT INTO public.country (countryid, countryname) VALUES (14, 'Turkey');
INSERT INTO public.country (countryid, countryname) VALUES (15, 'Belgium');
INSERT INTO public.country (countryid, countryname) VALUES (16, 'Bulgaria');
INSERT INTO public.country (countryid, countryname) VALUES (17, 'Romania');
INSERT INTO public.country (countryid, countryname) VALUES (18, 'Sweden');
INSERT INTO public.country (countryid, countryname) VALUES (19, 'Slovenia');
INSERT INTO public.country (countryid, countryname) VALUES (20, 'Japan');
INSERT INTO public.country (countryid, countryname) VALUES (21, 'Taiwan');
INSERT INTO public.country (countryid, countryname) VALUES (22, 'Brasil');
INSERT INTO public.country (countryid, countryname) VALUES (23, 'Hong Kong');


--
-- TOC entry 3366 (class 0 OID 16491)
-- Dependencies: 210
-- Data for Name: league; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.league (leagueid, leaguename, leagueacronym) VALUES (0, 'League of Legends Champions Korea', 'LCK');
INSERT INTO public.league (leagueid, leaguename, leagueacronym) VALUES (1, 'League of Legends Pro League', 'LPL');
INSERT INTO public.league (leagueid, leaguename, leagueacronym) VALUES (2, 'League of Legends European Championship', 'LEC');
INSERT INTO public.league (leagueid, leaguename, leagueacronym) VALUES (3, 'League Championship Series', 'LCS');
INSERT INTO public.league (leagueid, leaguename, leagueacronym) VALUES (4, 'League of Legends Japan League', 'LJL');
INSERT INTO public.league (leagueid, leaguename, leagueacronym) VALUES (5, 'Pacific Championship Series', 'PCS');
INSERT INTO public.league (leagueid, leaguename, leagueacronym) VALUES (6, 'Vietnam Championship Series', 'VCS');
INSERT INTO public.league (leagueid, leaguename, leagueacronym) VALUES (7, 'Campeonato Brasileiro de League of Legends', 'CBLOL');


--
-- TOC entry 3371 (class 0 OID 16580)
-- Dependencies: 215
-- Data for Name: player; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (0, 'Fudge', 'Ibrahim', 'Allami', 2, 0, 1, '2023-11-21');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (1, 'Blaber', 'Robert', 'Huang', 0, 0, 2, '2023-11-21');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (2, 'Perkz', 'Luka', 'Perković', 8, 0, 3, '2023-11-21');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (3, 'Zven', 'Jesper', 'Svenningsen', 3, 0, 4, '2023-11-21');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (4, 'Vulcan', 'Philippe', 'Laflamme', 9, 0, 5, '2023-11-21');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (5, 'Wunder', 'Martin', 'Nordahl Hansen', 3, 1, 1, '2022-11-21');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (6, 'Jankos', 'Marcin', 'Jankowski', 7, 1, 2, '2022-11-21');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (7, 'Caps', 'Rasmus', 'Borregaard Winther', 3, 1, 3, '2023-11-20');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (8, 'Rekkles', 'Martin', 'Larsson', 18, 1, 4, '2023-11-20');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (9, 'Mikyx', 'Mihael', 'Mehle', 19, 1, 5, '2022-11-21');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (10, 'P1noy', 'Kristoffer', 'Albao Lund Pedersen', 3, 1, 0, '2021-11-15');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (11, 'Adam', 'Adam', 'Maanane', 5, 2, 1, '2023-11-20');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (12, 'Bwipo', 'Gabriël', 'Rau', 15, 2, 2, '2021-11-15');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (13, 'Nisqy', 'Yasin', 'Dinçer', 15, 2, 3, '2023-11-20');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (14, 'Upset', 'Elias', 'Lipp', 4, 2, 4, '2023-11-20');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (15, 'Hylissang', 'Zdravets', 'Iliev Galabov', 16, 2, 5, '2021-11-15');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (16, 'Armut', 'İrfan Berk', 'Tükek', 14, 3, 1, '2023-11-20');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (17, 'Elyoya', 'Javier', 'Prades Batalla', 12, 3, 2, '2023-11-20');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (18, 'Humanoid', 'Marek', 'Brázda', 13, 3, 3, '2022-11-21');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (19, 'Carzzy', 'Matyáš', 'Orság', 13, 3, 4, '2021-11-15');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (20, 'Kaiser', 'Norman', 'Kaiser', 4, 3, 5, '2023-11-20');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (21, 'Ssumday', 'Kim', 'Chan-ho', 1, 4, 1, '2022-11-15');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (22, 'Closer', 'Can', 'Çelik', 14, 4, 2, '2023-11-21');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (23, 'Abbedagge', 'Felix', 'Braun', 4, 4, 3, '2023-11-21');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (24, 'FBI', 'Ian Victor', 'Huang', 2, 4, 4, '2023-11-21');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (25, 'huhi', 'Choi', 'Jae-hyun', 1, 4, 5, '2023-11-21');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (26, 'Canna', 'Kim', 'Chang-dong', 1, 5, 1, '2022-11-21');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (27, 'Oner', 'Moon', 'Hyeon-joon', 1, 5, 2, '2022-11-21');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (28, 'Faker', 'Lee', 'Sang-hyeok', 1, 5, 3, '2021-11-15');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (29, 'Gumayusi', 'Lee', 'Min-hyeong', 1, 5, 4, '2022-11-21');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (30, 'Keria', 'Ryu', 'Min-seok', 1, 5, 5, '2022-11-15');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (31, 'Teddy', 'Park', 'Jin-seong', 1, 5, 0, '2022-11-21');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (32, 'Cuzz', 'Moon', 'Woo-chan', 1, 5, 0, '2021-11-15');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (33, 'Khan', 'Kim', 'Dong-ha', 1, 6, 1, '2021-11-15');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (34, 'Canyon', 'Kim', 'Geon-bu', 1, 6, 2, '2021-11-15');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (35, 'ShowMaker', 'Heo', 'Su', 1, 6, 3, '2021-11-15');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (36, 'Ghost', 'Jang', 'Yong-jun', 1, 6, 4, '2022-11-21');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (37, 'BeryL', 'Cho', 'Geon-hee', 1, 6, 5, '2021-11-15');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (38, 'Malrang', 'Kim', 'Geun-seong', 1, 6, 0, '2022-11-21');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (39, 'Rahel', 'Cho', 'Min-seong', 1, 6, 0, '2023-11-20');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (40, 'Xiaohu', 'Li', 'Yuan-Hao', 11, 7, 1, '2022-11-22');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (41, 'Wei', 'Yan', 'Yang-Wei', 11, 7, 2, '2022-11-22');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (42, 'Cryin', 'Yuan', 'Cheng-Wei', 11, 7, 3, '2021-11-16');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (43, 'GALA', 'Chen', 'Wei', 11, 7, 4, '2022-11-22');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (44, 'Ming', 'Shi', 'Sen-Ming', 11, 7, 5, '2021-11-16');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (45, 'Xiaoxu', 'Xu', 'Xing-Zu', 11, 7, 0, '2022-11-22');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (46, 'lovely', 'Mo', 'Xiong-Zi', 11, 7, 0, '2022-11-22');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (47, 'Flandre', 'Li', 'Xuan-Jun', 11, 8, 1, '2022-11-22');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (48, 'Jiejie', 'Zhao', 'Li-Jie', 11, 8, 2, '2023-11-21');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (49, 'Scout', 'Lee', 'Ye-chan', 1, 8, 3, '2022-11-22');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (50, 'Viper', 'Park', 'Do-hyeon', 1, 8, 4, '2021-11-16');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (51, 'Meiko', 'Tian', 'Ye', 11, 8, 5, '2022-11-22');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (52, 'Clearlove', 'Ming', 'Kai', 11, 8, 0, '2021-11-16');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (53, 'JunJia', 'Yu', 'Chun-Chia', 21, 8, 0, '2021-11-16');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (55, 'Steal', 'Mun', 'Geon-yeong', 1, 9, 2, '2021-11-16');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (54, 'Evi', 'Shunsuke', 'Murase', 20, 9, 1, '2021-11-16');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (56, 'Aria', 'Lee', 'Ga-eul', 1, 9, 3, '2021-11-16');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (57, 'Yutapon', 'Yuta', 'Sugiura', 20, 9, 4, '2021-11-16');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (58, 'Gaeng', 'Yang', 'Gwang-woo', 1, 9, 5, '2021-11-16');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (59, 'Ceros', 'Kyohei', 'Yoshida', 20, 9, 0, '2021-11-16');
INSERT INTO public.player (playerid, ign, playername, playersurname, countryid, teamid, roleid, contractends) VALUES (60, 'Kazu', 'Kazuta', 'Suzuki', 20, 9, 0, '2021-11-16');


--
-- TOC entry 3368 (class 0 OID 16507)
-- Dependencies: 212
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.role (roleid, rolename) VALUES (0, 'Substitute');
INSERT INTO public.role (roleid, rolename) VALUES (1, 'Top Laner');
INSERT INTO public.role (roleid, rolename) VALUES (2, 'Jungler');
INSERT INTO public.role (roleid, rolename) VALUES (3, 'Mid Laner');
INSERT INTO public.role (roleid, rolename) VALUES (4, 'Bot Laner');
INSERT INTO public.role (roleid, rolename) VALUES (5, 'Support');


--
-- TOC entry 3367 (class 0 OID 16500)
-- Dependencies: 211
-- Data for Name: sponsor; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sponsor (sponsorid, sponsorname) VALUES (0, 'KIA');
INSERT INTO public.sponsor (sponsorid, sponsorname) VALUES (1, 'Logitech G');
INSERT INTO public.sponsor (sponsorid, sponsorname) VALUES (2, 'Nike');
INSERT INTO public.sponsor (sponsorid, sponsorname) VALUES (3, 'BMW');
INSERT INTO public.sponsor (sponsorid, sponsorname) VALUES (4, 'Adidas');
INSERT INTO public.sponsor (sponsorid, sponsorname) VALUES (5, 'SecretLab');
INSERT INTO public.sponsor (sponsorid, sponsorname) VALUES (6, 'Red Bull');
INSERT INTO public.sponsor (sponsorid, sponsorname) VALUES (7, 'Douyu');
INSERT INTO public.sponsor (sponsorid, sponsorname) VALUES (8, 'Twitch');
INSERT INTO public.sponsor (sponsorid, sponsorname) VALUES (9, 'Monster Energy');
INSERT INTO public.sponsor (sponsorid, sponsorname) VALUES (10, 'AMD');
INSERT INTO public.sponsor (sponsorid, sponsorname) VALUES (11, 'OnePlus');
INSERT INTO public.sponsor (sponsorid, sponsorname) VALUES (12, 'HyperX');
INSERT INTO public.sponsor (sponsorid, sponsorname) VALUES (13, 'Puma');
INSERT INTO public.sponsor (sponsorid, sponsorname) VALUES (14, 'Microsoft');
INSERT INTO public.sponsor (sponsorid, sponsorname) VALUES (15, 'HP');
INSERT INTO public.sponsor (sponsorid, sponsorname) VALUES (16, 'KFC');
INSERT INTO public.sponsor (sponsorid, sponsorname) VALUES (17, 'Alienware');
INSERT INTO public.sponsor (sponsorid, sponsorname) VALUES (18, 'NVIDIA');
INSERT INTO public.sponsor (sponsorid, sponsorname) VALUES (19, 'GIGABYTE');
INSERT INTO public.sponsor (sponsorid, sponsorname) VALUES (20, 'Razer');
INSERT INTO public.sponsor (sponsorid, sponsorname) VALUES (21, 'Intel');
INSERT INTO public.sponsor (sponsorid, sponsorname) VALUES (22, 'Acer');


--
-- TOC entry 3370 (class 0 OID 16557)
-- Dependencies: 214
-- Data for Name: sponsoredby; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (0, 6);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (0, 15);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (0, 8);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (0, 12);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (0, 5);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (0, 13);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (0, 14);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (0, 3);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (1, 1);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (1, 5);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (1, 8);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (1, 3);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (1, 4);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (2, 11);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (2, 9);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (2, 10);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (2, 3);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (4, 20);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (4, 6);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (4, 5);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (5, 7);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (5, 2);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (5, 1);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (5, 5);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (5, 11);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (5, 3);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (5, 8);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (5, 6);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (6, 0);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (6, 7);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (6, 1);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (6, 4);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (7, 15);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (7, 1);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (7, 7);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (7, 16);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (9, 1);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (9, 18);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (9, 19);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (9, 12);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (8, 21);
INSERT INTO public.sponsoredby (teamid, sponsorid) VALUES (8, 22);


--
-- TOC entry 3369 (class 0 OID 16514)
-- Dependencies: 213
-- Data for Name: team; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.team (teamid, teamname, teamacronym, headcoach, created, domestictitles, internationaltitles, countryid, leagueid) VALUES (0, 'Cloud9', 'C9', 'Kim "Reignover" Yeu-jin', '2012-12-04', 4, 0, 0, 3);
INSERT INTO public.team (teamid, teamname, teamacronym, headcoach, created, domestictitles, internationaltitles, countryid, leagueid) VALUES (1, 'G2 Esports', 'G2', 'Fabian "GrabbZ" Lohmann', '2015-10-15', 8, 1, 4, 2);
INSERT INTO public.team (teamid, teamname, teamacronym, headcoach, created, domestictitles, internationaltitles, countryid, leagueid) VALUES (2, 'Fnatic', 'FNC', 'Jakob "YamatoCannon" Mebdi', '2011-03-14', 7, 1, 6, 2);
INSERT INTO public.team (teamid, teamname, teamacronym, headcoach, created, domestictitles, internationaltitles, countryid, leagueid) VALUES (3, 'MAD Lions', 'MAD', 'James "Mac" MacCormack', '2019-11-29', 2, 0, 12, 2);
INSERT INTO public.team (teamid, teamname, teamacronym, headcoach, created, domestictitles, internationaltitles, countryid, leagueid) VALUES (4, '100 Thieves', '100', 'Bok "Reapered" Han-gyu', '2017-11-20', 1, 0, 0, 3);
INSERT INTO public.team (teamid, teamname, teamacronym, headcoach, created, domestictitles, internationaltitles, countryid, leagueid) VALUES (5, 'T1', 'T1', 'Son "Stardust" Seok-hee (Interim)', '2014-02-15', 9, 5, 1, 0);
INSERT INTO public.team (teamid, teamname, teamacronym, headcoach, created, domestictitles, internationaltitles, countryid, leagueid) VALUES (6, 'DWG KIA', 'DK', 'Lee "NO1" Yu-yeong', '2017-05-28', 3, 1, 1, 0);
INSERT INTO public.team (teamid, teamname, teamacronym, headcoach, created, domestictitles, internationaltitles, countryid, leagueid) VALUES (7, 'Royal Never Give Up', 'RNG', 'Wong "Tabe" Pak Kan', '2015-05-15', 4, 2, 11, 1);
INSERT INTO public.team (teamid, teamname, teamacronym, headcoach, created, domestictitles, internationaltitles, countryid, leagueid) VALUES (8, 'EDward Gaming', 'EDG', 'Yang "Maokai" Ji-Song', '2014-02-07', 6, 1, 11, 1);
INSERT INTO public.team (teamid, teamname, teamacronym, headcoach, created, domestictitles, internationaltitles, countryid, leagueid) VALUES (9, 'DetonatioN FocusMe', 'DFM', 'Yang "Yang" Gwang-pyo', '2013-04-13', 12, 0, 20, 4);


--
-- TOC entry 3190 (class 2606 OID 16490)
-- Name: country country_countryname_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_countryname_key UNIQUE (countryname);


--
-- TOC entry 3192 (class 2606 OID 16488)
-- Name: country country_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (countryid);


--
-- TOC entry 3194 (class 2606 OID 16579)
-- Name: league league_leagueacronym_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.league
    ADD CONSTRAINT league_leagueacronym_key UNIQUE (leagueacronym);


--
-- TOC entry 3196 (class 2606 OID 16497)
-- Name: league league_leaguename_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.league
    ADD CONSTRAINT league_leaguename_key UNIQUE (leaguename);


--
-- TOC entry 3198 (class 2606 OID 16495)
-- Name: league league_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.league
    ADD CONSTRAINT league_pkey PRIMARY KEY (leagueid);


--
-- TOC entry 3216 (class 2606 OID 16586)
-- Name: player player_ign_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player
    ADD CONSTRAINT player_ign_key UNIQUE (ign);


--
-- TOC entry 3218 (class 2606 OID 16584)
-- Name: player player_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player
    ADD CONSTRAINT player_pkey PRIMARY KEY (playerid);


--
-- TOC entry 3204 (class 2606 OID 16511)
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (roleid);


--
-- TOC entry 3206 (class 2606 OID 16513)
-- Name: role role_rolename_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_rolename_key UNIQUE (rolename);


--
-- TOC entry 3200 (class 2606 OID 16504)
-- Name: sponsor sponsor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sponsor
    ADD CONSTRAINT sponsor_pkey PRIMARY KEY (sponsorid);


--
-- TOC entry 3202 (class 2606 OID 16506)
-- Name: sponsor sponsor_sponsorname_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sponsor
    ADD CONSTRAINT sponsor_sponsorname_key UNIQUE (sponsorname);


--
-- TOC entry 3214 (class 2606 OID 16561)
-- Name: sponsoredby sponsoredby_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sponsoredby
    ADD CONSTRAINT sponsoredby_pkey PRIMARY KEY (sponsorid, teamid);


--
-- TOC entry 3208 (class 2606 OID 16520)
-- Name: team team_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_pkey PRIMARY KEY (teamid);


--
-- TOC entry 3210 (class 2606 OID 16524)
-- Name: team team_teamacronym_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_teamacronym_key UNIQUE (teamacronym);


--
-- TOC entry 3212 (class 2606 OID 16522)
-- Name: team team_teamname_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_teamname_key UNIQUE (teamname);


--
-- TOC entry 3225 (class 2606 OID 16597)
-- Name: player player_countryid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player
    ADD CONSTRAINT player_countryid_fkey FOREIGN KEY (countryid) REFERENCES public.country(countryid);


--
-- TOC entry 3224 (class 2606 OID 16592)
-- Name: player player_roleid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player
    ADD CONSTRAINT player_roleid_fkey FOREIGN KEY (roleid) REFERENCES public.role(roleid);


--
-- TOC entry 3223 (class 2606 OID 16587)
-- Name: player player_teamid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player
    ADD CONSTRAINT player_teamid_fkey FOREIGN KEY (teamid) REFERENCES public.team(teamid);


--
-- TOC entry 3221 (class 2606 OID 16562)
-- Name: sponsoredby sponsoredby_sponsorid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sponsoredby
    ADD CONSTRAINT sponsoredby_sponsorid_fkey FOREIGN KEY (sponsorid) REFERENCES public.sponsor(sponsorid);


--
-- TOC entry 3222 (class 2606 OID 16567)
-- Name: sponsoredby sponsoredby_teamid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sponsoredby
    ADD CONSTRAINT sponsoredby_teamid_fkey FOREIGN KEY (teamid) REFERENCES public.team(teamid);


--
-- TOC entry 3219 (class 2606 OID 16525)
-- Name: team team_countryid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_countryid_fkey FOREIGN KEY (countryid) REFERENCES public.country(countryid);


--
-- TOC entry 3220 (class 2606 OID 16530)
-- Name: team team_leagueid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_leagueid_fkey FOREIGN KEY (leagueid) REFERENCES public.league(leagueid);


--
-- TOC entry 3378 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2021-11-02 01:09:49

--
-- PostgreSQL database dump complete
--


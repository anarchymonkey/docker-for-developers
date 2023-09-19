--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

-- Started on 2023-09-19 07:08:55

CREATE DATABASE url_shortener;

-- Connect to the 'url_shortener' database
\c url_shortener;

-- Set up the search path within the 'url_shortener' database
SET search_path = public;

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
-- TOC entry 216 (class 1255 OID 16518)
-- Name: trigger_set_timestamp(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_set_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.trigger_set_timestamp() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 16508)
-- Name: shortened_urls; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shortened_urls (
    id integer NOT NULL,
    longurl text,
    shorturl character(7),
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    expires_at timestamp with time zone
);


ALTER TABLE public.shortened_urls OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16507)
-- Name: shortened_urls_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shortened_urls_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shortened_urls_id_seq OWNER TO postgres;

--
-- TOC entry 3331 (class 0 OID 0)
-- Dependencies: 214
-- Name: shortened_urls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shortened_urls_id_seq OWNED BY public.shortened_urls.id;


--
-- TOC entry 3174 (class 2604 OID 16511)
-- Name: shortened_urls id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shortened_urls ALTER COLUMN id SET DEFAULT nextval('public.shortened_urls_id_seq'::regclass);


--
-- TOC entry 3325 (class 0 OID 16508)
-- Dependencies: 215
-- Data for Name: shortened_urls; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shortened_urls (id, longurl, shorturl, created_at, updated_at, expires_at) FROM stdin;
5	https://www.youtube.com/watch?v=VAdGW7QDJiU&list=RDMMVAdGW7QDJiU&start_radio=1&ab_channel=T-Series	MTExMTE	2023-08-27 17:10:01.802276+05:30	2023-08-27 17:10:01.802276+05:30	\N
7	https://stackoverflow.com/questions/48939093/do-i-need-to-spawn-multiple-go-web-server-instances-to-fully-utilize-my-cpu	MDAwMDE	2023-08-27 17:39:36.583821+05:30	2023-08-27 17:39:36.583821+05:30	\N
8	https://blog.logrocket.com/rate-limiting-go-application/	MDEwMDA	2023-08-27 17:41:28.000539+05:30	2023-08-27 17:41:28.000539+05:30	\N
\.


--
-- TOC entry 3332 (class 0 OID 0)
-- Dependencies: 214
-- Name: shortened_urls_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shortened_urls_id_seq', 11, true);


--
-- TOC entry 3178 (class 2606 OID 16517)
-- Name: shortened_urls shortened_urls_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shortened_urls
    ADD CONSTRAINT shortened_urls_pkey PRIMARY KEY (id);


--
-- TOC entry 3180 (class 2606 OID 16521)
-- Name: shortened_urls url_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shortened_urls
    ADD CONSTRAINT url_unique UNIQUE (longurl, shorturl);


--
-- TOC entry 3181 (class 2620 OID 16519)
-- Name: shortened_urls set_timestamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.shortened_urls FOR EACH ROW EXECUTE FUNCTION public.trigger_set_timestamp();


-- Completed on 2023-09-19 07:08:55

--
-- PostgreSQL database dump complete
--


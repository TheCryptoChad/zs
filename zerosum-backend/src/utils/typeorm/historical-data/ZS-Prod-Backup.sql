--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2
-- Dumped by pg_dump version 15.3

-- Started on 2023-10-03 19:33:33 EST

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

DROP DATABASE railway;
--
-- TOC entry 3585 (class 1262 OID 17471)
-- Name: railway; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE railway WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE railway OWNER TO postgres;

\connect railway

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
-- TOC entry 5 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 2 (class 3079 OID 16927)
-- Name: timescaledb; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS timescaledb WITH SCHEMA public;


--
-- TOC entry 3587 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION timescaledb; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION timescaledb IS 'Enables scalable inserts and complex queries for time-series data';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 259 (class 1259 OID 18322)
-- Name: base_resource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.base_resource (
    owner_address character varying NOT NULL,
    astralite bigint DEFAULT 0 NOT NULL,
    samarium bigint DEFAULT 0 NOT NULL,
    calamarite bigint DEFAULT 0 NOT NULL,
    contract_astralite bigint DEFAULT 0 NOT NULL,
    contract_samarium bigint DEFAULT 0 NOT NULL,
    contract_calamarite bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.base_resource OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 18296)
-- Name: base_stats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.base_stats (
    address character varying NOT NULL,
    astralite_amount bigint DEFAULT 0 NOT NULL,
    astralite_tx bigint DEFAULT 0 NOT NULL,
    samarium_amount bigint DEFAULT 0 NOT NULL,
    samarium_tx bigint DEFAULT 0 NOT NULL,
    calamarite_amount bigint DEFAULT 0 NOT NULL,
    calamarite_tx bigint DEFAULT 0 NOT NULL,
    faucet_uses bigint DEFAULT 0 NOT NULL,
    gas_tx bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.base_stats OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 17492)
-- Name: blockchain; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.blockchain (
    name character varying NOT NULL,
    latest_block bigint NOT NULL,
    updated_at bigint NOT NULL
);


ALTER TABLE public.blockchain OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 17519)
-- Name: exhausted_tile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exhausted_tile (
    id bigint NOT NULL,
    uuid character varying NOT NULL,
    x bigint NOT NULL,
    y bigint NOT NULL
);


ALTER TABLE public.exhausted_tile OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 17517)
-- Name: exhausted_tile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.exhausted_tile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.exhausted_tile_id_seq OWNER TO postgres;

--
-- TOC entry 3588 (class 0 OID 0)
-- Dependencies: 253
-- Name: exhausted_tile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.exhausted_tile_id_seq OWNED BY public.exhausted_tile.id;


--
-- TOC entry 261 (class 1259 OID 20107)
-- Name: login_tracker; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.login_tracker (
    date bigint NOT NULL,
    total_logins bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.login_tracker OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 17509)
-- Name: manta_resource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.manta_resource (
    owner_address character varying NOT NULL,
    astralite bigint DEFAULT 0 NOT NULL,
    samarium bigint DEFAULT 0 NOT NULL,
    calamarite bigint DEFAULT 0 NOT NULL,
    contract_astralite bigint DEFAULT 0 NOT NULL,
    contract_samarium bigint DEFAULT 0 NOT NULL,
    contract_calamarite bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.manta_resource OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 18002)
-- Name: manta_stats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.manta_stats (
    address character varying NOT NULL,
    astralite_amount bigint DEFAULT 0 NOT NULL,
    astralite_tx bigint DEFAULT 0 NOT NULL,
    samarium_amount bigint DEFAULT 0 NOT NULL,
    samarium_tx bigint DEFAULT 0 NOT NULL,
    calamarite_amount bigint DEFAULT 0 NOT NULL,
    calamarite_tx bigint DEFAULT 0 NOT NULL,
    faucet_uses bigint DEFAULT 0 NOT NULL,
    gas_tx bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.manta_stats OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 17475)
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    "timestamp" bigint NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 17473)
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_id_seq OWNER TO postgres;

--
-- TOC entry 3589 (class 0 OID 0)
-- Dependencies: 247
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- TOC entry 256 (class 1259 OID 17530)
-- Name: random_seed; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.random_seed (
    id bigint NOT NULL,
    seed bigint NOT NULL,
    generated_at bigint
);


ALTER TABLE public.random_seed OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 17528)
-- Name: random_seed_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.random_seed_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.random_seed_id_seq OWNER TO postgres;

--
-- TOC entry 3590 (class 0 OID 0)
-- Dependencies: 255
-- Name: random_seed_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.random_seed_id_seq OWNED BY public.random_seed.id;


--
-- TOC entry 260 (class 1259 OID 19629)
-- Name: update; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.update (
    version character varying NOT NULL,
    title character varying NOT NULL,
    changes character varying NOT NULL,
    date character varying NOT NULL
);


ALTER TABLE public.update OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 17484)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    uuid character varying NOT NULL,
    access_token character varying NOT NULL,
    address character varying,
    next_faucet_use bigint DEFAULT 0 NOT NULL,
    username character varying,
    linked_username boolean DEFAULT false NOT NULL,
    last_login bigint DEFAULT 0 NOT NULL,
    total_logins bigint DEFAULT 0 NOT NULL,
    consecutive_logins bigint DEFAULT 0 NOT NULL,
    pending_mints bigint[],
    referred_by character varying,
    referrals character varying[]
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 17500)
-- Name: vessel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vessel (
    id bigint NOT NULL,
    owner_address character varying NOT NULL,
    range bigint NOT NULL,
    x bigint,
    y bigint,
    mining_end_time bigint,
    is_locked boolean DEFAULT false NOT NULL,
    name character varying,
    pending_astralite bigint,
    pending_samarium bigint,
    pending_calamarite bigint,
    model character varying,
    speed bigint DEFAULT 0 NOT NULL,
    radar bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.vessel OWNER TO postgres;

--
-- TOC entry 3300 (class 2604 OID 17522)
-- Name: exhausted_tile id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exhausted_tile ALTER COLUMN id SET DEFAULT nextval('public.exhausted_tile_id_seq'::regclass);


--
-- TOC entry 3285 (class 2604 OID 17478)
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- TOC entry 3301 (class 2604 OID 17533)
-- Name: random_seed id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.random_seed ALTER COLUMN id SET DEFAULT nextval('public.random_seed_id_seq'::regclass);


--
-- TOC entry 3273 (class 0 OID 17376)
-- Dependencies: 237
-- Data for Name: cache_inval_bgw_job; Type: TABLE DATA; Schema: _timescaledb_cache; Owner: postgres
--



--
-- TOC entry 3272 (class 0 OID 17379)
-- Dependencies: 238
-- Data for Name: cache_inval_extension; Type: TABLE DATA; Schema: _timescaledb_cache; Owner: postgres
--



--
-- TOC entry 3271 (class 0 OID 17373)
-- Dependencies: 236
-- Data for Name: cache_inval_hypertable; Type: TABLE DATA; Schema: _timescaledb_cache; Owner: postgres
--



--
-- TOC entry 3248 (class 0 OID 16944)
-- Dependencies: 207
-- Data for Name: hypertable; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: postgres
--



--
-- TOC entry 3255 (class 0 OID 17030)
-- Dependencies: 216
-- Data for Name: chunk; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: postgres
--



--
-- TOC entry 3251 (class 0 OID 16995)
-- Dependencies: 212
-- Data for Name: dimension; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: postgres
--



--
-- TOC entry 3253 (class 0 OID 17014)
-- Dependencies: 214
-- Data for Name: dimension_slice; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: postgres
--



--
-- TOC entry 3257 (class 0 OID 17051)
-- Dependencies: 217
-- Data for Name: chunk_constraint; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: postgres
--



--
-- TOC entry 3260 (class 0 OID 17085)
-- Dependencies: 220
-- Data for Name: chunk_data_node; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: postgres
--



--
-- TOC entry 3259 (class 0 OID 17069)
-- Dependencies: 219
-- Data for Name: chunk_index; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: postgres
--



--
-- TOC entry 3269 (class 0 OID 17221)
-- Dependencies: 232
-- Data for Name: compression_chunk_size; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: postgres
--



--
-- TOC entry 3264 (class 0 OID 17150)
-- Dependencies: 226
-- Data for Name: continuous_agg; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: postgres
--



--
-- TOC entry 3266 (class 0 OID 17181)
-- Dependencies: 228
-- Data for Name: continuous_aggs_hypertable_invalidation_log; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: postgres
--



--
-- TOC entry 3265 (class 0 OID 17171)
-- Dependencies: 227
-- Data for Name: continuous_aggs_invalidation_threshold; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: postgres
--



--
-- TOC entry 3267 (class 0 OID 17185)
-- Dependencies: 229
-- Data for Name: continuous_aggs_materialization_invalidation_log; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: postgres
--



--
-- TOC entry 3268 (class 0 OID 17202)
-- Dependencies: 231
-- Data for Name: hypertable_compression; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: postgres
--



--
-- TOC entry 3249 (class 0 OID 16965)
-- Dependencies: 208
-- Data for Name: hypertable_data_node; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: postgres
--



--
-- TOC entry 3263 (class 0 OID 17142)
-- Dependencies: 225
-- Data for Name: metadata; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: postgres
--

INSERT INTO _timescaledb_catalog.metadata (key, value, include_in_telemetry) VALUES ('exported_uuid', 'c28f8636-ac06-40b1-99de-2eefe3c53629', true);


--
-- TOC entry 3270 (class 0 OID 17236)
-- Dependencies: 233
-- Data for Name: remote_txn; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: postgres
--



--
-- TOC entry 3250 (class 0 OID 16980)
-- Dependencies: 210
-- Data for Name: tablespace; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: postgres
--



--
-- TOC entry 3262 (class 0 OID 17099)
-- Dependencies: 222
-- Data for Name: bgw_job; Type: TABLE DATA; Schema: _timescaledb_config; Owner: postgres
--



--
-- TOC entry 3577 (class 0 OID 18322)
-- Dependencies: 259
-- Data for Name: base_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x18688146713a8c38310547b473dd87c28cd941c6', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x300f555bf2a6ba5e090d224687d8ff4703cd0f52', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x6c96d29e8763ca0996f983c0469630a60b108c9f', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x7bacff455a5d921d2c953180083d488bd380eb2a', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x124b76631b4add879a9bf5a7759cfa3a1d78ca2c', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x3c69cf466b8ccede9b7d25a96080eafbd02c446d', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x1f6239b44952fa8ccbe3de87fae8198867277f65', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xbc90ead9929590f4490b400c766975ac8c150e9a', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x3e95e93ace1d56792d3ed326b3f20d32f050fd9f', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xb93701293b1bbeaa7d4b0a73449d30a1fcf459f0', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x705317be1e94317672fcd2f39d7f5e607f9e4d97', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xa56cc2cc3fab1a0da80268ea83effbac3daaedc0', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x10bdaea978fbad26b045278a04a42fd13949caa3', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x92124ee0e7238992e5e7f34f9fbbcd71931abc6d', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xc9634ebc37b543cbee414fcc4426f447370e50b5', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xe0e11ee72a99d9b74708f70a97bc4af5f331defc', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x292e84772e3ce9a5db4ba914b83b89b74886f1bd', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x17b339dd9579aec49d075d539729552b3488ebd2', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xbdd05454794736c83b03ee2958999924782f684f', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x629dff6da36666063a31d59abf4302fcaabb2c11', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x90e1ad3a81411b60c73dbebdc3fe985f73a990b0', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x30303463339b79f36f548ee6c171ac0e00d713ae', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xe13abdb784435f7e12656daa2fee2687b4486152', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x8626f6940e2eb28930efb4cef49b2d1f2c9c1199', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x9bca95c511bb1e42641c6abc1778d68506989842', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x542325af03aff2b3ac9f0882b4442590717362c0', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xd7b2913be8247d7b54ec38366dc45fbe21fb4587', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xd6affec06f7688484643b50f7fae00927ceab84a', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x932bad9228d2bb187548677ce6712f9b001993a9', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xf282529a89e131791f15ca45d32c6e1267987ced', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xc9ac4dcb8927891274442484701c104845a23367', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xd3a2978a9ad5ea4e76520594646ef7e8e1fffe1f', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x914bd52a86f6f2f3fc72843e69ee2dd8a54ed50c', 1072, 1137, 1910, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x0145582cb27bd79163462029a81bbb0b56a3991e', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x9f8d9c183150f15ffba39b7b17c3e1a78e5e5478', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x93b7ee22a179c00e98e80792e89bae613f22c622', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xfa5a1f0e3b506acb0d5183dbff6d0d6f33bcaea5', 3034, 4355, 6942, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xebd9a48ed1128375eb4383ed4d53478b4fd85a8d', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xdfdcc1a06b5d833c89197b8c216ac497d67ca5d9', 0, 0, 0, 8763, 8172, 12992);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xc9792727ef67867670d85ba7b8b694368f10ab5c', 1679, 1998, 494, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xba1688252983cddf5c5484975f9e8da35ceb91bb', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xc2100a5022cd8fd7beedde6195a8894f2f0265da', 569, 1068, 449, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x8c6b1d93b59db869fd232a0e7ca38bcc696914c9', 0, 0, 862, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xf0c56251ce95e39882cc58f3cc14272771ae2f44', 955, 2159, 1139, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x0d960b67269b0837c0ebf6a09cce69377590f020', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xccdf7faf3e42b9cbfc529c2ba5fde4b2a6892b80', 0, 0, 0, 1459, 719, 1532);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xcc8356a48083c08c4792869ba6eb089cecb21797', 339, 0, 337, 503, 1385, 557);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x3cdafc99da990d56abedbc0af7b4247ad2dc5a74', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xf3cc32a6545faffd5b8266ea5f4654b420345f42', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x6f61d896a9b9e1087065e1630be44f394786f3d1', 1292, 1163, 973, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x5ee6e7174e759092a9e2408a3c73078ae5fb9c87', 13197, 14189, 16592, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x492ec88d26f1e934cc93754f904806794e0aca31', 14802, 15389, 13710, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xedcd33a9c1a6cff9a887e9054bb5933002ca13cc', 0, 0, 0, 2621, 4900, 7832);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x031aeada4ff6096cca3ed161ec6a06125ba3d066', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xcda3f9f535587a85aed04397d933864256dfe1dc', 43953, 43467, 48010, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x064401fa3796467257940bfc230e14abad73f378', 719, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xd887474fe347562450a9a892204abb3d13039550', 0, 0, 281, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xa982f2965130fa59305e480ff42ab6a563b406a3', 313, 562, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x96b59ac7d6d40bb27c90202a4793ad571cab15b3', 2263, 1841, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x4a74228bcac7cc2e6fa52eeb644005edbcb7ed9a', 604, 910, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xf8340c4d26d3787207133946e5a31f2ff4484df5', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xb8df3eebbb49a09495e08e284545f48c29013f98', 195, 0, 299, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x8246732bdd058b628b18661e69ab2fc1f29a432b', 0, 1948, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xfd599c8e0933abd0b842c436ad9e612ad625feb9', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x47bff18e462912ab61a465b2bc229e3857491aa6', 2859, 1536, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x759ec7d623ccf175e4a550d56381dc58a8a2c323', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x988d0ed33e9a5e7def0736bc693284bfbb190d17', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xbae01ad127c9e49179c9aa63109c0fc120782662', 652, 1592, 2760, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x12e6531c7e1f990d264cf0443ff7db196b9d18cc', 25871, 24129, 27289, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x7543ae755256476f32ec2cb49c253c4e5d47b806', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xe794e62d11a11bf1ee8ff34eacdbd1c20f20b7a6', 2320, 2390, 983, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x8812f12bf1b651b4c8231e033efc93b2cb8891fd', 7066, 9470, 4744, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xf363b614cd6536f2191ac6bf3bbdfc4030ed94da', 967, 380, 1966, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x592ba89811880eb4d9dfb759979b35da8b986295', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x9d67abaaa744b564fc605216dba6a8d684599537', 694, 395, 481, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xb9072e7f4b25b523cd2144b05e8734b68e18fcb9', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x0939ece40293c89df6f4639af3c7c35d799b5f00', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x613f2f6ef6f175a7f60217f3cb1c168ca922bc2d', 1985, 2063, 579, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xf580fd2b530e647b8ddce0e39e0e3e6cb9ad706a', 0, 0, 0, 614, 796, 1584);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x992b855f94f907e0ad8483140fd1f6d125c8aa03', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x61cca8707ae928298d3b3e8c1de0d7095b7b74b6', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x1af51642db6ec70e43e9d0cbc36872dd2f647f32', 1844, 2667, 1129, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xe72aa6533d38009ebc810ded93ccd69f32e49db2', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x27b7739f3aea9bc357526319c9cd82a0acb1887c', 236, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x135ebc63378e52d4b62081edd1a8db4c580a3441', 728, 0, 500, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xbeaaf573c71f50086f4e9491d2338abfd023446d', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x5fa6c2cdc923631b99f42e7ab0ac44800fba1419', 2359, 6665, 6674, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x2d17e331a7eb8073c647ebb70bf44a429f9d9b91', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x5017ac3361cd1a702f28eb20545a2af858b491ab', 5017, 5239, 7182, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x506b61f9dd0b2b3e93ef4646b35e64eaf5388d54', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xd9c5db99859b01c1212a098a5c79f74c572dfb00', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x0bddf4e169c35b77186c6ce1c987408689c4634d', 245, 361, 732, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xc1e7ca17274c36a3358460f93ce30200916688b6', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x81366eefbb88ca85d58db113b929fbc908a5b5df', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xa8fc32ed35cbf232cda8468da77e01183d3cd04c', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x3ec221a25b2dcf5634e4ff0af3b07ea17ae8d002', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xbf87fafcc5d86010744ade5e1669d785958fd871', 317, 1431, 439, 5395, 3968, 5747);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x02b16229cc3d4b0b7d1e6c6006a76e9eee387caf', 5846, 8740, 9061, 681, 1183, 1988);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x6b2f05b70a48e7b81d646d79e0b720c7577cd645', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x3beb5e96c21fee32c43bed747dc1fc4e57c5594e', 354, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xe51a2e65d8b43b045de3d1db9e64906d14c61b54', 3591, 3069, 4038, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x9dc6d51044fe2b9cb708a2e522ca21a62d35513e', 0, 0, 0, 712, 685, 1338);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x014d3239e6a0b9cb825527c8c365472a3e271028', 0, 345, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xd079429401ca47b190dcaf2853bb8ccde199b563', 1185, 3760, 2342, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xadad5545a77b1748e69600b5560f2153abc19de7', 0, 0, 0, 669, 1258, 770);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xcf220df87427b8d97954af31d266177c0bcb145d', 0, 448, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x67ba609c80f01ac8909d07a5c8f0f9c182c41bd3', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x242bf8c5a3dff71b6dd6821fb9ddfd493a6bcb1d', 310, 0, 520, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x485f8eced21e7581ed582f8d9394a4e7584c7d8e', 0, 372, 486, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x9420282ce93e91a0e756b8a33a48e64e863bca3e', 924, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x8386a270f99a9cc491934f4355047d78005715d0', 983, 3045, 2911, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x26ce8f32260f05e91faaf4f26569703cf5c52373', 0, 0, 0, 691, 669, 612);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x146e782479c3823e3addc2d0cc45ec57b8612276', 0, 0, 0, 0, 36825, 41104);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x1770de12a1b5b1283d56cd7a1e5fbe4fe284511e', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x442cac6c7add9dda8f9017074a10e45969b859c9', 4632, 2035, 2466, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xae763e853ef7cd9b52ddabdd4181fedda322f59f', 0, 0, 0, 704, 512, 1025);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x3b3c5ba49da136c2761ac39a888e50d7c02edf88', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x43766a37ef46c17f493803f6d190b1f7d0ac2e7a', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x75e5ef92fd7b6bcd54869f096e8278cc079f5036', 1956, 802, 1142, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xab5da83c4b2ef1d1921f426c405adb9e0d8ef056', 633, 1735, 939, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x491ffc953e1ab2751817ff90a5f32694a4841474', 28229, 26865, 30689, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x3cc47738fe7fc2587914d63420caf37cce129a02', 334, 339, 1057, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x536ee857fcffe9e0b33d5cb17b69264588728a78', 9715, 14096, 8168, 5137, 5867, 5628);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xaff85fbaefefb64fa0a535de424117a0a9d35b74', 303, 386, 1053, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x87a71aa6355a9dcbb43868f6a4ac54116e0aaa8a', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x5ec37ef774357717d06c53870c5bacac7d63fa07', 587, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x0fbebbcff5d4b0d8f6e440507350c7bb72bcd02e', 1066, 1419, 750, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xc78a4443164039a5d8cf91b75a090001e29d66fb', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x875576dfac97ef162a4b7b55fded46f2dd312ef0', 0, 0, 0, 649, 2815, 952);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xb79bcb0cd6672662bf93aa2bee16726c654ca4b1', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xde848f5949206a9e66e1800e2c5a69d2601fbc22', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xa65660a7c3c4408fe1ef6a33dfc3b1d312263b1b', 4862, 4722, 1485, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x414f5774846944908142e7c1fc6c91b5c14e0eea', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x80595a71b57636856b61e51a939aa511a5d4008d', 0, 0, 0, 697, 1463, 2771);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x1f137f133df19d65669165a0963fe72485c7fd0a', 700, 0, 938, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x4ce80cef4e36936a76ef8260afb9364cb44d6b82', 314, 0, 1168, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x8d0b928e34d0c2ea626fd84e79d6b221feab5030', 1046, 415, 2486, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x6eeca55c7cad1b1c1c3f872e1b5659f520c19a1f', 1964, 1213, 448, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x8bde4d211b511fb5b65977010315e6322a67044f', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x78cccc65a0bc2bbe502c07d28416649c5c6623b1', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x6013ad1e49066dc25bb8a82e2eb467add62265f9', 0, 2048, 2173, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x14f7c96aa0229a406efd67688c5187bee694de79', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x0efdcf9840fe91e3925e386d3633debed4369c27', 10269, 15642, 11647, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x27534ee6a1d10afae2cef0a68f17623d060f01c7', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x62c85407bfa12cf5350dc6ac5cf1fdf3f45cc15f', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x0581da444a46693496968d6611b15065fcf42140', 892, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xaffc193174e262e1201961ac3b5286a82d0e622e', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xd373dd844d7d10f7c3cfa0d6206de57380d35611', 614, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x34a0829701d144253566c789c4c4635132355ccd', 5797, 5278, 5737, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x7335f905b4dd29d58c5afcb4f8d8016e1eb5ad9b', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x2bf136e8ccb32e9a213a4ae6778d703cf55b5889', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x56c0723288e40e7edc516f358c9a9f01075c83bc', 4175, 2353, 1884, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x51a4545bf235564f263fd165728c06c0c0296413', 0, 384, 751, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x514d58823c12ec695ef378d4cb3013faa147105c', 0, 0, 0, 3401, 2267, 1581);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x7cebae9a7fadf20087b6ac67cdb5d2c4e89fa667', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xdbedfdc1659f17b76ddfefee426c2478d774c109', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xcbacf618fb3dcbe9a9000143be58eb01235efe9f', 328, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x34fab622936f58a77f18ea21cd4d3386afa68449', 0, 835, 968, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x16ecc0d028190ce0b74d52b450c4e00a19145885', 2058, 2168, 3607, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x9210cbb688eb68d0c0dec88da9d7ee8a6b8b4dec', 1343, 1017, 1882, 1054, 1634, 717);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xd690b90480010dcd01e13a26835d67d1c71fdae8', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x85799ff1c86f89fe9fb07773d1d240763b6039ce', 1009, 394, 1930, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x9bc66deb421faf05041ee69f8db194f6a34bdc37', 0, 551, 1128, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xf0db619363881ceb6ba06b9ae3dd4886652aa896', 0, 0, 544, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xdbfff9ca5955bcd25ce77dbeb27183cc329c8e24', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xabaf086c29e5ace29ba1fc79f0220c2f92385984', 3476, 4961, 4408, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xcf61d8fc50f84767ca932945d167fd613f5da53a', 7437, 4859, 6605, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x8cd78a617bffcfba5daf0c01b6af522590952fce', 657, 676, 1369, 5227, 4825, 3069);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xed66e493e956849ff67b3e546f8daf3d68ec380e', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x34cd39508ecaa638538e5a1b1be00ea3b7b5f2d6', 11914, 12736, 11932, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xe1c2fe8ee6d476debfa59e7e0b055cdee246fdef', 408, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x1bc65b00eabd7af0eb41f8d6d9934783391afea3', 0, 0, 0, 4121, 4076, 7063);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x9fcf1483f750dd5a8555797b8190af62e5fe4d44', 0, 1244, 740, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x9c854bf81c81cb5038ff3dd702e9e552f20fe1b5', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xca19d045317224c3bb84af1a403f70bd3589ef56', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x6b3a4bd72e25d26160e698d6e826c2ecbadef9c8', 1300, 378, 937, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x0f617402b5954a8118ce951fbbddaf1a4ac16310', 2466, 2417, 1777, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xf8c01c7bdfbb7d2add39ed08368217d605d31f2f', 14955, 15847, 22953, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xfd80f0c6e080599dafd2a3d0160f60f9c8868f9d', 653, 416, 469, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x4350bfccfcd52bb5512244fcc3ce2bc878e9aa82', 2445, 5457, 6339, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x09a5e9ffe158e81e677ff5b7ac7a966780ff2427', 2744, 2699, 5207, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x3edb1be154d8c8fc4818fa7695da7620ecd5ef91', 317, 0, 1104, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x1d0e5f3459e16dd67bb3a985aca0f1e92d72fe09', 1901, 2439, 1110, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x3ceec57a1f2be530c970f5dbd675d23d0ff3adfa', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x3013999a39d108e08193058054eac9db213a85be', 15551, 13211, 17816, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xa209a754da05c44e23d656a2bef3f6614d1cbeab', 38421, 34233, 37231, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x7d233827ec2949f79894ff9b37e35ff51216d080', 732, 776, 1231, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x7c719c3c98f416bb5fab3c00c09e518e5eb5c1b7', 0, 0, 0, 1787, 1790, 1452);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x8c9ce89b2db559276ae9d7cbc473ca90e65b36b7', 3848, 10208, 8026, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x4dc809d195167bb0e4e0405d3072d4595b443acb', 4521, 9124, 7767, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x740f995effa4e423b42f491a3e772ae82227224d', 5529, 10228, 9723, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xc339adc4352e66ac2d6bc14097d24b83dee5c01c', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x8a9865785dbbd747fd67536112daf3ee161bc287', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x319b916a699865618121b99e66e34b1cc597ec32', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xadbabcf1adff46f2a8f10783e3b70a23c0f00e51', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x7569a5b6e2e5c6ca2d0faf1a8cb5c80c60895b81', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x25341068524e657dd9434b6cf3738d27da87d66c', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x4b22a3c99bcc08d2ea14a5fb6a4d09777a65e6ff', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x5a6e9f05910e58c4fc2f8a0a766f576cafd49765', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x93bf79e6a9944e1aa6c843680066dbcaab226f17', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xbcd663e4856def593d86eca8898006d0eef03016', 6915, 9438, 6670, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xb600df397c596b0baad105c85374c1863226eff2', 1462, 880, 990, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xa3eedbe55d34899d8957470a20c35243a951cec6', 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xc37f000de73a3032eeaa4fa4cbf4db8ec527552f', 321, 0, 0, 0, 0, 0);
INSERT INTO public.base_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x6a74ce0ccc415d439f3c908e0817bb69c6d9046e', 0, 0, 0, 629, 761, 1752);


--
-- TOC entry 3576 (class 0 OID 18296)
-- Dependencies: 258
-- Data for Name: base_stats; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xab5da83c4b2ef1d1921f426c405adb9e0d8ef056', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x67ba609c80f01ac8909d07a5c8f0f9c182c41bd3', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x09a5e9ffe158e81e677ff5b7ac7a966780ff2427', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xe72aa6533d38009ebc810ded93ccd69f32e49db2', 5142, 2, 9520, 2, 6680, 2, 0, 2);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x7d233827ec2949f79894ff9b37e35ff51216d080', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x5fa6c2cdc923631b99f42e7ab0ac44800fba1419', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x51a4545bf235564f263fd165728c06c0c0296413', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x85799ff1c86f89fe9fb07773d1d240763b6039ce', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xd690b90480010dcd01e13a26835d67d1c71fdae8', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x414f5774846944908142e7c1fc6c91b5c14e0eea', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x9c854bf81c81cb5038ff3dd702e9e552f20fe1b5', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xcf220df87427b8d97954af31d266177c0bcb145d', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xe794e62d11a11bf1ee8ff34eacdbd1c20f20b7a6', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x1f137f133df19d65669165a0963fe72485c7fd0a', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xe51a2e65d8b43b045de3d1db9e64906d14c61b54', 373731, 55, 254718, 55, 308563, 55, 0, 57);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x34fab622936f58a77f18ea21cd4d3386afa68449', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x3ec221a25b2dcf5634e4ff0af3b07ea17ae8d002', 675, 1, 824, 1, 1676, 1, 0, 1);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x8386a270f99a9cc491934f4355047d78005715d0', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xd373dd844d7d10f7c3cfa0d6206de57380d35611', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x14f7c96aa0229a406efd67688c5187bee694de79', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x875576dfac97ef162a4b7b55fded46f2dd312ef0', 0, 0, 0, 0, 0, 0, 0, 1);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x8cd78a617bffcfba5daf0c01b6af522590952fce', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x78cccc65a0bc2bbe502c07d28416649c5c6623b1', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x16ecc0d028190ce0b74d52b450c4e00a19145885', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x1bc65b00eabd7af0eb41f8d6d9934783391afea3', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x34a0829701d144253566c789c4c4635132355ccd', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x7cebae9a7fadf20087b6ac67cdb5d2c4e89fa667', 5806, 2, 6423, 2, 6660, 2, 0, 2);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xbcd663e4856def593d86eca8898006d0eef03016', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x8a9865785dbbd747fd67536112daf3ee161bc287', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x4dc809d195167bb0e4e0405d3072d4595b443acb', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x124b76631b4add879a9bf5a7759cfa3a1d78ca2c', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x2d17e331a7eb8073c647ebb70bf44a429f9d9b91', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x02b16229cc3d4b0b7d1e6c6006a76e9eee387caf', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x25341068524e657dd9434b6cf3738d27da87d66c', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x1af51642db6ec70e43e9d0cbc36872dd2f647f32', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xc339adc4352e66ac2d6bc14097d24b83dee5c01c', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x0d960b67269b0837c0ebf6a09cce69377590f020', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x506b61f9dd0b2b3e93ef4646b35e64eaf5388d54', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xfd599c8e0933abd0b842c436ad9e612ad625feb9', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xbeaaf573c71f50086f4e9491d2338abfd023446d', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xbae01ad127c9e49179c9aa63109c0fc120782662', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x0939ece40293c89df6f4639af3c7c35d799b5f00', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x81366eefbb88ca85d58db113b929fbc908a5b5df', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x613f2f6ef6f175a7f60217f3cb1c168ca922bc2d', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x0bddf4e169c35b77186c6ce1c987408689c4634d', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x8bde4d211b511fb5b65977010315e6322a67044f', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x759ec7d623ccf175e4a550d56381dc58a8a2c323', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x536ee857fcffe9e0b33d5cb17b69264588728a78', 0, 0, 0, 0, 0, 0, 0, 1);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xe1c2fe8ee6d476debfa59e7e0b055cdee246fdef', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xa8fc32ed35cbf232cda8468da77e01183d3cd04c', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x6b2f05b70a48e7b81d646d79e0b720c7577cd645', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xbf87fafcc5d86010744ade5e1669d785958fd871', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xb8df3eebbb49a09495e08e284545f48c29013f98', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x8d0b928e34d0c2ea626fd84e79d6b221feab5030', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x5ee6e7174e759092a9e2408a3c73078ae5fb9c87', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xf3cc32a6545faffd5b8266ea5f4654b420345f42', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xae763e853ef7cd9b52ddabdd4181fedda322f59f', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x26ce8f32260f05e91faaf4f26569703cf5c52373', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x6b3a4bd72e25d26160e698d6e826c2ecbadef9c8', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xccdf7faf3e42b9cbfc529c2ba5fde4b2a6892b80', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x47bff18e462912ab61a465b2bc229e3857491aa6', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x9bc66deb421faf05041ee69f8db194f6a34bdc37', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x135ebc63378e52d4b62081edd1a8db4c580a3441', 8120, 3, 7026, 3, 5881, 3, 0, 3);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x5ec37ef774357717d06c53870c5bacac7d63fa07', 1727, 2, 2201, 2, 2658, 2, 0, 3);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xadbabcf1adff46f2a8f10783e3b70a23c0f00e51', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xaff85fbaefefb64fa0a535de424117a0a9d35b74', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xca19d045317224c3bb84af1a403f70bd3589ef56', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x6013ad1e49066dc25bb8a82e2eb467add62265f9', 724, 1, 863, 1, 1339, 1, 0, 1);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x8812f12bf1b651b4c8231e033efc93b2cb8891fd', 1263, 1, 753, 1, 1324, 1, 0, 1);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xd079429401ca47b190dcaf2853bb8ccde199b563', 2914, 1, 1327, 1, 2058, 1, 0, 1);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x27534ee6a1d10afae2cef0a68f17623d060f01c7', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x62c85407bfa12cf5350dc6ac5cf1fdf3f45cc15f', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xd9c5db99859b01c1212a098a5c79f74c572dfb00', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xf282529a89e131791f15ca45d32c6e1267987ced', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x3e95e93ace1d56792d3ed326b3f20d32f050fd9f', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xc9634ebc37b543cbee414fcc4426f447370e50b5', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xd7b2913be8247d7b54ec38366dc45fbe21fb4587', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xe13abdb784435f7e12656daa2fee2687b4486152', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xf8340c4d26d3787207133946e5a31f2ff4484df5', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x2bf136e8ccb32e9a213a4ae6778d703cf55b5889', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xa65660a7c3c4408fe1ef6a33dfc3b1d312263b1b', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xb9072e7f4b25b523cd2144b05e8734b68e18fcb9', 44450, 39, 37964, 39, 37866, 38, 0, 39);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x87a71aa6355a9dcbb43868f6a4ac54116e0aaa8a', 9243, 5, 8844, 4, 9460, 4, 0, 8);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x7569a5b6e2e5c6ca2d0faf1a8cb5c80c60895b81', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x9f8d9c183150f15ffba39b7b17c3e1a78e5e5478', 1326, 1, 1431, 1, 0, 0, 0, 1);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xa3eedbe55d34899d8957470a20c35243a951cec6', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xb600df397c596b0baad105c85374c1863226eff2', 144882, 10, 111685, 10, 128329, 10, 0, 10);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x988d0ed33e9a5e7def0736bc693284bfbb190d17', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x75e5ef92fd7b6bcd54869f096e8278cc079f5036', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x8246732bdd058b628b18661e69ab2fc1f29a432b', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x014d3239e6a0b9cb825527c8c365472a3e271028', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x992b855f94f907e0ad8483140fd1f6d125c8aa03', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x0efdcf9840fe91e3925e386d3633debed4369c27', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xc1e7ca17274c36a3358460f93ce30200916688b6', 2225, 2, 2208, 2, 1536, 2, 0, 2);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xf580fd2b530e647b8ddce0e39e0e3e6cb9ad706a', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xb79bcb0cd6672662bf93aa2bee16726c654ca4b1', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xebd9a48ed1128375eb4383ed4d53478b4fd85a8d', 40620, 6, 34820, 6, 36067, 5, 0, 6);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xa209a754da05c44e23d656a2bef3f6614d1cbeab', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xed66e493e956849ff67b3e546f8daf3d68ec380e', 3873, 1, 1281, 1, 1514, 1, 0, 1);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x3beb5e96c21fee32c43bed747dc1fc4e57c5594e', 703, 1, 844, 1, 1807, 1, 0, 1);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x56c0723288e40e7edc516f358c9a9f01075c83bc', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x4ce80cef4e36936a76ef8260afb9364cb44d6b82', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xfd80f0c6e080599dafd2a3d0160f60f9c8868f9d', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x9fcf1483f750dd5a8555797b8190af62e5fe4d44', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xabaf086c29e5ace29ba1fc79f0220c2f92385984', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xcbacf618fb3dcbe9a9000143be58eb01235efe9f', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xdbfff9ca5955bcd25ce77dbeb27183cc329c8e24', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x80595a71b57636856b61e51a939aa511a5d4008d', 0, 0, 0, 0, 0, 0, 0, 1);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x0f617402b5954a8118ce951fbbddaf1a4ac16310', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xde848f5949206a9e66e1800e2c5a69d2601fbc22', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xc78a4443164039a5d8cf91b75a090001e29d66fb', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x4b22a3c99bcc08d2ea14a5fb6a4d09777a65e6ff', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x93bf79e6a9944e1aa6c843680066dbcaab226f17', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x6a74ce0ccc415d439f3c908e0817bb69c6d9046e', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x740f995effa4e423b42f491a3e772ae82227224d', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x3ceec57a1f2be530c970f5dbd675d23d0ff3adfa', 6113, 2, 4379, 2, 4337, 2, 0, 2);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x242bf8c5a3dff71b6dd6821fb9ddfd493a6bcb1d', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x031aeada4ff6096cca3ed161ec6a06125ba3d066', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x3c69cf466b8ccede9b7d25a96080eafbd02c446d', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x8c6b1d93b59db869fd232a0e7ca38bcc696914c9', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xa56cc2cc3fab1a0da80268ea83effbac3daaedc0', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x6c96d29e8763ca0996f983c0469630a60b108c9f', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x17b339dd9579aec49d075d539729552b3488ebd2', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x932bad9228d2bb187548677ce6712f9b001993a9', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x542325af03aff2b3ac9f0882b4442590717362c0', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x914bd52a86f6f2f3fc72843e69ee2dd8a54ed50c', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xc9ac4dcb8927891274442484701c104845a23367', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xd887474fe347562450a9a892204abb3d13039550', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x96b59ac7d6d40bb27c90202a4793ad571cab15b3', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xba1688252983cddf5c5484975f9e8da35ceb91bb', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xd3a2978a9ad5ea4e76520594646ef7e8e1fffe1f', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x10bdaea978fbad26b045278a04a42fd13949caa3', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x8626f6940e2eb28930efb4cef49b2d1f2c9c1199', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xb93701293b1bbeaa7d4b0a73449d30a1fcf459f0', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x18688146713a8c38310547b473dd87c28cd941c6', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x292e84772e3ce9a5db4ba914b83b89b74886f1bd', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xe0e11ee72a99d9b74708f70a97bc4af5f331defc', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x1f6239b44952fa8ccbe3de87fae8198867277f65', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x30303463339b79f36f548ee6c171ac0e00d713ae', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xd6affec06f7688484643b50f7fae00927ceab84a', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x705317be1e94317672fcd2f39d7f5e607f9e4d97', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xbc90ead9929590f4490b400c766975ac8c150e9a', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x629dff6da36666063a31d59abf4302fcaabb2c11', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xc2100a5022cd8fd7beedde6195a8894f2f0265da', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x7bacff455a5d921d2c953180083d488bd380eb2a', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x92124ee0e7238992e5e7f34f9fbbcd71931abc6d', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x300f555bf2a6ba5e090d224687d8ff4703cd0f52', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xa982f2965130fa59305e480ff42ab6a563b406a3', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x064401fa3796467257940bfc230e14abad73f378', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x9420282ce93e91a0e756b8a33a48e64e863bca3e', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x93b7ee22a179c00e98e80792e89bae613f22c622', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x6f61d896a9b9e1087065e1630be44f394786f3d1', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xcc8356a48083c08c4792869ba6eb089cecb21797', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x492ec88d26f1e934cc93754f904806794e0aca31', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xcda3f9f535587a85aed04397d933864256dfe1dc', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x3cdafc99da990d56abedbc0af7b4247ad2dc5a74', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x3013999a39d108e08193058054eac9db213a85be', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xc9792727ef67867670d85ba7b8b694368f10ab5c', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xfa5a1f0e3b506acb0d5183dbff6d0d6f33bcaea5', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x3b3c5ba49da136c2761ac39a888e50d7c02edf88', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x592ba89811880eb4d9dfb759979b35da8b986295', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x1770de12a1b5b1283d56cd7a1e5fbe4fe284511e', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xf363b614cd6536f2191ac6bf3bbdfc4030ed94da', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x485f8eced21e7581ed582f8d9394a4e7584c7d8e', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x442cac6c7add9dda8f9017074a10e45969b859c9', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x7543ae755256476f32ec2cb49c253c4e5d47b806', 5088, 1, 1301, 1, 4267, 1, 0, 1);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xedcd33a9c1a6cff9a887e9054bb5933002ca13cc', 21680, 2, 19631, 2, 19143, 2, 0, 2);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x319b916a699865618121b99e66e34b1cc597ec32', 123085, 8, 130403, 8, 133347, 8, 0, 8);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xdfdcc1a06b5d833c89197b8c216ac497d67ca5d9', 0, 0, 0, 0, 0, 0, 0, 1);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x5017ac3361cd1a702f28eb20545a2af858b491ab', 67155, 1, 83265, 1, 101973, 1, 0, 1);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xf0c56251ce95e39882cc58f3cc14272771ae2f44', 911, 1, 707, 1, 1046, 1, 0, 1);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x0145582cb27bd79163462029a81bbb0b56a3991e', 202166, 21, 187721, 21, 211991, 19, 0, 21);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x4a74228bcac7cc2e6fa52eeb644005edbcb7ed9a', 2843, 2, 3951, 2, 3673, 2, 0, 2);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x27b7739f3aea9bc357526319c9cd82a0acb1887c', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x9d67abaaa744b564fc605216dba6a8d684599537', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xc37f000de73a3032eeaa4fa4cbf4db8ec527552f', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x1d0e5f3459e16dd67bb3a985aca0f1e92d72fe09', 2788, 1, 7072, 1, 6874, 1, 0, 1);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x8c9ce89b2db559276ae9d7cbc473ca90e65b36b7', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x9210cbb688eb68d0c0dec88da9d7ee8a6b8b4dec', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x43766a37ef46c17f493803f6d190b1f7d0ac2e7a', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x4350bfccfcd52bb5512244fcc3ce2bc878e9aa82', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x9dc6d51044fe2b9cb708a2e522ca21a62d35513e', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x12e6531c7e1f990d264cf0443ff7db196b9d18cc', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xdbedfdc1659f17b76ddfefee426c2478d774c109', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x0581da444a46693496968d6611b15065fcf42140', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xaac5e7e4d9d3b535a286e5a784d64d67af7dd4a1', 1315634, 416, 1138330, 418, 1268333, 405, 0, 197);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xadad5545a77b1748e69600b5560f2153abc19de7', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x5a6e9f05910e58c4fc2f8a0a766f576cafd49765', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x6eeca55c7cad1b1c1c3f872e1b5659f520c19a1f', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x3cc47738fe7fc2587914d63420caf37cce129a02', 3561, 2, 5939, 2, 5483, 1, 0, 4);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x3edb1be154d8c8fc4818fa7695da7620ecd5ef91', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x0fbebbcff5d4b0d8f6e440507350c7bb72bcd02e', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xaffc193174e262e1201961ac3b5286a82d0e622e', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xf8c01c7bdfbb7d2add39ed08368217d605d31f2f', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xcf61d8fc50f84767ca932945d167fd613f5da53a', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x34cd39508ecaa638538e5a1b1be00ea3b7b5f2d6', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x514d58823c12ec695ef378d4cb3013faa147105c', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x491ffc953e1ab2751817ff90a5f32694a4841474', 16302, 2, 14477, 2, 16538, 2, 0, 2);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x146e782479c3823e3addc2d0cc45ec57b8612276', 37235, 1, 0, 0, 0, 0, 0, 2);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xf0db619363881ceb6ba06b9ae3dd4886652aa896', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x7335f905b4dd29d58c5afcb4f8d8016e1eb5ad9b', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x7c719c3c98f416bb5fab3c00c09e518e5eb5c1b7', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.base_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x61cca8707ae928298d3b3e8c1de0d7095b7b74b6', 179283, 6, 196752, 6, 206243, 6, 0, 7);


--
-- TOC entry 3568 (class 0 OID 17492)
-- Dependencies: 250
-- Data for Name: blockchain; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.blockchain (name, latest_block, updated_at) VALUES ('manta-testnet', 794818, 1691154169);


--
-- TOC entry 3572 (class 0 OID 17519)
-- Dependencies: 254
-- Data for Name: exhausted_tile; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.exhausted_tile (id, uuid, x, y) VALUES (86938, 'fde016b577d0526f2b5a937a1b9dd194', 30, 86);
INSERT INTO public.exhausted_tile (id, uuid, x, y) VALUES (86939, 'fde016b577d0526f2b5a937a1b9dd194', 30, 87);
INSERT INTO public.exhausted_tile (id, uuid, x, y) VALUES (86940, 'fde016b577d0526f2b5a937a1b9dd194', 30, 88);
INSERT INTO public.exhausted_tile (id, uuid, x, y) VALUES (86941, 'fde016b577d0526f2b5a937a1b9dd194', 31, 88);
INSERT INTO public.exhausted_tile (id, uuid, x, y) VALUES (86942, 'fde016b577d0526f2b5a937a1b9dd194', 31, 87);
INSERT INTO public.exhausted_tile (id, uuid, x, y) VALUES (86943, 'fde016b577d0526f2b5a937a1b9dd194', 31, 86);
INSERT INTO public.exhausted_tile (id, uuid, x, y) VALUES (86944, 'fde016b577d0526f2b5a937a1b9dd194', 31, 85);
INSERT INTO public.exhausted_tile (id, uuid, x, y) VALUES (86945, 'fde016b577d0526f2b5a937a1b9dd194', 31, 84);
INSERT INTO public.exhausted_tile (id, uuid, x, y) VALUES (86946, 'fde016b577d0526f2b5a937a1b9dd194', 31, 83);
INSERT INTO public.exhausted_tile (id, uuid, x, y) VALUES (86947, 'dee796b688181c62d879d590ff62aee9', 12, 86);
INSERT INTO public.exhausted_tile (id, uuid, x, y) VALUES (86948, 'dee796b688181c62d879d590ff62aee9', 12, 87);
INSERT INTO public.exhausted_tile (id, uuid, x, y) VALUES (86949, 'dee796b688181c62d879d590ff62aee9', 12, 88);


--
-- TOC entry 3579 (class 0 OID 20107)
-- Dependencies: 261
-- Data for Name: login_tracker; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.login_tracker (date, total_logins) VALUES (1695081600000, 78);
INSERT INTO public.login_tracker (date, total_logins) VALUES (1695168000000, 66);
INSERT INTO public.login_tracker (date, total_logins) VALUES (1695254400000, 61);
INSERT INTO public.login_tracker (date, total_logins) VALUES (1695340800000, 48);
INSERT INTO public.login_tracker (date, total_logins) VALUES (1695427200000, 29);
INSERT INTO public.login_tracker (date, total_logins) VALUES (1695513600000, 29);
INSERT INTO public.login_tracker (date, total_logins) VALUES (1695600000000, 26);
INSERT INTO public.login_tracker (date, total_logins) VALUES (1695686400000, 27);
INSERT INTO public.login_tracker (date, total_logins) VALUES (1695772800000, 26);
INSERT INTO public.login_tracker (date, total_logins) VALUES (1695859200000, 37);
INSERT INTO public.login_tracker (date, total_logins) VALUES (1695945600000, 33);
INSERT INTO public.login_tracker (date, total_logins) VALUES (1696032000000, 26);
INSERT INTO public.login_tracker (date, total_logins) VALUES (1696118400000, 24);
INSERT INTO public.login_tracker (date, total_logins) VALUES (1696204800000, 25);
INSERT INTO public.login_tracker (date, total_logins) VALUES (1696291200000, 24);


--
-- TOC entry 3570 (class 0 OID 17509)
-- Dependencies: 252
-- Data for Name: manta_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x18688146713a8c38310547b473dd87c28cd941c6', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x8a9865785dbbd747fd67536112daf3ee161bc287', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x300f555bf2a6ba5e090d224687d8ff4703cd0f52', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xf0c56251ce95e39882cc58f3cc14272771ae2f44', 955, 2159, 1139, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x7bacff455a5d921d2c953180083d488bd380eb2a', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xba1688252983cddf5c5484975f9e8da35ceb91bb', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xa982f2965130fa59305e480ff42ab6a563b406a3', 313, 562, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x8c6b1d93b59db869fd232a0e7ca38bcc696914c9', 0, 0, 862, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x6c96d29e8763ca0996f983c0469630a60b108c9f', 534, 207, 1091, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x81366eefbb88ca85d58db113b929fbc908a5b5df', 0, 0, 0, 570, 619, 697);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x5ee6e7174e759092a9e2408a3c73078ae5fb9c87', 13197, 14189, 16592, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xd3a2978a9ad5ea4e76520594646ef7e8e1fffe1f', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x124b76631b4add879a9bf5a7759cfa3a1d78ca2c', 347, 456, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x3c69cf466b8ccede9b7d25a96080eafbd02c446d', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xf363b614cd6536f2191ac6bf3bbdfc4030ed94da', 967, 380, 1966, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x3cdafc99da990d56abedbc0af7b4247ad2dc5a74', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x759ec7d623ccf175e4a550d56381dc58a8a2c323', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x1f6239b44952fa8ccbe3de87fae8198867277f65', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x96b59ac7d6d40bb27c90202a4793ad571cab15b3', 2263, 1841, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xbc90ead9929590f4490b400c766975ac8c150e9a', 1588, 2086, 1627, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x3e95e93ace1d56792d3ed326b3f20d32f050fd9f', 279, 717, 538, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xb93701293b1bbeaa7d4b0a73449d30a1fcf459f0', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x705317be1e94317672fcd2f39d7f5e607f9e4d97', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xa56cc2cc3fab1a0da80268ea83effbac3daaedc0', 208, 950, 847, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x10bdaea978fbad26b045278a04a42fd13949caa3', 190, 1626, 263, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x92124ee0e7238992e5e7f34f9fbbcd71931abc6d', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xc9634ebc37b543cbee414fcc4426f447370e50b5', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xe0e11ee72a99d9b74708f70a97bc4af5f331defc', 152, 0, 352, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x292e84772e3ce9a5db4ba914b83b89b74886f1bd', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x17b339dd9579aec49d075d539729552b3488ebd2', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xbdd05454794736c83b03ee2958999924782f684f', 0, 0, 0, 804, 1151, 520);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x629dff6da36666063a31d59abf4302fcaabb2c11', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x9420282ce93e91a0e756b8a33a48e64e863bca3e', 924, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x90e1ad3a81411b60c73dbebdc3fe985f73a990b0', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x30303463339b79f36f548ee6c171ac0e00d713ae', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xbae01ad127c9e49179c9aa63109c0fc120782662', 652, 1592, 2760, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xe13abdb784435f7e12656daa2fee2687b4486152', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x8626f6940e2eb28930efb4cef49b2d1f2c9c1199', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x2d17e331a7eb8073c647ebb70bf44a429f9d9b91', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x6013ad1e49066dc25bb8a82e2eb467add62265f9', 0, 2048, 2173, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x47bff18e462912ab61a465b2bc229e3857491aa6', 2859, 1536, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x9bca95c511bb1e42641c6abc1778d68506989842', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xd887474fe347562450a9a892204abb3d13039550', 0, 0, 281, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x542325af03aff2b3ac9f0882b4442590717362c0', 350, 800, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xd7b2913be8247d7b54ec38366dc45fbe21fb4587', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xd6affec06f7688484643b50f7fae00927ceab84a', 366, 428, 556, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x9bc66deb421faf05041ee69f8db194f6a34bdc37', 0, 551, 1128, 0, 1258, 1332);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x6eeca55c7cad1b1c1c3f872e1b5659f520c19a1f', 1964, 1213, 448, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x27b7739f3aea9bc357526319c9cd82a0acb1887c', 236, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x506b61f9dd0b2b3e93ef4646b35e64eaf5388d54', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xa8fc32ed35cbf232cda8468da77e01183d3cd04c', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x932bad9228d2bb187548677ce6712f9b001993a9', 328, 900, 1273, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xf3cc32a6545faffd5b8266ea5f4654b420345f42', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xf282529a89e131791f15ca45d32c6e1267987ced', 423, 1396, 547, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x031aeada4ff6096cca3ed161ec6a06125ba3d066', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xc9ac4dcb8927891274442484701c104845a23367', 1176, 610, 2013, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x93b7ee22a179c00e98e80792e89bae613f22c622', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x0d960b67269b0837c0ebf6a09cce69377590f020', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xcc8356a48083c08c4792869ba6eb089cecb21797', 339, 0, 337, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xccdf7faf3e42b9cbfc529c2ba5fde4b2a6892b80', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xd9c5db99859b01c1212a098a5c79f74c572dfb00', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xfd599c8e0933abd0b842c436ad9e612ad625feb9', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x064401fa3796467257940bfc230e14abad73f378', 719, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x592ba89811880eb4d9dfb759979b35da8b986295', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x988d0ed33e9a5e7def0736bc693284bfbb190d17', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x26ce8f32260f05e91faaf4f26569703cf5c52373', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xebd9a48ed1128375eb4383ed4d53478b4fd85a8d', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x0bddf4e169c35b77186c6ce1c987408689c4634d', 245, 361, 732, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x61cca8707ae928298d3b3e8c1de0d7095b7b74b6', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xd373dd844d7d10f7c3cfa0d6206de57380d35611', 614, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xedcd33a9c1a6cff9a887e9054bb5933002ca13cc', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xb8df3eebbb49a09495e08e284545f48c29013f98', 195, 0, 299, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x4a74228bcac7cc2e6fa52eeb644005edbcb7ed9a', 604, 910, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x43766a37ef46c17f493803f6d190b1f7d0ac2e7a', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x9d67abaaa744b564fc605216dba6a8d684599537', 694, 395, 481, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x75e5ef92fd7b6bcd54869f096e8278cc079f5036', 1956, 802, 1142, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x6f61d896a9b9e1087065e1630be44f394786f3d1', 1292, 1163, 973, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x992b855f94f907e0ad8483140fd1f6d125c8aa03', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x5fa6c2cdc923631b99f42e7ab0ac44800fba1419', 2359, 6665, 6674, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x7569a5b6e2e5c6ca2d0faf1a8cb5c80c60895b81', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x135ebc63378e52d4b62081edd1a8db4c580a3441', 728, 0, 500, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xc2100a5022cd8fd7beedde6195a8894f2f0265da', 569, 1068, 449, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x014d3239e6a0b9cb825527c8c365472a3e271028', 0, 345, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x9dc6d51044fe2b9cb708a2e522ca21a62d35513e', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xcf220df87427b8d97954af31d266177c0bcb145d', 0, 448, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x875576dfac97ef162a4b7b55fded46f2dd312ef0', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x5ec37ef774357717d06c53870c5bacac7d63fa07', 587, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x1af51642db6ec70e43e9d0cbc36872dd2f647f32', 1844, 2667, 1129, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x0939ece40293c89df6f4639af3c7c35d799b5f00', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xadad5545a77b1748e69600b5560f2153abc19de7', 0, 0, 0, 682, 1452, 1225);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xc9792727ef67867670d85ba7b8b694368f10ab5c', 1679, 1998, 494, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x914bd52a86f6f2f3fc72843e69ee2dd8a54ed50c', 1072, 1137, 1910, 8459, 12139, 12895);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xfa5a1f0e3b506acb0d5183dbff6d0d6f33bcaea5', 3034, 4355, 6942, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xbeaaf573c71f50086f4e9491d2338abfd023446d', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x3beb5e96c21fee32c43bed747dc1fc4e57c5594e', 354, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xb9072e7f4b25b523cd2144b05e8734b68e18fcb9', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x67ba609c80f01ac8909d07a5c8f0f9c182c41bd3', 0, 0, 0, 707, 1392, 1650);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x7cebae9a7fadf20087b6ac67cdb5d2c4e89fa667', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x6b2f05b70a48e7b81d646d79e0b720c7577cd645', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x1770de12a1b5b1283d56cd7a1e5fbe4fe284511e', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xae763e853ef7cd9b52ddabdd4181fedda322f59f', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x613f2f6ef6f175a7f60217f3cb1c168ca922bc2d', 1985, 2063, 579, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x27534ee6a1d10afae2cef0a68f17623d060f01c7', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x3ec221a25b2dcf5634e4ff0af3b07ea17ae8d002', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x8246732bdd058b628b18661e69ab2fc1f29a432b', 0, 1948, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x242bf8c5a3dff71b6dd6821fb9ddfd493a6bcb1d', 310, 0, 520, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xbf87fafcc5d86010744ade5e1669d785958fd871', 317, 1431, 439, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x8386a270f99a9cc491934f4355047d78005715d0', 983, 3045, 2911, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x485f8eced21e7581ed582f8d9394a4e7584c7d8e', 0, 372, 486, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x514d58823c12ec695ef378d4cb3013faa147105c', 0, 0, 0, 0, 3500, 6175);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xf580fd2b530e647b8ddce0e39e0e3e6cb9ad706a', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x02b16229cc3d4b0b7d1e6c6006a76e9eee387caf', 5846, 8740, 9061, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x414f5774846944908142e7c1fc6c91b5c14e0eea', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xb79bcb0cd6672662bf93aa2bee16726c654ca4b1', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xc1e7ca17274c36a3358460f93ce30200916688b6', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xaffc193174e262e1201961ac3b5286a82d0e622e', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x1f137f133df19d65669165a0963fe72485c7fd0a', 700, 0, 938, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x8812f12bf1b651b4c8231e033efc93b2cb8891fd', 7066, 9470, 4744, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x442cac6c7add9dda8f9017074a10e45969b859c9', 4632, 2035, 2466, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x8bde4d211b511fb5b65977010315e6322a67044f', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x8cd78a617bffcfba5daf0c01b6af522590952fce', 657, 676, 1369, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x78cccc65a0bc2bbe502c07d28416649c5c6623b1', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x7543ae755256476f32ec2cb49c253c4e5d47b806', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xe794e62d11a11bf1ee8ff34eacdbd1c20f20b7a6', 2320, 2390, 983, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xcda3f9f535587a85aed04397d933864256dfe1dc', 43953, 43467, 48010, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x0fbebbcff5d4b0d8f6e440507350c7bb72bcd02e', 1066, 1419, 750, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xcbacf618fb3dcbe9a9000143be58eb01235efe9f', 328, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x56c0723288e40e7edc516f358c9a9f01075c83bc', 4175, 2353, 1884, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xc78a4443164039a5d8cf91b75a090001e29d66fb', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x8d0b928e34d0c2ea626fd84e79d6b221feab5030', 1046, 415, 2486, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x2bf136e8ccb32e9a213a4ae6778d703cf55b5889', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x62c85407bfa12cf5350dc6ac5cf1fdf3f45cc15f', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x0581da444a46693496968d6611b15065fcf42140', 892, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x9f8d9c183150f15ffba39b7b17c3e1a78e5e5478', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x80595a71b57636856b61e51a939aa511a5d4008d', 0, 0, 0, 0, 0, 461);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x51a4545bf235564f263fd165728c06c0c0296413', 0, 384, 751, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x87a71aa6355a9dcbb43868f6a4ac54116e0aaa8a', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x3edb1be154d8c8fc4818fa7695da7620ecd5ef91', 317, 0, 1104, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x0f617402b5954a8118ce951fbbddaf1a4ac16310', 2466, 2417, 1777, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xab5da83c4b2ef1d1921f426c405adb9e0d8ef056', 633, 1735, 939, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xf0db619363881ceb6ba06b9ae3dd4886652aa896', 0, 0, 544, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x7335f905b4dd29d58c5afcb4f8d8016e1eb5ad9b', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xdbedfdc1659f17b76ddfefee426c2478d774c109', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x14f7c96aa0229a406efd67688c5187bee694de79', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x0efdcf9840fe91e3925e386d3633debed4369c27', 10269, 15642, 11647, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xdbfff9ca5955bcd25ce77dbeb27183cc329c8e24', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x34cd39508ecaa638538e5a1b1be00ea3b7b5f2d6', 11914, 12736, 11932, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xcf61d8fc50f84767ca932945d167fd613f5da53a', 7437, 4859, 6605, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x536ee857fcffe9e0b33d5cb17b69264588728a78', 9715, 14096, 8168, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xe72aa6533d38009ebc810ded93ccd69f32e49db2', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x85799ff1c86f89fe9fb07773d1d240763b6039ce', 1009, 394, 1930, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xd690b90480010dcd01e13a26835d67d1c71fdae8', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x4ce80cef4e36936a76ef8260afb9364cb44d6b82', 314, 0, 1168, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xc339adc4352e66ac2d6bc14097d24b83dee5c01c', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xf8340c4d26d3787207133946e5a31f2ff4484df5', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x34a0829701d144253566c789c4c4635132355ccd', 5797, 5278, 5737, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xc37f000de73a3032eeaa4fa4cbf4db8ec527552f', 321, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xabaf086c29e5ace29ba1fc79f0220c2f92385984', 3476, 4961, 4408, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xfd80f0c6e080599dafd2a3d0160f60f9c8868f9d', 653, 416, 469, 9583, 9823, 15328);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xaff85fbaefefb64fa0a535de424117a0a9d35b74', 303, 386, 1053, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xe51a2e65d8b43b045de3d1db9e64906d14c61b54', 3591, 3069, 4038, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xde848f5949206a9e66e1800e2c5a69d2601fbc22', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x34fab622936f58a77f18ea21cd4d3386afa68449', 0, 835, 968, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xed66e493e956849ff67b3e546f8daf3d68ec380e', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xe1c2fe8ee6d476debfa59e7e0b055cdee246fdef', 408, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xa65660a7c3c4408fe1ef6a33dfc3b1d312263b1b', 4862, 4722, 1485, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x5017ac3361cd1a702f28eb20545a2af858b491ab', 5017, 5239, 7182, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x9c854bf81c81cb5038ff3dd702e9e552f20fe1b5', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x09a5e9ffe158e81e677ff5b7ac7a966780ff2427', 2744, 2699, 5207, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x16ecc0d028190ce0b74d52b450c4e00a19145885', 2058, 2168, 3607, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x4350bfccfcd52bb5512244fcc3ce2bc878e9aa82', 2445, 5457, 6339, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xd079429401ca47b190dcaf2853bb8ccde199b563', 1185, 3760, 2342, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x9fcf1483f750dd5a8555797b8190af62e5fe4d44', 0, 1244, 740, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x1bc65b00eabd7af0eb41f8d6d9934783391afea3', 0, 0, 0, 0, 0, 935);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x6b3a4bd72e25d26160e698d6e826c2ecbadef9c8', 1300, 378, 937, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xca19d045317224c3bb84af1a403f70bd3589ef56', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x492ec88d26f1e934cc93754f904806794e0aca31', 14802, 15389, 13710, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x3cc47738fe7fc2587914d63420caf37cce129a02', 334, 339, 1057, 19109, 15027, 21805);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x146e782479c3823e3addc2d0cc45ec57b8612276', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x8c9ce89b2db559276ae9d7cbc473ca90e65b36b7', 3848, 10208, 8026, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x93bf79e6a9944e1aa6c843680066dbcaab226f17', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x1d0e5f3459e16dd67bb3a985aca0f1e92d72fe09', 1901, 2439, 1110, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x491ffc953e1ab2751817ff90a5f32694a4841474', 28229, 26865, 30689, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x12e6531c7e1f990d264cf0443ff7db196b9d18cc', 25871, 24129, 27289, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x3b3c5ba49da136c2761ac39a888e50d7c02edf88', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x4dc809d195167bb0e4e0405d3072d4595b443acb', 4521, 9124, 7767, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x4b22a3c99bcc08d2ea14a5fb6a4d09777a65e6ff', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x9210cbb688eb68d0c0dec88da9d7ee8a6b8b4dec', 1343, 1017, 1882, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x3013999a39d108e08193058054eac9db213a85be', 15551, 13211, 17816, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xa209a754da05c44e23d656a2bef3f6614d1cbeab', 38421, 34233, 37231, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x7d233827ec2949f79894ff9b37e35ff51216d080', 732, 776, 1231, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x0145582cb27bd79163462029a81bbb0b56a3991e', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xadbabcf1adff46f2a8f10783e3b70a23c0f00e51', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x740f995effa4e423b42f491a3e772ae82227224d', 5529, 10228, 9723, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x319b916a699865618121b99e66e34b1cc597ec32', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x3ceec57a1f2be530c970f5dbd675d23d0ff3adfa', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x7c719c3c98f416bb5fab3c00c09e518e5eb5c1b7', 0, 0, 0, 0, 422, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x5a6e9f05910e58c4fc2f8a0a766f576cafd49765', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xb600df397c596b0baad105c85374c1863226eff2', 1462, 880, 990, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x25341068524e657dd9434b6cf3738d27da87d66c', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xf8c01c7bdfbb7d2add39ed08368217d605d31f2f', 14955, 15847, 22953, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xdfdcc1a06b5d833c89197b8c216ac497d67ca5d9', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xbcd663e4856def593d86eca8898006d0eef03016', 6915, 9438, 6670, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0xa3eedbe55d34899d8957470a20c35243a951cec6', 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_resource (owner_address, astralite, samarium, calamarite, contract_astralite, contract_samarium, contract_calamarite) VALUES ('0x6a74ce0ccc415d439f3c908e0817bb69c6d9046e', 0, 0, 0, 0, 0, 0);


--
-- TOC entry 3575 (class 0 OID 18002)
-- Dependencies: 257
-- Data for Name: manta_stats; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x135ebc63378e52d4b62081edd1a8db4c580a3441', 5070, 2, 4974, 2, 3989, 2, 1, 2);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x8d0b928e34d0c2ea626fd84e79d6b221feab5030', 648, 1, 886, 1, 1980, 1, 1, 1);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x014d3239e6a0b9cb825527c8c365472a3e271028', 601, 1, 1001, 1, 2035, 1, 1, 1);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x242bf8c5a3dff71b6dd6821fb9ddfd493a6bcb1d', 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xe51a2e65d8b43b045de3d1db9e64906d14c61b54', 51223, 13, 29574, 13, 43866, 13, 1, 13);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x3c69cf466b8ccede9b7d25a96080eafbd02c446d', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x1d0e5f3459e16dd67bb3a985aca0f1e92d72fe09', 69040, 7, 58406, 7, 72929, 7, 1, 7);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xe13abdb784435f7e12656daa2fee2687b4486152', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x0efdcf9840fe91e3925e386d3633debed4369c27', 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x78cccc65a0bc2bbe502c07d28416649c5c6623b1', 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x5ee6e7174e759092a9e2408a3c73078ae5fb9c87', 113920, 5, 118131, 5, 117416, 4, 1, 8);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xc1e7ca17274c36a3358460f93ce30200916688b6', 1784, 2, 1890, 2, 2983, 2, 0, 2);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x9bc66deb421faf05041ee69f8db194f6a34bdc37', 1729, 1, 0, 0, 0, 0, 1, 1);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x81366eefbb88ca85d58db113b929fbc908a5b5df', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x3e95e93ace1d56792d3ed326b3f20d32f050fd9f', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x5ec37ef774357717d06c53870c5bacac7d63fa07', 0, 0, 0, 0, 0, 0, 1, 2);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xd7b2913be8247d7b54ec38366dc45fbe21fb4587', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x759ec7d623ccf175e4a550d56381dc58a8a2c323', 2452, 2, 2380, 2, 2675, 2, 0, 2);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x7335f905b4dd29d58c5afcb4f8d8016e1eb5ad9b', 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xbae01ad127c9e49179c9aa63109c0fc120782662', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x613f2f6ef6f175a7f60217f3cb1c168ca922bc2d', 7192, 1, 6282, 1, 5972, 1, 0, 1);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xb600df397c596b0baad105c85374c1863226eff2', 147067, 10, 112999, 10, 130562, 10, 1, 10);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xb8df3eebbb49a09495e08e284545f48c29013f98', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xf8340c4d26d3787207133946e5a31f2ff4484df5', 296517, 16, 328392, 16, 387910, 16, 0, 16);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x514d58823c12ec695ef378d4cb3013faa147105c', 5090, 1, 0, 0, 0, 0, 1, 4);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xf282529a89e131791f15ca45d32c6e1267987ced', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x442cac6c7add9dda8f9017074a10e45969b859c9', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xdbfff9ca5955bcd25ce77dbeb27183cc329c8e24', 25396, 5, 29487, 5, 27144, 5, 1, 5);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x5017ac3361cd1a702f28eb20545a2af858b491ab', 146606, 2, 157161, 2, 194155, 2, 0, 2);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x14f7c96aa0229a406efd67688c5187bee694de79', 899, 1, 768, 1, 1057, 1, 1, 1);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x7543ae755256476f32ec2cb49c253c4e5d47b806', 5088, 1, 0, 0, 0, 0, 0, 8);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x124b76631b4add879a9bf5a7759cfa3a1d78ca2c', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xd079429401ca47b190dcaf2853bb8ccde199b563', 54049, 13, 44304, 13, 54836, 13, 1, 13);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x031aeada4ff6096cca3ed161ec6a06125ba3d066', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x67ba609c80f01ac8909d07a5c8f0f9c182c41bd3', 14270, 10, 19881, 10, 11875, 10, 1, 15);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x6a74ce0ccc415d439f3c908e0817bb69c6d9046e', 0, 0, 0, 0, 0, 0, 1, 1);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xab5da83c4b2ef1d1921f426c405adb9e0d8ef056', 16136, 8, 17845, 8, 16714, 8, 1, 8);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xaff85fbaefefb64fa0a535de424117a0a9d35b74', 1622, 1, 1205, 1, 1016, 1, 1, 1);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xf363b614cd6536f2191ac6bf3bbdfc4030ed94da', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xd9c5db99859b01c1212a098a5c79f74c572dfb00', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xcc8356a48083c08c4792869ba6eb089cecb21797', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x485f8eced21e7581ed582f8d9394a4e7584c7d8e', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xe794e62d11a11bf1ee8ff34eacdbd1c20f20b7a6', 1448, 2, 4941, 2, 3114, 2, 1, 7);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x16ecc0d028190ce0b74d52b450c4e00a19145885', 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xaac5e7e4d9d3b535a286e5a784d64d67af7dd4a1', 7307693, 3188, 7126864, 3160, 7835472, 3160, 132, 1708);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xdbedfdc1659f17b76ddfefee426c2478d774c109', 126710, 5, 82587, 5, 91506, 4, 1, 5);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x4b22a3c99bcc08d2ea14a5fb6a4d09777a65e6ff', 317536, 24, 195275, 24, 215450, 24, 1, 24);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x9f8d9c183150f15ffba39b7b17c3e1a78e5e5478', 110433, 12, 111761, 12, 124754, 13, 0, 13);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x4dc809d195167bb0e4e0405d3072d4595b443acb', 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x02b16229cc3d4b0b7d1e6c6006a76e9eee387caf', 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x30303463339b79f36f548ee6c171ac0e00d713ae', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xd6affec06f7688484643b50f7fae00927ceab84a', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xc9634ebc37b543cbee414fcc4426f447370e50b5', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x8c6b1d93b59db869fd232a0e7ca38bcc696914c9', 22196, 2, 27731, 2, 33056, 2, 0, 2);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xa56cc2cc3fab1a0da80268ea83effbac3daaedc0', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xcf220df87427b8d97954af31d266177c0bcb145d', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xf3cc32a6545faffd5b8266ea5f4654b420345f42', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x93b7ee22a179c00e98e80792e89bae613f22c622', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x47bff18e462912ab61a465b2bc229e3857491aa6', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x0bddf4e169c35b77186c6ce1c987408689c4634d', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xccdf7faf3e42b9cbfc529c2ba5fde4b2a6892b80', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xa8fc32ed35cbf232cda8468da77e01183d3cd04c', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xfd599c8e0933abd0b842c436ad9e612ad625feb9', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x992b855f94f907e0ad8483140fd1f6d125c8aa03', 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xa982f2965130fa59305e480ff42ab6a563b406a3', 1317, 1, 696, 1, 2144, 1, 0, 1);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xe1c2fe8ee6d476debfa59e7e0b055cdee246fdef', 3402, 2, 4283, 2, 4003, 2, 1, 2);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x9420282ce93e91a0e756b8a33a48e64e863bca3e', 6792, 3, 2734, 3, 3478, 3, 0, 4);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x8246732bdd058b628b18661e69ab2fc1f29a432b', 3221, 1, 2571, 1, 4203, 1, 1, 1);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x27534ee6a1d10afae2cef0a68f17623d060f01c7', 738, 1, 1247, 1, 990, 1, 1, 1);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x9dc6d51044fe2b9cb708a2e522ca21a62d35513e', 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x6b3a4bd72e25d26160e698d6e826c2ecbadef9c8', 7646, 4, 6956, 3, 13345, 3, 1, 6);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xae763e853ef7cd9b52ddabdd4181fedda322f59f', 0, 0, 0, 0, 0, 0, 1, 3);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xf8c01c7bdfbb7d2add39ed08368217d605d31f2f', 630178, 43, 682624, 43, 770551, 42, 1, 45);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x491ffc953e1ab2751817ff90a5f32694a4841474', 16302, 2, 14477, 2, 16538, 2, 1, 2);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xabaf086c29e5ace29ba1fc79f0220c2f92385984', 4332, 2, 2911, 2, 6658, 2, 1, 2);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xd690b90480010dcd01e13a26835d67d1c71fdae8', 5407, 5, 12832, 5, 6362, 5, 1, 5);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x705317be1e94317672fcd2f39d7f5e607f9e4d97', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xbc90ead9929590f4490b400c766975ac8c150e9a', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x629dff6da36666063a31d59abf4302fcaabb2c11', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x7bacff455a5d921d2c953180083d488bd380eb2a', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x92124ee0e7238992e5e7f34f9fbbcd71931abc6d', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x300f555bf2a6ba5e090d224687d8ff4703cd0f52', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xd3a2978a9ad5ea4e76520594646ef7e8e1fffe1f', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xfa5a1f0e3b506acb0d5183dbff6d0d6f33bcaea5', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xd373dd844d7d10f7c3cfa0d6206de57380d35611', 38172, 6, 34895, 6, 32080, 6, 1, 6);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xf0c56251ce95e39882cc58f3cc14272771ae2f44', 596, 1, 1594, 1, 925, 1, 0, 1);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x064401fa3796467257940bfc230e14abad73f378', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xaffc193174e262e1201961ac3b5286a82d0e622e', 1297, 1, 633, 1, 1098, 1, 1, 1);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xd887474fe347562450a9a892204abb3d13039550', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xadad5545a77b1748e69600b5560f2153abc19de7', 0, 0, 0, 0, 0, 0, 1, 3);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x8cd78a617bffcfba5daf0c01b6af522590952fce', 5227, 2, 4825, 2, 3069, 2, 1, 2);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x6eeca55c7cad1b1c1c3f872e1b5659f520c19a1f', 4685, 2, 3727, 2, 3983, 2, 1, 3);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x0939ece40293c89df6f4639af3c7c35d799b5f00', 87787, 9, 61814, 9, 79126, 9, 0, 9);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xcbacf618fb3dcbe9a9000143be58eb01235efe9f', 6660, 3, 5245, 3, 9168, 3, 1, 3);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x8a9865785dbbd747fd67536112daf3ee161bc287', 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xc78a4443164039a5d8cf91b75a090001e29d66fb', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x3cdafc99da990d56abedbc0af7b4247ad2dc5a74', 600, 1, 600, 1, 600, 1, 0, 1);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x7569a5b6e2e5c6ca2d0faf1a8cb5c80c60895b81', 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x61cca8707ae928298d3b3e8c1de0d7095b7b74b6', 163660, 6, 180461, 6, 186405, 6, 2, 6);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xa209a754da05c44e23d656a2bef3f6614d1cbeab', 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x3b3c5ba49da136c2761ac39a888e50d7c02edf88', 83415, 82, 86670, 82, 87859, 82, 2, 83);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x988d0ed33e9a5e7def0736bc693284bfbb190d17', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xf580fd2b530e647b8ddce0e39e0e3e6cb9ad706a', 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x875576dfac97ef162a4b7b55fded46f2dd312ef0', 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xebd9a48ed1128375eb4383ed4d53478b4fd85a8d', 40620, 6, 34820, 6, 36067, 5, 0, 8);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x17b339dd9579aec49d075d539729552b3488ebd2', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x932bad9228d2bb187548677ce6712f9b001993a9', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x492ec88d26f1e934cc93754f904806794e0aca31', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x27b7739f3aea9bc357526319c9cd82a0acb1887c', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x34fab622936f58a77f18ea21cd4d3386afa68449', 949, 1, 2942, 1, 1783, 1, 1, 1);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x9210cbb688eb68d0c0dec88da9d7ee8a6b8b4dec', 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x4ce80cef4e36936a76ef8260afb9364cb44d6b82', 15417, 7, 19407, 7, 21062, 7, 1, 7);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x75e5ef92fd7b6bcd54869f096e8278cc079f5036', 10105, 3, 8218, 3, 20475, 3, 1, 3);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x87a71aa6355a9dcbb43868f6a4ac54116e0aaa8a', 7122, 5, 10790, 4, 8798, 4, 1, 7);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x43766a37ef46c17f493803f6d190b1f7d0ac2e7a', 41950, 20, 42787, 20, 47540, 20, 1, 20);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x5a6e9f05910e58c4fc2f8a0a766f576cafd49765', 41653, 5, 43374, 5, 40232, 5, 1, 5);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x1770de12a1b5b1283d56cd7a1e5fbe4fe284511e', 18946, 10, 13897, 10, 15496, 10, 0, 10);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x536ee857fcffe9e0b33d5cb17b69264588728a78', 5137, 1, 5867, 1, 5628, 1, 1, 1);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xadbabcf1adff46f2a8f10783e3b70a23c0f00e51', 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x8386a270f99a9cc491934f4355047d78005715d0', 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xc2100a5022cd8fd7beedde6195a8894f2f0265da', 8810, 7, 9105, 7, 7975, 7, 0, 7);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xa65660a7c3c4408fe1ef6a33dfc3b1d312263b1b', 6298, 1, 1257, 1, 2244, 1, 1, 1);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x1f137f133df19d65669165a0963fe72485c7fd0a', 4107, 3, 3979, 3, 2383, 3, 0, 3);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x85799ff1c86f89fe9fb07773d1d240763b6039ce', 6403, 2, 6058, 2, 7580, 2, 1, 2);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x3ceec57a1f2be530c970f5dbd675d23d0ff3adfa', 2556, 4, 4625, 3, 8500, 3, 1, 4);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x3edb1be154d8c8fc4818fa7695da7620ecd5ef91', 25217, 16, 21464, 16, 37818, 16, 1, 16);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x7cebae9a7fadf20087b6ac67cdb5d2c4e89fa667', 42754, 4, 40613, 4, 39347, 4, 1, 4);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x9fcf1483f750dd5a8555797b8190af62e5fe4d44', 240221, 9, 140010, 9, 158178, 8, 1, 9);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x12e6531c7e1f990d264cf0443ff7db196b9d18cc', 10867, 4, 12753, 4, 10466, 4, 1, 4);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x0fbebbcff5d4b0d8f6e440507350c7bb72bcd02e', 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xde848f5949206a9e66e1800e2c5a69d2601fbc22', 1789, 2, 2751, 2, 3783, 2, 0, 2);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x25341068524e657dd9434b6cf3738d27da87d66c', 677621, 305, 683600, 303, 703819, 302, 7, 311);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x319b916a699865618121b99e66e34b1cc597ec32', 730509, 459, 707270, 449, 749037, 447, 10, 470);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x26ce8f32260f05e91faaf4f26569703cf5c52373', 691, 2, 669, 2, 612, 2, 1, 2);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x3ec221a25b2dcf5634e4ff0af3b07ea17ae8d002', 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xbf87fafcc5d86010744ade5e1669d785958fd871', 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x2bf136e8ccb32e9a213a4ae6778d703cf55b5889', 1498, 1, 760, 1, 1837, 1, 1, 1);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x0f617402b5954a8118ce951fbbddaf1a4ac16310', 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x592ba89811880eb4d9dfb759979b35da8b986295', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x1f6239b44952fa8ccbe3de87fae8198867277f65', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xe0e11ee72a99d9b74708f70a97bc4af5f331defc', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x542325af03aff2b3ac9f0882b4442590717362c0', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x6c96d29e8763ca0996f983c0469630a60b108c9f', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x1af51642db6ec70e43e9d0cbc36872dd2f647f32', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x2d17e331a7eb8073c647ebb70bf44a429f9d9b91', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x56c0723288e40e7edc516f358c9a9f01075c83bc', 8575, 2, 9593, 2, 13639, 2, 1, 11);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x414f5774846944908142e7c1fc6c91b5c14e0eea', 6138, 1, 6591, 1, 4249, 1, 1, 1);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x6013ad1e49066dc25bb8a82e2eb467add62265f9', 724, 1, 863, 1, 1339, 1, 1, 1);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x7d233827ec2949f79894ff9b37e35ff51216d080', 645, 1, 3164, 1, 2531, 1, 1, 1);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xfd80f0c6e080599dafd2a3d0160f60f9c8868f9d', 0, 0, 0, 0, 0, 0, 1, 1);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xcf61d8fc50f84767ca932945d167fd613f5da53a', 15679, 4, 16993, 3, 18001, 3, 1, 4);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xdfdcc1a06b5d833c89197b8c216ac497d67ca5d9', 9440, 1, 9466, 1, 15335, 1, 1, 2);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xe72aa6533d38009ebc810ded93ccd69f32e49db2', 10193, 4, 11754, 4, 17967, 4, 1, 4);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x3cc47738fe7fc2587914d63420caf37cce129a02', 20741, 2, 16550, 2, 19280, 2, 1, 2);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x51a4545bf235564f263fd165728c06c0c0296413', 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x09a5e9ffe158e81e677ff5b7ac7a966780ff2427', 24986, 6, 31874, 6, 36169, 6, 1, 6);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x1bc65b00eabd7af0eb41f8d6d9934783391afea3', 2420, 4, 0, 0, 0, 0, 1, 19);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x7c719c3c98f416bb5fab3c00c09e518e5eb5c1b7', 1787, 1, 1368, 1, 1452, 1, 1, 2);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x8bde4d211b511fb5b65977010315e6322a67044f', 2621, 2, 2724, 2, 1809, 2, 1, 2);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xc339adc4352e66ac2d6bc14097d24b83dee5c01c', 564, 1, 1001, 1, 3135, 1, 1, 1);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x6f61d896a9b9e1087065e1630be44f394786f3d1', 1241, 1, 1993, 1, 1073, 1, 0, 1);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xc9792727ef67867670d85ba7b8b694368f10ab5c', 1273, 1, 1574, 1, 748, 1, 0, 1);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x34cd39508ecaa638538e5a1b1be00ea3b7b5f2d6', 11531, 2, 12804, 2, 16155, 2, 1, 2);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x740f995effa4e423b42f491a3e772ae82227224d', 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x146e782479c3823e3addc2d0cc45ec57b8612276', 52185, 6, 54454, 6, 58949, 6, 1, 10);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x9d67abaaa744b564fc605216dba6a8d684599537', 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x6b2f05b70a48e7b81d646d79e0b720c7577cd645', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x93bf79e6a9944e1aa6c843680066dbcaab226f17', 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x8c9ce89b2db559276ae9d7cbc473ca90e65b36b7', 0, 0, 0, 0, 0, 0, 2, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xba1688252983cddf5c5484975f9e8da35ceb91bb', 4233, 4, 5059, 4, 5187, 4, 0, 4);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xb79bcb0cd6672662bf93aa2bee16726c654ca4b1', 808, 1, 862, 1, 807, 1, 1, 1);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x0581da444a46693496968d6611b15065fcf42140', 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xbeaaf573c71f50086f4e9491d2338abfd023446d', 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x34a0829701d144253566c789c4c4635132355ccd', 51795, 9, 41706, 9, 52911, 9, 1, 9);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x62c85407bfa12cf5350dc6ac5cf1fdf3f45cc15f', 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x8812f12bf1b651b4c8231e033efc93b2cb8891fd', 1263, 1, 0, 0, 0, 0, 1, 1);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xca19d045317224c3bb84af1a403f70bd3589ef56', 335309, 7, 332078, 7, 355086, 7, 1, 7);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x5fa6c2cdc923631b99f42e7ab0ac44800fba1419', 2587, 3, 2507, 3, 1753, 3, 1, 3);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x9c854bf81c81cb5038ff3dd702e9e552f20fe1b5', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xcda3f9f535587a85aed04397d933864256dfe1dc', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xc9ac4dcb8927891274442484701c104845a23367', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x506b61f9dd0b2b3e93ef4646b35e64eaf5388d54', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xc37f000de73a3032eeaa4fa4cbf4db8ec527552f', 727581, 12, 761917, 12, 851778, 12, 1, 12);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x914bd52a86f6f2f3fc72843e69ee2dd8a54ed50c', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x4a74228bcac7cc2e6fa52eeb644005edbcb7ed9a', 2843, 2, 3951, 2, 6110, 2, 0, 2);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x10bdaea978fbad26b045278a04a42fd13949caa3', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x8626f6940e2eb28930efb4cef49b2d1f2c9c1199', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x0d960b67269b0837c0ebf6a09cce69377590f020', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x18688146713a8c38310547b473dd87c28cd941c6', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x292e84772e3ce9a5db4ba914b83b89b74886f1bd', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xb93701293b1bbeaa7d4b0a73449d30a1fcf459f0', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x3013999a39d108e08193058054eac9db213a85be', 772900, 139, 821715, 138, 883960, 138, 0, 149);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x3beb5e96c21fee32c43bed747dc1fc4e57c5594e', 21999, 4, 20602, 4, 27064, 4, 0, 5);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xed66e493e956849ff67b3e546f8daf3d68ec380e', 11042, 6, 13190, 6, 16587, 6, 1, 6);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xb9072e7f4b25b523cd2144b05e8734b68e18fcb9', 61152, 58, 54458, 57, 55049, 57, 1, 84);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xf0db619363881ceb6ba06b9ae3dd4886652aa896', 20678, 5, 27940, 5, 28533, 5, 1, 5);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x80595a71b57636856b61e51a939aa511a5d4008d', 0, 0, 0, 0, 0, 0, 1, 2);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xa3eedbe55d34899d8957470a20c35243a951cec6', 3352, 1, 6857, 1, 3427, 1, 1, 1);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xedcd33a9c1a6cff9a887e9054bb5933002ca13cc', 24301, 3, 24531, 3, 26975, 3, 0, 6);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x96b59ac7d6d40bb27c90202a4793ad571cab15b3', 28028, 17, 27694, 17, 24690, 17, 0, 17);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x4350bfccfcd52bb5512244fcc3ce2bc878e9aa82', 18807, 2, 18103, 2, 14765, 2, 1, 2);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0xbcd663e4856def593d86eca8898006d0eef03016', 13850, 4, 11096, 3, 17131, 3, 1, 4);
INSERT INTO public.manta_stats (address, astralite_amount, astralite_tx, samarium_amount, samarium_tx, calamarite_amount, calamarite_tx, faucet_uses, gas_tx) VALUES ('0x0145582cb27bd79163462029a81bbb0b56a3991e', 477026, 49, 483160, 49, 541589, 48, 1, 54);


--
-- TOC entry 3566 (class 0 OID 17475)
-- Dependencies: 248
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.migrations (id, "timestamp", name) VALUES (1, 1688957391936, 'CreateTables1688957391936');
INSERT INTO public.migrations (id, "timestamp", name) VALUES (2, 1689568409304, 'Ship1689568409304');
INSERT INTO public.migrations (id, "timestamp", name) VALUES (3, 1690157470732, 'RefreshingTilesAndRandomness1690157470732');
INSERT INTO public.migrations (id, "timestamp", name) VALUES (4, 1690203741707, 'ShipModel1690203741707');
INSERT INTO public.migrations (id, "timestamp", name) VALUES (5, 1690216149469, 'AddSeedTable1690216149469');
INSERT INTO public.migrations (id, "timestamp", name) VALUES (6, 1690550830431, 'SeedTimestamp1690550830431');
INSERT INTO public.migrations (id, "timestamp", name) VALUES (7, 1690817119131, 'FaucetColumn1690817119131');
INSERT INTO public.migrations (id, "timestamp", name) VALUES (8, 1691424468805, 'ChangeFaucet1691424468805');
INSERT INTO public.migrations (id, "timestamp", name) VALUES (9, 1691431845302, 'DefaultFaucet1691431845302');
INSERT INTO public.migrations (id, "timestamp", name) VALUES (10, 1691506541558, 'StatsTable1691506541558');
INSERT INTO public.migrations (id, "timestamp", name) VALUES (11, 1691686244257, 'PopulateStatsTable1691686244257');
INSERT INTO public.migrations (id, "timestamp", name) VALUES (12, 1691780966622, 'ContractAllowanceTracker1691780966622');
INSERT INTO public.migrations (id, "timestamp", name) VALUES (13, 1692050237598, 'ChangeShipToVessel1692050237598');
INSERT INTO public.migrations (id, "timestamp", name) VALUES (14, 1692499477362, 'MultichainStats1692499477362');
INSERT INTO public.migrations (id, "timestamp", name) VALUES (16, 1692503836412, 'PopulateMultichainStats1692503836412');
INSERT INTO public.migrations (id, "timestamp", name) VALUES (17, 1692565078318, 'MultichainResources1692565078318');
INSERT INTO public.migrations (id, "timestamp", name) VALUES (18, 1692566701784, 'PopulateMultichainResources1692566701784');
INSERT INTO public.migrations (id, "timestamp", name) VALUES (20, 1692899679401, 'AddUsername1692899679401');
INSERT INTO public.migrations (id, "timestamp", name) VALUES (21, 1693342703383, 'ReduceVesselRanges1693342703383');
INSERT INTO public.migrations (id, "timestamp", name) VALUES (22, 1693966619377, 'SpeedAndRadar1693966619377');
INSERT INTO public.migrations (id, "timestamp", name) VALUES (23, 1694043876329, 'UpdateTable1694043876329');
INSERT INTO public.migrations (id, "timestamp", name) VALUES (26, 1694295187030, 'LoginTracker1694295187030');
INSERT INTO public.migrations (id, "timestamp", name) VALUES (27, 1695669115340, 'PendingMintTracker1695669115340');
INSERT INTO public.migrations (id, "timestamp", name) VALUES (28, 1695681579373, 'ReferralsTracker1695681579373');


--
-- TOC entry 3574 (class 0 OID 17530)
-- Dependencies: 256
-- Data for Name: random_seed; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.random_seed (id, seed, generated_at) VALUES (1, 99976436, 1696377600);


--
-- TOC entry 3578 (class 0 OID 19629)
-- Dependencies: 260
-- Data for Name: update; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.update (version, title, changes, date) VALUES ('0.14α', 'For Takeout Please', 'Enabled mobile compatibility/responsiveness. Full rebrand from space to ocean theme. Fixed wallet connection issue', '14/08/2023');
INSERT INTO public.update (version, title, changes, date) VALUES ('0.13α', 'Endpoints Galore!', 'Contract balances are now stored in database. Faucet checks occur after transacting. Minting now requires 500 of each resource. More endpoints to track transactions more accurately', '11/08/2023');
INSERT INTO public.update (version, title, changes, date) VALUES ('0.12α', 'What About Now?', 'Faucet checks eligibility every mintue. Contract allowances are fetched periodically from the blockchain', '07/08/2023');
INSERT INTO public.update (version, title, changes, date) VALUES ('0.11α', 'Power To The Players', 'Changed resource contracts to allow players to mint themselves. Resource UI now displays balances in database. Added Manta faucet to settings menu. Bug fixes', '05/08/2023');
INSERT INTO public.update (version, title, changes, date) VALUES ('0.1β', 'Ready For Action!', 'Added Workbench button. Disabled network buttons with no claimable balances in network select. Added Moonsama Customizer avatars to players who linked their username in the leaderboard. Added daily user tracker and 2 new leaderboards. Added changelog to login page. Added tutorial to login page and settings menu. Improved error handling overall to prevent undesired scenarios', '07/09/2023');
INSERT INTO public.update (version, title, changes, date) VALUES ('0.21α', 'Upgrades For Days', 'Added real crafting on Manta/Base networks. Added ingame upgrade functionality. Added maintenance mode banner. Removed restriction from moving to exhausted tiles', '06/09/2023');
INSERT INTO public.update (version, title, changes, date) VALUES ('0.20α', 'It''s In The Small Details', 'Added mainnet/testnet toggle on network select. Added username/address toggle for leaderboard. Added demo level 0 upgrades. Reworked network buttons on leaderboard into a list. Fixed wallet bug that consumed memory', '30/08/2023');
INSERT INTO public.update (version, title, changes, date) VALUES ('0.19α', 'What Comes After Mine?', 'Added Workbench page and UI for crafting. Added ability to craft test upgrades on Exosama network', '28/08/2023');
INSERT INTO public.update (version, title, changes, date) VALUES ('0.18α', 'Multichain Flexing', 'Added multichain leaderboards and merged category. Added ability to display username instead of address on the leaderboard. Fixed issues with multichain assets. Added sound to signify mining completion and toggle', '24/08/2023');
INSERT INTO public.update (version, title, changes, date) VALUES ('0.17α', 'One App To Rule Them All', 'Added multichain support and Base-Mainnet. Added ability to mint on multiple chains at once. Added Base bridge to settings menu. Added tooltip to disabled claim button. Added error explanations for missing gas', '22/08/2023');
INSERT INTO public.update (version, title, changes, date) VALUES ('0.16α', 'Everyone''s Good At Something', 'Improved leaderboard UI. Added additional leaderboards. Fixed bugs related to leaderboard display', '21/08/2023');
INSERT INTO public.update (version, title, changes, date) VALUES ('0.15α', 'For All The Glory!', 'Added leaderboard page and button. Improved underwater aesthetic. Bug fixes', '16/08/2023');
INSERT INTO public.update (version, title, changes, date) VALUES ('0.10α', 'Cleft In Twain', 'Split resource minting into 2 endpoints. Added modal for minting', '01/08/2023');
INSERT INTO public.update (version, title, changes, date) VALUES ('0.9α', 'Settings Things Up', 'Added settings menu. Added logout option. Added faucet button. Added prompts to save tokens to wallet', '31/07/2023');
INSERT INTO public.update (version, title, changes, date) VALUES ('0.8α', 'RNG Heaven', 'Updated resources and vessel smart contracts. Added tile types for random chances of resources when mining. Added random seed generation and tile reset every 24h', '28/07/2023');
INSERT INTO public.update (version, title, changes, date) VALUES ('0.7α', 'Did Someone Say Mint?', 'Added minting tokens functionality. Convert ingame balances into blockchain assets', '23/07/2023');
INSERT INTO public.update (version, title, changes, date) VALUES ('0.6α', 'Time To Mine', 'Made Manta-Testnet the default network. Added sidebar with vessel list. Added mining menu and functionality', '18/07/2023');
INSERT INTO public.update (version, title, changes, date) VALUES ('0.4α', 'Building Bridges', 'Added Moonsama Multiverse Bridge login. Added Vessel viewing route', '12/07/2023');
INSERT INTO public.update (version, title, changes, date) VALUES ('0.5α', 'The Strongest Of Links', 'Fully connected client and server. Refactored vessel fetching. Added authentication for security', '16/07/2023');
INSERT INTO public.update (version, title, changes, date) VALUES ('0.3α', 'Vessels Inbound', 'Added vessels into Zero Sum. Vessels can deploy, move, and mine', '11/07/2023');
INSERT INTO public.update (version, title, changes, date) VALUES ('0.2α', 'Always Listening', 'Added initial version of indexer for vessel events', '09/07/2023');
INSERT INTO public.update (version, title, changes, date) VALUES ('0.1α', 'Codename Rebel', 'Original concept for Zero Sum', '06/07/2023');


--
-- TOC entry 3567 (class 0 OID 17484)
-- Dependencies: 249
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('d65d2c966e5cd02a029c54f8dae4a396', 'f3d425ff7013a60a9fe4ebdaae716090', '0xf0db619363881ceb6ba06b9ae3dd4886652aa896', 1695319205563, 'elrupero', false, 1696196608731, 12, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('5fbb8a85c480d2e24d870c7a11a9e371', 'e9b171ad1015e586967288f1410559c4', '0x492ec88d26f1e934cc93754f904806794e0aca31', 0, '0x_CryptoX', false, 1696330786609, 9, 1, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('f8859f806e1715ac722159dba877269b', '09de23f4daace95f633f899dc4613008', NULL, 0, NULL, false, 1696073318520, 1, 0, NULL, NULL, NULL);
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('606e7df917371ec04685e67bdefab2fa', '5d00384c181f387ef27fe9b130eafd40', '0xf580fd2b530e647b8ddce0e39e0e3e6cb9ad706a', 1695154118960, 'Crypto_Cleaver', false, 1695150127069, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('473aa74c7ad378f04b26784191d3885f', '2b8c257b53ed18124a53a2cf6655ac69', '0x7c719c3c98f416bb5fab3c00c09e518e5eb5c1b7', 1695981006562, 'Dogtag', false, 1695977269096, 1, 0, NULL, NULL, NULL);
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('de4878943281d5df680fc5da6f4d64e9', 'd7463e76ab18c538f9ab947845d6cd63', '0x9bca95c511bb1e42641c6abc1778d68506989842', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('e3d48b124e9091a3cd3665d0f58744d0', '4b6c3a70149decc4df6a68607e5e176a', NULL, 0, NULL, false, 1695319965285, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('b294427d58dfe5cf2c7445cdcd6427c4', 'a712fa2aaf897f7c6e06a171d83f0451', '0xdfdcc1a06b5d833c89197b8c216ac497d67ca5d9', 1695828338762, 'BuyMonkeysNFTS on Raresama.com', true, 1695915311713, 4, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('56ad298bf4fa942ba095b85337ea2ca2', '4f2dc4dd3e2bc142b7f2431ed26fb22a', '0xa3eedbe55d34899d8957470a20c35243a951cec6', 1696316944583, 'SweetsOfSAMA', true, 1696351826956, 1, 1, NULL, NULL, NULL);
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('dee796b688181c62d879d590ff62aee9', '6529c5c2fdd4e1d2160b89a1e955e80d', '0x75e5ef92fd7b6bcd54869f096e8278cc079f5036', 1695144951916, 'Minimax', true, 1696375744255, 4, 1, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('80ae01c448eba1678173438a0ed9c89f', '7eeaaf63b5db7c33b37c565b7ff72869', '0x1770de12a1b5b1283d56cd7a1e5fbe4fe284511e', 0, 'King25+1', true, 1696274803311, 4, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('a23793f1f0cab443132cd037ca6c7e44', 'ac09b7cc5ea728ac09308ff4a0c4cd72', '0x3ec221a25b2dcf5634e4ff0af3b07ea17ae8d002', 1695149572244, 'Blackstar', false, 1695145845814, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('cb32e88a53e2a1ec547eae6e54f929b3', 'c60551e8df68a431e74c3defd59bd25c', '0x5ee6e7174e759092a9e2408a3c73078ae5fb9c87', 1695673887665, 'Niburek', false, 1696087008745, 9, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('aa8194a66f8bd407d5fda9e455b52005', 'e874b5952080d784cbb73143fa32a202', '0x3b3c5ba49da136c2761ac39a888e50d7c02edf88', 1695990130336, 'LotusEater', false, 1696256742266, 10, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('1f1447f253b22d20c2333950f97d9b00', '804789633d26ce01c6764a9a9e367923', NULL, 0, 'Moonsama Joe 456', false, 1695421159234, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('ab2ee22b9c901c2d1f293b728d1b5724', '9a24cb8a98bb5610122fe0881d3307ce', '0x7d233827ec2949f79894ff9b37e35ff51216d080', 1696211327980, 'Goyda', false, 1696207510218, 1, 0, NULL, NULL, NULL);
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('763ab98f9991230d4627f63a5dcf0e68', 'd9d12508bee45b2cf4883002354833a8', '0xe51a2e65d8b43b045de3d1db9e64906d14c61b54', 1695142994678, 'CaptTK13', true, 1696272621927, 15, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('fc6c2ef537f9370b8aa982e59d85aa61', '6a5d641902e38410d330aefe5228b104', '0xc2100a5022cd8fd7beedde6195a8894f2f0265da', 0, 'Voxelle', true, 1695909795219, 8, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('eaecaeef5709d58e4224a8a1af1527cf', 'b33f15d1a41fa1afc1adf1c80ea068f5', '0xadbabcf1adff46f2a8f10783e3b70a23c0f00e51', 1695829011613, 'Cheems', true, 1695825394717, 2, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('d838ca2bb23a3035cceae7b1c609678c', '45ffe24bdd149648683221f1261ba6c2', '0x34fab622936f58a77f18ea21cd4d3386afa68449', 1695568558992, NULL, true, 1696172335421, 3, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('53bb81b08b4e6c3fd7626fb53b64e359', 'bc89941efe31d6c66718c33641e4afa0', '0x30303463339b79f36f548ee6c171ac0e00d713ae', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('0c36db38a5c9df2d4a924186aab2416c', '8b93921a0daac159459b58c457d1e37f', '0x124b76631b4add879a9bf5a7759cfa3a1d78ca2c', 0, 'MikiKing26', true, 1695918763242, 2, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('5ab9526638b560a07374f02fca1fa9c2', '58c196d895ab8184b19e04215dfa315e', '0xc9ac4dcb8927891274442484701c104845a23367', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('b391b2bb2c3cee6a35ded1f5e9ff8e58', '1dafc1d1ee7a4b7ecba870060b0f2d2e', '0xaffc193174e262e1201961ac3b5286a82d0e622e', 1695174612290, 'AllBlue', false, 1695170763353, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('b042bc8940fb7f3aea4f7dcf2b8923a9', 'c04f1001061c82f3f90512c0ee9fa0ce', NULL, 0, NULL, false, 1695145520785, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('e0e10492927e63442d04359dc0902e9b', 'b8fe402d94b001beff17f83f22fd3233', '0xe13abdb784435f7e12656daa2fee2687b4486152', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('c52e28f48f207a932c15a7dda2d7dafe', 'eaa130aa03d73b05c5b796e967cdc890', '0x6b2f05b70a48e7b81d646d79e0b720c7577cd645', 0, NULL, false, 1695152724009, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('a5d399a3e03dbf9943be518ad9b15841', '2df8367889641ab9cc4adcc7832cfc39', '0xd7b2913be8247d7b54ec38366dc45fbe21fb4587', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('3b94de31a5fa1836ac42522611d58cb2', '8a52c0e278f96da652e868a825af57a8', '0xf3cc32a6545faffd5b8266ea5f4654b420345f42', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('b6d1013dba74f13b94ed0022fe40c48c', '5786325cdaec5c67a7eb00b7330075ea', '0x16ecc0d028190ce0b74d52b450c4e00a19145885', 1695319459817, 'Eroxxama', false, 1695399364402, 2, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('fa403388f2ea78103823b88e5a7d409c', '7c3bc3ade87300f90c262ff774e359b9', '0x27b7739f3aea9bc357526319c9cd82a0acb1887c', 0, 'Robster', true, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('62be0003cbee8d09b8a447e5e1ca0aff', '38fbf606b9c6bac3c7dab02d38698ede', '0xcda3f9f535587a85aed04397d933864256dfe1dc', 0, 'Jeroobie', false, 1695237939429, 2, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('2c6011a756aa18e95b1412f99870189a', '91a00deeaadd16d7fdfc33ed7f6620fe', '0x914bd52a86f6f2f3fc72843e69ee2dd8a54ed50c', 0, 'WolfK', true, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('bdddec44ad68f649890fabcc63cf257e', '23a7251a7ab70d8f050dc6af3fd247d3', '0x09a5e9ffe158e81e677ff5b7ac7a966780ff2427', 1695162745549, 'FCKFTMNY', true, 1695588318703, 5, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('a48a0b7f3cae9aaf4a9ebcc482a2e82b', 'cfcd44920ccddfbef532ca6f155562ad', '0xbcd663e4856def593d86eca8898006d0eef03016', 1696009689585, 'Turkey Burglar', true, 1696167750527, 3, 0, NULL, NULL, NULL);
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('806fc00b1d996b20e11513329f09272f', '50d2e6323933a5991c8d7cc257688dc6', '0xadad5545a77b1748e69600b5560f2153abc19de7', 1695149998256, NULL, true, 1695316765318, 3, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('7674874096358f49e14d45be089c1b91', '93cfa1df0091ce3b5f3c0eb4f877b812', '0x1f6239b44952fa8ccbe3de87fae8198867277f65', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('874edff97b623a81c882cf8d601b64fa', '4262fef88bc8f40770e09ca8568a0f70', '0x414f5774846944908142e7c1fc6c91b5c14e0eea', 1695234609418, 'Cotton', false, 1695383370695, 2, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('0b4ce1f55228ca478a5c9befb15924ea', '35021e0459d940458123462ac9fbb002', '0x442cac6c7add9dda8f9017074a10e45969b859c9', 0, NULL, false, 1695546525431, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('f532fdfec7d6fb12a91cb71c7cfbd161', '37f7fa6ac8be429a2a6d35fdba30a1da', '0x6a74ce0ccc415d439f3c908e0817bb69c6d9046e', 1696354417743, 'GuiLuXe', false, 1696350690323, 1, 1, NULL, NULL, NULL);
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('631f82c1f4f702cf6d1f248f059d3696', 'e8f90427768a746231a77ed804d68958', '0x9f8d9c183150f15ffba39b7b17c3e1a78e5e5478', 0, 'Vaders Zamboni', false, 1696375663028, 10, 1, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('8c2469c5fd60b8df384a6fb3f3b2d317', '46b664db77137ba3ddb2be5c92d868df', '0xbdd05454794736c83b03ee2958999924782f684f', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('f30401c4ce03cff1d215c2e7004ccd4d', 'a3cb5bff819ef24926bf230cc26b5e3e', '0xc1e7ca17274c36a3358460f93ce30200916688b6', 0, 'Enricripto', false, 1695171266248, 2, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('f78ce198a44ddfe2d8e36e89374e8374', '058b179d5a107a519286d481a2650b04', '0xf282529a89e131791f15ca45d32c6e1267987ced', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('48fa1720a6b0e5f493b6720a9d585bf6', '1c2fbff6d79321cd77f0e8f26356f4a7', '0x7569a5b6e2e5c6ca2d0faf1a8cb5c80c60895b81', 1695856873245, 'lRalin', false, 1695853090677, 2, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('ad849e8da2dc9941ab49cee97f615856', '893885e7d481dddfc4c04b9114a1cdc0', '0x629dff6da36666063a31d59abf4302fcaabb2c11', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('460cda98d9b565e0a5a41a9daff2ce0e', '1abeaa91ce75391198b8609c8e0a0a3e', '0xabaf086c29e5ace29ba1fc79f0220c2f92385984', 1695222542914, 'Bubbl3_eth', false, 1695282366196, 2, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('890b882ae82bf24152c2ea93d4b8ba8b', '216bef781f3dd62993ef1c587c0fec46', '0x8c9ce89b2db559276ae9d7cbc473ca90e65b36b7', 1695830190552, 'G', false, 1695826525516, 2, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('d77410749646f0349eb9ee41a63f44ad', '2ac1aa2fecaaf29d04ce97b9af41bbea', '0x300f555bf2a6ba5e090d224687d8ff4703cd0f52', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('9a3c3770cc842436794ecf95e3244081', 'f9e34be4b766a93009b300340e3939a5', '0x47bff18e462912ab61a465b2bc229e3857491aa6', 0, NULL, true, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('f886ea16d52eb8eb4341319b18bc505d', '53f54294dd33131670af876eec173585', NULL, 0, 'fernandocripto', false, 1695162368237, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('235a0a48f5271663a320f43bd5a10577', '4191f4614fac3dd8ba4bda489e7c2302', '0x8626f6940e2eb28930efb4cef49b2d1f2c9c1199', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('23b0171b044589a84ab3bb3733a88567', '490d411e5a9ea2ddcc8c80a3d7811ebe', '0xedcd33a9c1a6cff9a887e9054bb5933002ca13cc', 0, 'maugopa6', true, 1696377311976, 10, 1, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('6d70f3c31e5c367af69b185776cfd686', '1d3747390d23b7152cddff2275d1c4e7', '0xa56cc2cc3fab1a0da80268ea83effbac3daaedc0', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('ea68d9a974bf7ae8f8b3ce337197c489', '9dfbbea84b8cf992860d8e765a3dea31', '0xc339adc4352e66ac2d6bc14097d24b83dee5c01c', 1695575620500, 'Penate', false, 1695709609451, 4, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('615f149bee131b43d6f74199a88b4a2b', 'ef3ad39632865376a6bfcb35f63a967e', '0xe0e11ee72a99d9b74708f70a97bc4af5f331defc', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('d9d8f411dbfed75c2103da4fb144c814', '9ea8495b27d05ce5132556f74ff70a6d', '0x3ceec57a1f2be530c970f5dbd675d23d0ff3adfa', 1695934322056, 'CryptoBeliever', false, 1695940887984, 2, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('3cbc037a8a0e00eb0151cd66cb4c1aa7', 'eaac1738cf9441e13aac3dc1753a8f61', '0xd3a2978a9ad5ea4e76520594646ef7e8e1fffe1f', 0, 'chillbro', false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('611bc88d9a96bc421372e49e0e988a3a', 'b2cde7f6bf3a23cbf33dd65a245f563a', '0x8bde4d211b511fb5b65977010315e6322a67044f', 1695189773999, 'erikuzza43', false, 1695354065820, 2, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('239d71512704b7b6ed5b20d56875b1e3', 'c04a4f9d3b9ea58a36dfc5a0bea17b46', '0x4b22a3c99bcc08d2ea14a5fb6a4d09777a65e6ff', 1695484736117, NULL, true, 1696271863236, 11, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('af950c2cb950254919084dba85cecc04', 'a22455f6bc4edacfb5c22f72dd0800d8', '0x740f995effa4e423b42f491a3e772ae82227224d', 1695829433536, 'Rindun', false, 1695825812886, 2, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('4a465633bc66e7c9d72c6c5743810c9c', 'b40e544ad5b661b366c639587d03456d', '0x0145582cb27bd79163462029a81bbb0b56a3991e', 1696187973727, '420Kusama', true, 1696346160203, 18, 18, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('2ceea846fc960cf30395566f50af851f', '00dc7b0e568e91db8d1d33a34e9ff340', '0xb600df397c596b0baad105c85374c1863226eff2', 1696025983869, 'MIES', true, 1696363606888, 5, 5, NULL, NULL, NULL);
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('d04311c1d924b0f76a7b04e3b0497d0f', '32dfc8f5eaf736d5bcb5a27bd9636720', NULL, 0, 'TheCommander', false, 1695403214916, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('e4e862cb3fd72f4ea2fda8883aa2b4f7', 'e0589dff8e5a3117ab9700f872569a45', NULL, 0, 'Ace', false, 1695139183468, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('297461c4f5b595279aa16ba095d09ba9', '737aafe798bed6bcc8b986d2cb98e53c', '0xbc90ead9929590f4490b400c766975ac8c150e9a', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('a079ec58fa511e50b78bdb6022bb4994', '867cde4985c1aa97361e782b73f565ee', '0x12e6531c7e1f990d264cf0443ff7db196b9d18cc', 1695149550568, 'MOONMORAMOVR', true, 1695965839766, 6, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('546e98a8f78f2953274bb71560910ddb', '7de33f05a203fab991ce205c7a6fd390', NULL, 0, 'zTheDarkAlex', false, 1695373589579, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('ef400a0d4f81bc66ca1039c86eca124b', 'dd01d5f4bb1fff22dc81a7170dc8a43d', '0xcbacf618fb3dcbe9a9000143be58eb01235efe9f', 1695281918385, 'klepic', false, 1695923569626, 3, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('76958988932cd1113ad9a3c95e3055a9', '9dc1a6dbaccc990688173c3e0ef23c06', '0x51a4545bf235564f263fd165728c06c0c0296413', 1695284585494, 'Lothan', false, 1695280579328, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('17cb94ee6b5c1e1b9cefb44c96e9559f', '2137baed8dea0883733a2add313d7d12', '0x5a6e9f05910e58c4fc2f8a0a766f576cafd49765', 1696031826692, 'Slooties', false, 1696338717621, 3, 1, NULL, NULL, NULL);
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('5f232716f885ad86af5671d1d7b7bca2', '09abec676d9b7111a594530ba4a5c9dc', '0x8c6b1d93b59db869fd232a0e7ca38bcc696914c9', 0, 'JohnnyBlaze', false, 1695465793286, 3, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('6bf391fa096679eda0da27b1acf595ef', '7d7aabec6aadf09386963da0f824d064', '0x10bdaea978fbad26b045278a04a42fd13949caa3', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('15543706f6728e801638c6f7e5c602ec', 'ceda11a324f645354b94720632ff4ca0', '0xd6affec06f7688484643b50f7fae00927ceab84a', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('aa9ae896196a71f2af8ccfbe022086a9', 'a31bb51806d09291dc68d674ca8bc1ba', '0x7543ae755256476f32ec2cb49c253c4e5d47b806', 0, 'JR_Borg', true, 1695218218095, 2, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('c3c70c1f65826ef1146073d2e1f87e91', '640943acd71da346a7f60ddbfe3ee546', NULL, 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('669e5d1943e8a13f98f3c87d34d1de75', 'd0fcd5343a30c9ab3d19ef11bd0ade57', '0x92124ee0e7238992e5e7f34f9fbbcd71931abc6d', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('104916f4c6d4975dd2e36d08857223fd', 'bb2a770316cdfb72c4b76e77a61bbf2e', '0xfd599c8e0933abd0b842c436ad9e612ad625feb9', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('afb2bb2c0080fd3cebb76c0f0d10e4d4', '924506d61aedb0f4b2d042be959eb804', NULL, 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('d133468cc04721d5657f5b068e3d4510', 'c607b49bcbb086976e33f34f16455256', '0xb9072e7f4b25b523cd2144b05e8734b68e18fcb9', 1695457595799, 'The_Boycie', true, 1695989384497, 5, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('8d9c6ad11751b146895bc5b2631d7253', '4e12b1c1b715de9d740a64be405fa1ab', NULL, 0, NULL, false, 1695833287640, 2, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('b58e4a050be72997913ec1ac91a1792c', '3286fc9e9ce604718e8412a449ab12d4', '0xbae01ad127c9e49179c9aa63109c0fc120782662', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('3d2fe582ff2af42c3338dd9fa1c98852', '78c2e93662bd29513bd3b44b45648647', '0xf363b614cd6536f2191ac6bf3bbdfc4030ed94da', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('12bc58bfd31bc3fc4fda1057b962fa6c', '15ebe347346edb75ea0fc9525c9ca313', '0x93b7ee22a179c00e98e80792e89bae613f22c622', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('cc3fc3069637844b0c9efca3287ea9a8', '9ef16390e837ebf8d03098b1b620aacd', '0xc9792727ef67867670d85ba7b8b694368f10ab5c', 0, 'TheRealIsildur', true, 1695300443007, 2, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('bb5b273692104d9f4b7a8abb958169b6', 'cfff6a6c30e521f519cc70c690d8b914', NULL, 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('ab2e13207318dfd17c7d61901100cf52', '583b7c79e862ba7c26cbb11a16d4d41f', NULL, 0, 'Mr eXo', false, 1695471088689, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('d8791adbc3c5f9cbdd52a21a2cfec4df', '6eccfeeaab14d8fa039c535c2293de11', '0x4dc809d195167bb0e4e0405d3072d4595b443acb', 1695830640427, 'TedCrypto', false, 1695827005282, 2, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('45a09634a6567cbec85a8615c34d862e', '6bcbf5f4affd43b081da27549efb0f95', NULL, 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('22ca9eb58887ca54c2daf81ff4f12453', 'd657507dafa1ea8b8c3df3b83dc71249', '0x992b855f94f907e0ad8483140fd1f6d125c8aa03', 1695149416439, NULL, false, 1695145687194, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('f72ec4c2579b2e08f22a775b615cfe52', '2277661f27b50dbe97ed0f00e120b795', '0x064401fa3796467257940bfc230e14abad73f378', 0, 'Donald Lannister', false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('f8c3399feb614d53487d128b051a0038', '5bc5bf91f89125558dc31c86cdd5dc17', '0x17b339dd9579aec49d075d539729552b3488ebd2', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('6c1d52461a18839ca5d3eeb25a884a0c', '048ae76686b6ffc2fe43bb3f77eb1d8d', '0x96b59ac7d6d40bb27c90202a4793ad571cab15b3', 0, NULL, false, 1696266395351, 7, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('2570f8e2d8ac0e842d7a6dd328a72be8', '98826bb34cbcddf25ae3a8163af585af', '0x031aeada4ff6096cca3ed161ec6a06125ba3d066', 0, 'Human', false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('3c9fd46f2a138779f0bcea08b3a9d823', '76aeea31fdcdf5564fb4510b40db13d5', '0x0fbebbcff5d4b0d8f6e440507350c7bb72bcd02e', 1695282046512, 'Rigo', false, 1695277746006, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('dd6fb18e1560c36c67a32b195591183a', 'd451bd449a6008297bc4fee991ed6744', '0x592ba89811880eb4d9dfb759979b35da8b986295', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('d8f09fd9580ee0c36ac61246a7103c12', '23c2a7d4dc49d61c49a0e6e2a6919522', '0x3e95e93ace1d56792d3ed326b3f20d32f050fd9f', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('a7871f824892af2e35113fe6c8c6a079', '6d64cb4b77ab69dc1c9a7468f9f78d79', '0x0d960b67269b0837c0ebf6a09cce69377590f020', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('931c020f8099357b3a47ce944acff9df', 'b24697110bcb010fb6620330de37b6dc', '0x319b916a699865618121b99e66e34b1cc597ec32', 1696070945530, 'NickOfTheSama', true, 1696353135050, 18, 18, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('56432973f8ffa950803279617d2fcb15', '4c8e863710e237c1aa4ec02853b74e53', '0x4a74228bcac7cc2e6fa52eeb644005edbcb7ed9a', 0, 'Tiggahh', false, 1696329285936, 4, 1, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('4e553e525136cfbc824a8f1c02b0f99d', '787073f7e24f7518ac1bc3cb89d8aebc', '0x90e1ad3a81411b60c73dbebdc3fe985f73a990b0', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('42d749a0407334767c4b6d0c63a1f748', '2afebbd261f33a78f6046fedc64d7601', NULL, 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('9ceb2015d844b466321ff11e8ef708b7', '4342b973c61137f9d49c6f05eeb84a86', '0x93bf79e6a9944e1aa6c843680066dbcaab226f17', 1695618368952, 'Didaw', false, 1695614444339, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('3d5d8bd06c601c2bb6b0cbfcf40e8d3a', '00bf48c979843b3cbee1464561bfe25e', NULL, 0, 'DaBricksz', false, 1695138789598, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('7ab772fbeff8868bc394a62fa11ec662', '668d5bc6c1143584e7fe3e9bb9e384ca', NULL, 0, 'Ballzy', false, 1695249197427, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('13100be8fb06309c3ac2a48bbb7f0825', 'f4b7f0008c5110e23f6dcd9dfe8e46fa', '0xa982f2965130fa59305e480ff42ab6a563b406a3', 0, 'MonkeCrypto', false, 1695139348133, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('7f889a818d1fce490867cbfc4432d6fe', '6343cf340c3fa913fdb5cf0b7cde11c2', '0x491ffc953e1ab2751817ff90a5f32694a4841474', 1695494825401, 'Curly', true, 1695690196791, 5, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('5aa61e885188ccaa9f2cbb7460cfeaaa', '7277160c9d20057af73bcb371d47a669', NULL, 0, 'DotSama', false, 1695225852443, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('5a91c879e6514d118bee24aa92933276', '36cc4111747d04d0dda52d35bc61bcea', '0x932bad9228d2bb187548677ce6712f9b001993a9', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('80e8dc105ed4d1e7028685088b678202', '0100d8cc561bff39d27a9ed026306332', '0x1d0e5f3459e16dd67bb3a985aca0f1e92d72fe09', 1695634225007, 'dotsamaduku', true, 1695977704721, 6, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('eaa0e93154eece93cdbb4ee7b376069b', '491e6df8fec5982c97a0b1ffd484a401', '0xcc8356a48083c08c4792869ba6eb089cecb21797', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('997e0cf0e79697f324746b0bc849a4d2', 'c5bdacf2e5bd571f02807edf6e0a8bb2', '0x81366eefbb88ca85d58db113b929fbc908a5b5df', 0, 'Kyilkhor', false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('e4e1de2e62815faf809666458802c398', '93ad363dd05e76a4da2acf56c23c2bef', '0x0bddf4e169c35b77186c6ce1c987408689c4634d', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('aa38be4f15530204e131ad2bdd5a2ed4', '7eb3f8ea5302a9b96ce0d7da27b41e71', '0xc9634ebc37b543cbee414fcc4426f447370e50b5', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('b2e86422d0e3acc00438b84a266f9a7c', '5b614abb2cecfb3ba33d287eb52276c9', '0xa209a754da05c44e23d656a2bef3f6614d1cbeab', 1696029158711, 'Sonthunder', false, 1696091322858, 4, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('0cd2d9670d769d42a91f9eb923ab6271', '2613fb5e54342bb1bee8079c8e559bd4', '0x8d0b928e34d0c2ea626fd84e79d6b221feab5030', 1695415002532, 'Momsama', false, 1695411309562, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('79f786b876b4ae4e280e58e460ebccec', 'e38f9fb553c821a81bdbc02bfe3020d9', '0xca19d045317224c3bb84af1a403f70bd3589ef56', 1695289363451, 'BenetFL6', false, 1696338805256, 14, 7, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('9bbb3f23428457de9ca1bab3b4a2271e', 'aa7b85e663b2ce84eba547b597b25645', NULL, 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('c5b3f74cb37ee65d8d073767f3085de2', '0d8a5f8a55583999143ff0224463c50b', '0x8386a270f99a9cc491934f4355047d78005715d0', 1695151224052, 'Mark', false, 1695147562678, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('e9a06edbc65ffd7697edea14903f7b5c', 'a96cc0948cf57027b04dfab398c0132a', '0x6f61d896a9b9e1087065e1630be44f394786f3d1', 0, '3Babs', true, 1696273785322, 2, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('e33ed28337915d76612b383e6085b21e', '7fcf4ff7522a003778509dbf3d624a4e', '0xe794e62d11a11bf1ee8ff34eacdbd1c20f20b7a6', 1695153466483, 'Monty', false, 1695224948306, 2, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('f6554c3cb4c604aed4dd6560eca2ad37', 'c60fa16577ba59e243e6f5115b22a6ad', '0x2d17e331a7eb8073c647ebb70bf44a429f9d9b91', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('8c061ccaa9ef94a704e9c123080f55fa', 'a5c06b0d40c171792000c84672497f4d', '0xdbfff9ca5955bcd25ce77dbeb27183cc329c8e24', 1695289979664, '0xKryptoo', true, 1695403468764, 2, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('5b49bfbcb25b3af47950622f9a3774f5', '6479559e9a8c8d28370a86740f45f7b8', NULL, 0, 'Whatafaaak', false, 1695583537279, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('fe6ff777382a651e9f4ba15b6165fec4', 'cb20196dd84c2fbad975d535e488eb8f', '0x7bacff455a5d921d2c953180083d488bd380eb2a', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('1686c83b5dc32c0e7178a5fa3819856a', '4f0042a1f6e520515b138eda8b24bbcf', NULL, 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('840812db544e9a7fe43485d7d9dee6e9', 'a6a2d813421b4306b54c3f0166d020d0', '0x34cd39508ecaa638538e5a1b1be00ea3b7b5f2d6', 1695379957491, 'theDarkKnight', false, 1695888713881, 5, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('3ee34a1c967fa233329222f240dfd4d7', 'd09d7043e7b681df16de952127888f37', '0xa65660a7c3c4408fe1ef6a33dfc3b1d312263b1b', 1695310256577, 'MGC', false, 1696009741931, 4, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('420d68b38209f640b67c3ee478bea3a4', 'ec754a6eb86e18cf7d3c29af69dd0d0c', '0xe1c2fe8ee6d476debfa59e7e0b055cdee246fdef', 1695325647592, 'worf201', false, 1695321926381, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('771475b69d366eab5a15f99334a12762', 'c6c9d9cfc7923e1df284898d72c3684d', '0x542325af03aff2b3ac9f0882b4442590717362c0', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('8c5a0723a9cc0419de16d204a9fa0a9a', '98e7f17f736340df274f6f4200f99979', NULL, 0, 'Jump', false, 1695146850143, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('52ecfbd9abea33e4d1667822ab4292b0', 'ba034967e461db8e28777a2886305526', '0x61cca8707ae928298d3b3e8c1de0d7095b7b74b6', 1695929373043, 'Hanjimono', true, 1696362307533, 8, 7, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('9ad1684d8600501ce299ced608cf7605', 'ffb0fb571c68212c64949d4feaf9d3b2', '0x25341068524e657dd9434b6cf3738d27da87d66c', 1696088681390, 'SliderSama', true, 1696363245349, 18, 18, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('81f50d02ac94e39a4b9b7b80b61064a7', 'c3339c44eefe29f40f655a3aa87a7ea8', '0x9c854bf81c81cb5038ff3dd702e9e552f20fe1b5', 0, NULL, false, 1695396564916, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('fde016b577d0526f2b5a937a1b9dd194', 'ae5ebecdb370240cdc343eaa7b3980f3', '0xf8c01c7bdfbb7d2add39ed08368217d605d31f2f', 1695290947512, 'elix4t', true, 1696367570791, 16, 16, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('fb1f13c06fd511ffcf9b40f2cb4ff00d', 'f44bb6ad296c354a6ee65fffaf8ebb36', '0x506b61f9dd0b2b3e93ef4646b35e64eaf5388d54', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('82e7804233a02be8829deb4ec56b4480', '83ed380b64032a721cc8c06b87eddbc5', NULL, 0, 'Cojak118', false, 1695187577396, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('313df5b1091667daedcf495dec9cea39', 'c8d0fbf1b75001476edca079a99fcb41', '0xab5da83c4b2ef1d1921f426c405adb9e0d8ef056', 1695144702832, '30Doradus', false, 1695236054328, 2, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('399b901343184c8410fff5a9d0cff17f', '7603e8907dfe56f0ed1e646d77b9ff59', '0xfa5a1f0e3b506acb0d5183dbff6d0d6f33bcaea5', 0, 'teslanova', false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('cb4d17ffd19fe86ab87efea83f4d67d6', '67934dd2e80440e6f098d50814c3dc0f', NULL, 0, 'SiNoVA79', false, 1695313841540, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('db2cfd6056db33221b4e91f4c18366f9', '26f4834d86b5c5e7a394029e959cd4a9', '0xd9c5db99859b01c1212a098a5c79f74c572dfb00', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('fb3fc894fd734cf1b081cd13b97330ba', '18fed0507e5543fe93eadee5510afe3e', '0x485f8eced21e7581ed582f8d9394a4e7584c7d8e', 0, 'Kyt', false, 1695165685729, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('7510e97ac1d62a68f4abb8e7a5f933ee', '535ac9bb50aa917c4ca00c8ec3435c45', '0x759ec7d623ccf175e4a550d56381dc58a8a2c323', 0, 'PolkaWarrior', false, 1695500756203, 2, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('aa7d5cbd413b75c174545de232a16177', '2139f095f85a359b23f038e9e7d3f34a', '0x6013ad1e49066dc25bb8a82e2eb467add62265f9', 1695196878552, 'thekusama1', false, 1695193141022, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('7952a6c2b01538cc3427c8e1c3673c8a', 'b41f9df65b55ac8f8547be9d61176051', '0xc78a4443164039a5d8cf91b75a090001e29d66fb', 0, 'Le Comte de Monte-Crypto', false, 1695412112431, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('37a6afc7bcfbb0f468b0bb191247771a', 'dcc4ff0f4fd2350bff8956bc874369c9', '0x62c85407bfa12cf5350dc6ac5cf1fdf3f45cc15f', 1695455661458, 'oozaru', false, 1695451711278, 2, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('5c1562a42a50ff4c83c807c54de4ba96', '78d9d9f2c3a4dc5fa45c5c254ba2ca9d', NULL, 0, NULL, false, 1695318587728, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('de058a2c4dd1b0999f38a82d5492b7c3', '07cfe8d25f6533f72c149d34a8de7d94', '0xaff85fbaefefb64fa0a535de424117a0a9d35b74', 1695270598203, 'Nachitoyesod', true, 1695266758141, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('f63ef016c7b0d252602c083b0e8fc216', '0eb78c66b637dcd551aabd96c8dbdbbd', '0x705317be1e94317672fcd2f39d7f5e607f9e4d97', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('5d5574169d358fa38c0fb000ad400be7', 'c0c70f1d750ad55656621efd8a5e8ea5', '0xde848f5949206a9e66e1800e2c5a69d2601fbc22', 0, 'Israel', false, 1695356003346, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('e90333812d872d3d283d6e4305317192', '18b91d34ed268f525d2e0f19628d9245', '0xba1688252983cddf5c5484975f9e8da35ceb91bb', 0, 'Pattaya69', true, 1695146961495, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('0876b0915ee6bc58786ff38b49f57dfb', '7aacd74621b6690dd40300c5a2f3fc80', '0xbf87fafcc5d86010744ade5e1669d785958fd871', 1695151372674, 'GNOE', false, 1695147508735, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('ffe56b025d76cc59bdd21a583e224509', 'cf9e769b76e2508a59a90d4f08b91707', '0xebd9a48ed1128375eb4383ed4d53478b4fd85a8d', 0, 'JDubs', false, 1696006223963, 4, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('61c1e6910d35605f136ec0155f6c6348', '71f1450e499d8ee58a2f38e4f7b1f18e', '0x85799ff1c86f89fe9fb07773d1d240763b6039ce', 1695297677656, 'Tjolpie', false, 1695293367241, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('5f4ad16f37ad161542cdceef22c80f3a', 'fb5d361f827d65f17406d974f453cc95', '0x3c69cf466b8ccede9b7d25a96080eafbd02c446d', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('870757bdc7fef8b2714013bc2a318bef', '793cea418931dd41cc3773478d718dd9', '0x9420282ce93e91a0e756b8a33a48e64e863bca3e', 0, 'PolkaBee', true, 1695146645314, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('634b00541a55278c3cee630766f4c8d8', '06d96bc2d92eb4b366623e0051dfd683', '0xccdf7faf3e42b9cbfc529c2ba5fde4b2a6892b80', 0, 'AMUlll', false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('83341f162e865fefd0c878c675c6bea2', '5d9efbd5992beaace4685e20cadbc2e1', '0x292e84772e3ce9a5db4ba914b83b89b74886f1bd', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('6bc8ea847418f760551280ef6dd6fc6b', 'b56ea231c439994faba6ca8cb47dede0', '0xd887474fe347562450a9a892204abb3d13039550', 0, 'SummerShades', false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('05bc926c8789b546269027e87644364b', '31e78ae0bb2c32289ec1ffca7e5d14aa', '0xae763e853ef7cd9b52ddabdd4181fedda322f59f', 1695153945955, NULL, false, 1695150256028, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('b1b567fc4d05e5b6880601d707e44cd7', '793291030d3fc32dc54b8927cf25a7c2', '0xf0c56251ce95e39882cc58f3cc14272771ae2f44', 0, 'vonyi', false, 1695909498637, 2, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('34bd935f6e5bccc9b8eeeaf969f7ee18', '333d86c61d17f5da31065c214524336c', '0x7cebae9a7fadf20087b6ac67cdb5d2c4e89fa667', 1695181391688, 'scoops6.0', false, 1696291096653, 10, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('cc555e23cf45fdf6ab740eb05cf5dcc2', 'a21579b852b1b6409a3b8038d79f642a', '0x6eeca55c7cad1b1c1c3f872e1b5659f520c19a1f', 1695195640957, 'EmmSanchez', false, 1695454926136, 2, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('9396e4b57422f3738b70553013ea795f', '437fd63db83e417c9d4ea9cf216a04aa', '0xd079429401ca47b190dcaf2853bb8ccde199b563', 1695149303312, 'RagerTaco', true, 1696348856856, 12, 9, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('c36f807890c9e8f0c1d158999c776098', 'a26216886d001d8bb2291f7498e50ed5', '0x0939ece40293c89df6f4639af3c7c35d799b5f00', 0, 'Mr_Martin', true, 1696358267175, 14, 7, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('a929a4cde9bf4b462763756315502487', '089275cab9ad049e8245e1f66ebcb09c', '0x6c96d29e8763ca0996f983c0469630a60b108c9f', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('af53af34fcc1cdcfe15d9d8a6d55e0d9', '11d8a4baceda3cef27c9467867c0dfab', NULL, 0, 'Rish', false, 1695139956228, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('f7394ad4201e4a78cdd0a8ff286166e9', 'a9b3a80b19297ea9a8263ca394ba30c0', NULL, 0, NULL, false, 1695297239111, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('2128e0d3252642f93a87293705b48788', '22e0e684e2b1674692489bc8ed6c139e', NULL, 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('e4bd240864b4e2ea299e7e37ed7e08a7', '28b771135457d090a8a352630f215df0', '0x5017ac3361cd1a702f28eb20545a2af858b491ab', 0, 'Alnitak34', false, 1696364349473, 15, 12, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('e3d3f98096c517fe25f9f849f69077e7', '504fc73e2c8dec51be49b91b4608fbc7', '0x3013999a39d108e08193058054eac9db213a85be', 0, 'Sinova79', true, 1696371762354, 18, 18, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('a884abd66d3b02c1ae8be54ef00a5ee8', '903c453d8fa66d1aa9936a3de1f6fa52', '0x18688146713a8c38310547b473dd87c28cd941c6', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('0ff885eb0b37ebd11a4f2401441ea001', '887a126ae393a51423d1cf9ad2558735', NULL, 0, NULL, false, 1695272117412, 2, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('3db9114dbcbd84140b6ee1a4cb05ec0f', '426d8eec98a6b4129229ce5de7633fc3', '0x3edb1be154d8c8fc4818fa7695da7620ecd5ef91', 1695417456700, NULL, false, 1696266446421, 5, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('8cc79d2d148f6854792f72cd1abd81aa', 'bead5ad687ad589bda066e83d8333666', NULL, 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('e3df867334ae0296be46a1dbc328069c', '3f31d31c89e6ba7364816b58bec059ef', '0x0efdcf9840fe91e3925e386d3633debed4369c27', 1695194420567, 'jedispin', false, 1695190528225, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('96c4a901e7d2b9bf4b7f2095cf2caacb', 'afad125a0e19cc381e8a0c1b4e1a620c', '0x3cc47738fe7fc2587914d63420caf37cce129a02', 1695144334429, 'Samagotshi', false, 1695910379840, 5, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('a883318debdb2867588d457bf311897e', '7c8b6124547b36ff9b9b5d199aad40f0', '0xf8340c4d26d3787207133946e5a31f2ff4484df5', 0, 'WreckeRRR', true, 1696337695783, 16, 16, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('2b078aa3623abc834b8a2663dcd1d1af', '2ccd48f72d031a86899a90dd3852645d', '0x242bf8c5a3dff71b6dd6821fb9ddfd493a6bcb1d', 1695154485835, 'Rock', false, 1695150464749, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('3550294e25207d1892925d283a25ecc9', '5485b5c2d61f7327b7e51a7f963e3e65', '0x988d0ed33e9a5e7def0736bc693284bfbb190d17', 0, 'Osiel', false, 1695140062534, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('d4103870e90e2b7b766ca07c18faf9b4', '2a6705cd5a47c89da44bc45013b8bee2', '0xc37f000de73a3032eeaa4fa4cbf4db8ec527552f', 1695144392012, 'Bastral', true, 1696368153269, 13, 7, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('553bd29ed6afd7295aa34e0c79159182', '8f06df97b62436b359cdd316d5488038', '0x3cdafc99da990d56abedbc0af7b4247ad2dc5a74', 0, 'TheCryptoChad', true, 1695936242023, 9, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('3f4fd78eaefe31ffbc27ad2132dfcc98', '6a656bc0854328de40b4a647a6ca275d', '0x1bc65b00eabd7af0eb41f8d6d9934783391afea3', 1695430849421, 'Timakaka', true, 1695432129955, 2, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('63ca40a22b62d2cb12ccc51c18e1d8a8', '48d18810640158517b6a422f77a822dd', '0x613f2f6ef6f175a7f60217f3cb1c168ca922bc2d', 0, 'Dimon', true, 1695206255411, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('dea48903ff03f1e3ea06746d471056ff', 'b3fad72c5bce05e4c5d70b85509b900c', NULL, 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('ce81fad8de68fc151c123b24e0e90460', 'b7c50eb639b53a5256fb96ecb9067601', '0x9dc6d51044fe2b9cb708a2e522ca21a62d35513e', 1695154671751, 'Tumtum', false, 1695150720273, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('0fc37423070d4967d01befeb06b641ca', 'c4ee8bb1635687ee6dd004ac2c506cd4', '0x875576dfac97ef162a4b7b55fded46f2dd312ef0', 1695195910840, 'jeroen', false, 1695192172278, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('2211be98a0222847ee9591bb89bf7a7a', '63ec64858aeeaed656b07b666ff8e9f9', '0x2bf136e8ccb32e9a213a4ae6778d703cf55b5889', 1695304066559, 'DavidPxDot', false, 1695300064868, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('4fa1610de9318fbfa5cbb4f6a7d2f8ea', 'eb41063e3266607f261339d3d6f424ed', '0x8a9865785dbbd747fd67536112daf3ee161bc287', 1695732088192, NULL, false, 1695728395516, 3, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('f8b010b48bd593c8b6db4a36182e76ca', '7a056c78517bcad5481dd02d0d6f90c1', '0x1af51642db6ec70e43e9d0cbc36872dd2f647f32', 0, 'Bobzerrrrr', false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('a6d98dc532d935878a89a68a1fd2fc0f', 'd40a81ce39189950d7da458aeca220ec', NULL, 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('290abe949476576cea86a6fb8519ed10', '0ed33497d37b11969beb11de8364c335', '0x7335f905b4dd29d58c5afcb4f8d8016e1eb5ad9b', 1695308187631, 'Meister of everything', false, 1695304424553, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('ab1abed7229a166d3f4fe58a5669bfa0', 'f49ab8ccb97ba49111732bcc53d2f9ad', '0x9210cbb688eb68d0c0dec88da9d7ee8a6b8b4dec', 1695224689065, 'McForge', false, 1695852201879, 3, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('30124a5aff54160137a664397ef908e4', '7be14e85ddb71c99b6f3fe4e1ccba09d', NULL, 0, 'jac', false, 1695151037722, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('4b81f5f95adfcfe5f6ec6c3cd9466826', '49b7815d8d1a22f0896669bf5238dfeb', '0xed66e493e956849ff67b3e546f8daf3d68ec380e', 1695200405178, 'TybibouneDPS', false, 1695886719550, 5, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('cf7d15d6200e887268df607b12d771e5', 'faaea04ed47b4169f7af32d9dab016e5', '0xa8fc32ed35cbf232cda8468da77e01183d3cd04c', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('c372a8318682dfb95a35914ca03e7264', 'd93eb72f363f69a64be091bb00ed04e0', '0xd690b90480010dcd01e13a26835d67d1c71fdae8', 1695309545184, 'TheInspector', true, 1695328490618, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('7cff22cc686c3f3b64e02c353217847d', '079e001d1444aa890bec94b1c56e62c7', '0x1f137f133df19d65669165a0963fe72485c7fd0a', 0, 'Cry4max88', false, 1695151281594, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('91fd91e5979e84db92681057251dd07a', '13b5fa0042697ed390f4a73c4d9e4019', '0xb8df3eebbb49a09495e08e284545f48c29013f98', 0, 'Kenarein', false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('2a0c077b3a053a1faa63ba92e23bf8a9', '69829efd3652762d02318648207c492e', '0x514d58823c12ec695ef378d4cb3013faa147105c', 1695200549749, 'bami-life', false, 1695223124994, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('6db49b0316455eebf788c1ee412904bd', '5dd0a251e7b7551c3249091316e407ec', '0x02b16229cc3d4b0b7d1e6c6006a76e9eee387caf', 1695144794292, 'Dipset', false, 1695350272910, 3, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('91d696b396d3bb3c6e79cbadef697e56', '05ce6d93194b3147dbfba726d3504b46', '0x67ba609c80f01ac8909d07a5c8f0f9c182c41bd3', 1695144686581, 'Monsamalbert', true, 1696331456666, 6, 5, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('9ec9323247fd6e18a5685b9312e64698', '2d6decf1995863da1d4bcac9b689c8d7', NULL, 0, 'EXOkarass', false, 1695376970333, 2, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('d3504c4884a448098c571f34c6581447', 'f2fa4d7a531c5262171a5d83a441e1d9', NULL, 0, 'usermane1', false, 1695151604716, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('6d558868e5eb112dd33f18e16f27255c', '3d8663a4903881a2eb8f9c5926c01964', NULL, 0, 'Captaine', false, 1695199631298, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('4f75f47d1af3971360fe2d2bf4e8af81', '971c05c208cb0d1d5b1637c85220f353', '0x9d67abaaa744b564fc605216dba6a8d684599537', 1695144383099, NULL, false, 1695140747368, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('ff0a3c7e3e786d0d14eb3d6461d18a1f', '979b992d8da563f0025b38d5d1581928', '0x146e782479c3823e3addc2d0cc45ec57b8612276', 1695145271580, NULL, false, 1696190141872, 7, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('158b098a91684e44eb97537371665215', 'c16c2a300be942cfec852bf7919a1d81', '0x3beb5e96c21fee32c43bed747dc1fc4e57c5594e', 0, 'MichielB', false, 1695845388572, 7, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('76cc1c2c7b2eb8e09ecdcf194de591f8', '017caa9d87d797663739366db1ff0f18', '0x0f617402b5954a8118ce951fbbddaf1a4ac16310', 1695315068173, 'Alarick84', false, 1695564253180, 3, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('4ca3a7b207cfe0fae39507cc6fbcddbc', 'f5d5024392726f66fac0300aafd21b45', '0x8cd78a617bffcfba5daf0c01b6af522590952fce', 1695203955000, 'KUNGFU SAMA', true, 1695405579201, 2, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('856b4268362fdf865dd3715af2dc0ce5', 'fba3a7d17b0fb6472194fb74acfa3f56', '0xfd80f0c6e080599dafd2a3d0160f60f9c8868f9d', 1695208691848, '@illingworth22', false, 1695736711716, 4, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('e033377fe4cd03e008f96964483c9235', 'a7b94f21db73a81a0c864f89d44d5559', '0x26ce8f32260f05e91faaf4f26569703cf5c52373', 1695155489465, 'cryptofisher', false, 1695151815491, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('10cd99f33ff3aa6cad9351a2c6929d74', '7d83648285584c232a783ff8d5a32c22', '0xb79bcb0cd6672662bf93aa2bee16726c654ca4b1', 1695156227200, 'DexterMorgan507', false, 1695152401546, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('594991458817762db3fe06d6ca2d8345', '0869f5f320b15017a281b33d22a43d50', NULL, 0, 'MemoPixsel', false, 1695152880802, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('39552fe103b4338d3b9dacf6660d6441', 'ba0ef8a8839498e1ce964a2cafa7f1e0', '0x5fa6c2cdc923631b99f42e7ab0ac44800fba1419', 1695145031172, 'Menke13', false, 1695914055992, 6, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('e7f14518ccadabf5545b94a0096deb25', 'b8297d555a5b0432482c729fa6cee612', '0x536ee857fcffe9e0b33d5cb17b69264588728a78', 1695207437078, 'dinonutsinho', true, 1695290173743, 2, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('e9dea564e158b91fc6e1cc628b463a59', 'e5bf12ac55555ba3a643b9b95b25417b', '0x135ebc63378e52d4b62081edd1a8db4c580a3441', 1695145380199, 'Confituur', false, 1695189240491, 2, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('1fc2a1f4297bfff3d212eb7095671174', '2313d21207a88f7ccd73d2e0f6bf2159', '0x56c0723288e40e7edc516f358c9a9f01075c83bc', 1695159055355, 'Karl', true, 1695231262537, 2, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('e041703b2870713ff894523dfe7d8249', 'ae2ac819bc8d1f5fab3c24349166c015', NULL, 0, 'Mr.Mountain', false, 1695311746982, 2, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('4e0e6a86be47a035ef07b2a786c05027', '3867ce1fc20dfe49937138c1768e4e97', '0x4350bfccfcd52bb5512244fcc3ce2bc878e9aa82', 1695210345299, 'SamaXtreme', false, 1695492332557, 4, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('e04d4e3dff7c54e0fa95aa876c09e7b8', '70a7969f91e84f4ba6db60d09d91453c', '0xdbedfdc1659f17b76ddfefee426c2478d774c109', 1695158161316, 'Greensamilla', true, 1696371085577, 8, 1, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('0dfd296b81d516e4a74282cacb87279b', '106044b887e0bf2272654ac40a808561', '0x8246732bdd058b628b18661e69ab2fc1f29a432b', 1695145500814, 'SpacePope', false, 1695141809372, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('00653748045b28cd1baebeb9add9eaa6', '0e0cbb5582416a0c5075adb08195f7a0', '0xd373dd844d7d10f7c3cfa0d6206de57380d35611', 1695158265837, NULL, false, 1696371461874, 10, 1, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('f2d15361ded0b327b76b2c702df0ddd5', '7af45fe7ed1334536473780562dbe95a', '0x78cccc65a0bc2bbe502c07d28416649c5c6623b1', 1695213954236, 'MustardJ', false, 1695210222921, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('00d69e19d0b4743ca3301bda4315c0ad', 'e6b12fdc0d69b945955ead0c5e143da6', '0x43766a37ef46c17f493803f6d190b1f7d0ac2e7a', 1695146008217, 'Schultzy', true, 1695909548182, 8, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('a81a1f8353209aee8d75d29146a804d7', 'c3a8f880a81f7b28d7005f778bb4a8d1', '0x87a71aa6355a9dcbb43868f6a4ac54116e0aaa8a', 1695158983138, 'Sniff', false, 1696281553707, 12, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('d93a6b48e5f3e742c3225a11906e94a0', '875a1850fbed68302a5cb360f8eda245', NULL, 0, 'Panopticus', false, 1695142496651, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('538cc2e2b0dff540a61e5dd783d8bc19', '9af3bdeb6222444a5555e3e40787e1f6', '0x27534ee6a1d10afae2cef0a68f17623d060f01c7', 1695214563864, 'Zuddha14', true, 1695210839878, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('c6ee65f989417985abf4ddf97b76d028', 'a72c6702319f33366c8a5ca7356feb26', '0xbeaaf573c71f50086f4e9491d2338abfd023446d', 1695146736094, 'Jcryp', false, 1695143039930, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('2a3b83b5e14056c0d5d0178fe82c29de', '82ee87bfeee8bcd773975aeee1a47ce3', '0x9fcf1483f750dd5a8555797b8190af62e5fe4d44', 1695215953535, 'Portzir', true, 1695387921876, 3, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('5662db7e8dce2de7d1f6bff42196a842', '3b76957f63cccadfc1eff0eec51528c9', '0x0581da444a46693496968d6611b15065fcf42140', 1695159483658, 'SKEN', false, 1695155743373, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('823e31f5b5a7dccffc2dc0c7e336b326', 'edbbd680183d6d375b4eef2ae45cdb81', '0x14f7c96aa0229a406efd67688c5187bee694de79', 1695159637500, 'Sandbu', false, 1695155908298, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('241ae4ecd60a8557d65c2138020fae51', '162b7d9dc3a015553865b51f4997e2e0', '0xe72aa6533d38009ebc810ded93ccd69f32e49db2', 1695146675656, 'Sovereign', false, 1695410456124, 2, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('10046613343e341bb98f76bd40103e2c', 'edd53aa7b629fec9f82350651b5b3484', '0x80595a71b57636856b61e51a939aa511a5d4008d', 1695305147227, 'KusamaMike', false, 1695301427436, 2, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('161eac46ffa89b8a50e4a62e55e8d43a', 'ba91819887a19494e25a84784a3fcdf2', '0x9bc66deb421faf05041ee69f8db194f6a34bdc37', 1695167367886, 'MiguelDot', false, 1695268270962, 2, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('8e19741140beac4a40a98f38dae4bf09', '012a171906c7619da6573ce239f88933', '0xcf61d8fc50f84767ca932945d167fd613f5da53a', 1695219856526, 'Xelo', false, 1695395060597, 3, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('c04f4c5bc84804771c831bed543de9d7', 'd862abf03c04d7769fc2685fb52a4053', '0x6b3a4bd72e25d26160e698d6e826c2ecbadef9c8', 1695160105997, 'pMr_NL', true, 1696275235136, 3, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('24fab4dd2cf2fc1384897a352d48ee46', 'c0bf21c24964da1c8075a219e29c6d23', '0x8812f12bf1b651b4c8231e033efc93b2cb8891fd', 1695167767782, 'moonlightsamas', true, 1695311639705, 3, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('699f73cfbc24d9d03cdd88fe5f9daf57', '5983872f465907a7f7033dc3e9500d42', NULL, 0, NULL, false, 1695156787983, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('debf1ff1cf69d4e94d28d5239d2a378b', 'b4680736e396d08ec507ef3682070630', '0x34a0829701d144253566c789c4c4635132355ccd', 1695220473450, 'DSama', false, 1695424116157, 3, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('ec33e20806e1a2383bbfadcdc5b199c9', '8bfc774dfc94c9abfcbe415c724dec8a', '0x4ce80cef4e36936a76ef8260afb9364cb44d6b82', 1695162293276, 'Shark_Tank', true, 1695226955225, 2, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('c0837d5efb07ac840f42b53ea5bd36ad', 'b7bfb94a37c6836de960eac854b3629e', '0x014d3239e6a0b9cb825527c8c365472a3e271028', 1695147695104, NULL, true, 1695143883487, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('d00bebb1f3e46c134f9bacdf17c46609', 'd23c925d7cc472907db6c3d6e647a023', '0x5ec37ef774357717d06c53870c5bacac7d63fa07', 1695220589800, 'Dudelydoo', false, 1695216851914, 1, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('4cfa23f7f79e91448139cdddd897e71b', '1ef0ab7077eab28ad77b9f169b3f9263', '0xb93701293b1bbeaa7d4b0a73449d30a1fcf459f0', 0, NULL, false, 0, 0, 0, '{}', NULL, '{}');
INSERT INTO public.users (uuid, access_token, address, next_faucet_use, username, linked_username, last_login, total_logins, consecutive_logins, pending_mints, referred_by, referrals) VALUES ('9575a2a456c95d6470ac8a54f8925d0d', 'b4febba25d04da413b841ae051fdd772', '0xcf220df87427b8d97954af31d266177c0bcb145d', 0, 'Rayzor536', false, 1695144591429, 1, 0, '{}', NULL, '{}');


--
-- TOC entry 3569 (class 0 OID 17500)
-- Dependencies: 251
-- Data for Name: vessel; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (59, '0x442cac6c7add9dda8f9017074a10e45969b859c9', 1, 61, 30, NULL, false, 'Cypher Flux Traveller', NULL, NULL, NULL, NULL, 4, 2);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (75, '0xe72aa6533d38009ebc810ded93ccd69f32e49db2', 1, 1, 18, NULL, false, 'Meteor Lumen Mariner', NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (32, '0x492ec88d26f1e934cc93754f904806794e0aca31', 1, 50, 84, 1695915118634, false, 'Temporal Vector Conqueror', NULL, 721, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (87, '0xe794e62d11a11bf1ee8ff34eacdbd1c20f20b7a6', 1, 12, 29, 1695227247407, false, 'Ion Velocity Pulsar', NULL, NULL, 555, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (86, '0xbf87fafcc5d86010744ade5e1669d785958fd871', 1, 55, 67, NULL, false, 'Ethereal Radiant Conqueror', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (53, '0x81366eefbb88ca85d58db113b929fbc908a5b5df', 1, 40, 67, 1694541550491, false, 'Lunar Terminus Nomad', NULL, NULL, 443, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (39, '0xbae01ad127c9e49179c9aa63109c0fc120782662', 1, 35, 39, NULL, false, 'Zephyr Radiant Guardian', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (72, '0x8246732bdd058b628b18661e69ab2fc1f29a432b', 1, 44, 51, 1695149706093, false, 'Nova Horizon Advent', NULL, 374, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (85, '0x8386a270f99a9cc491934f4355047d78005715d0', 1, 79, 79, NULL, false, 'Dark Warp Freighter', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (96, '0xdbedfdc1659f17b76ddfefee426c2478d774c109', 2, 97, 8, NULL, false, 'Meteor Nova Voyager', NULL, NULL, NULL, NULL, 4, 2);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (68, '0x02b16229cc3d4b0b7d1e6c6006a76e9eee387caf', 1, 52, 22, NULL, false, 'Lunar Kinetic Guardian', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (76, '0xbeaaf573c71f50086f4e9491d2338abfd023446d', 1, NULL, NULL, NULL, false, 'Gamma Quasar Harbinger', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (44, '0x759ec7d623ccf175e4a550d56381dc58a8a2c323', 1, 48, 57, NULL, false, 'Phantom Beacon Guardian', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (79, '0xcf220df87427b8d97954af31d266177c0bcb145d', 1, 4, 6, NULL, false, 'Penta Quasar Voyager', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (69, '0x5fa6c2cdc923631b99f42e7ab0ac44800fba1419', 1, 55, 88, 1695914419394, false, 'Stellar Vector Harbinger', 455, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (94, '0x3beb5e96c21fee32c43bed747dc1fc4e57c5594e', 1, 7, 100, NULL, false, 'Nebula Lumen Pathfinder', NULL, NULL, NULL, NULL, 2, 1);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (52, '0x3cdafc99da990d56abedbc0af7b4247ad2dc5a74', 1, 48, 55, NULL, false, 'Nebula Vector Drifter', NULL, NULL, NULL, NULL, 1, 1);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (57, '0x7543ae755256476f32ec2cb49c253c4e5d47b806', 1, 31, 38, NULL, false, 'Temporal Journey Voyager', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (28, '0xc2100a5022cd8fd7beedde6195a8894f2f0265da', 1, 45, 44, NULL, false, 'Radiant Stardust Voyager', NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (62, '0xe51a2e65d8b43b045de3d1db9e64906d14c61b54', 4, 59, 73, NULL, false, 'Hyper Stardust Phantom', NULL, NULL, NULL, NULL, 1, 2);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (10, '0xa982f2965130fa59305e480ff42ab6a563b406a3', 1, 52, 49, NULL, false, 'Cypher Aurora Crusader', NULL, NULL, NULL, NULL, 1, 1);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (67, '0xab5da83c4b2ef1d1921f426c405adb9e0d8ef056', 2, 32, 64, NULL, false, 'Pulsar Odyssey Explorer', NULL, NULL, NULL, NULL, 1, 1);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (71, '0x146e782479c3823e3addc2d0cc45ec57b8612276', 3, 99, 59, 1696190819870, false, 'Ion Aurora Sentinel', NULL, NULL, 443, NULL, 2, 2);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (89, '0xf580fd2b530e647b8ddce0e39e0e3e6cb9ad706a', 1, 26, 34, NULL, false, 'Xenon Pulsar Mariner', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (93, '0x26ce8f32260f05e91faaf4f26569703cf5c52373', 1, 7, 6, NULL, false, 'Cypher Exodus Adventurer', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (82, '0x3ec221a25b2dcf5634e4ff0af3b07ea17ae8d002', 1, 15, 4, NULL, false, 'Phantom Comet Wanderer', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (90, '0x242bf8c5a3dff71b6dd6821fb9ddfd493a6bcb1d', 1, 68, 69, NULL, false, 'Pulsar Aurora Adventurer', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (98, '0x87a71aa6355a9dcbb43868f6a4ac54116e0aaa8a', 1, 42, 93, NULL, false, 'Stellar Beacon Pulsar', NULL, NULL, NULL, NULL, 1, 1);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (91, '0x9dc6d51044fe2b9cb708a2e522ca21a62d35513e', 1, 18, 11, 1695152224879, false, 'Ultra Radiant Freighter', NULL, NULL, 532, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (78, '0x014d3239e6a0b9cb825527c8c365472a3e271028', 1, 7, 100, NULL, false, 'Xenon Kinetic Traveller', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (84, '0xadad5545a77b1748e69600b5560f2153abc19de7', 1, 19, 38, NULL, false, 'Pulsar Quasar Adventurer', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (6, '0xba1688252983cddf5c5484975f9e8da35ceb91bb', 2, 78, 95, NULL, false, 'Lunar Drift Pathfinder', NULL, NULL, NULL, NULL, 2, 2);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (66, '0x67ba609c80f01ac8909d07a5c8f0f9c182c41bd3', 1, 2, 15, NULL, false, 'Hyper Stardust Explorer', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (83, '0xc1e7ca17274c36a3358460f93ce30200916688b6', 1, 21, 37, 1695176422821, false, 'Omega Quasar Invictus', NULL, 383, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (88, '0xae763e853ef7cd9b52ddabdd4181fedda322f59f', 1, 52, 54, NULL, false, 'Ultra Terminus Conqueror', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (97, '0xd373dd844d7d10f7c3cfa0d6206de57380d35611', 2, 46, 13, 1696372361421, false, 'Zephyr Warp Voyager', NULL, 701, NULL, NULL, 1, 2);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (95, '0xb79bcb0cd6672662bf93aa2bee16726c654ca4b1', 1, 25, 83, NULL, false, 'Gamma Eclipse Freighter', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (63, '0x61cca8707ae928298d3b3e8c1de0d7095b7b74b6', 2, 55, 58, NULL, false, 'Zenith Zenith Pulsar', NULL, NULL, NULL, NULL, 3, 1);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (81, '0x12e6531c7e1f990d264cf0443ff7db196b9d18cc', 2, 98, 31, 1695976676024, false, 'The Warp Enigma', 305, NULL, NULL, NULL, 1, 1);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (80, '0xd079429401ca47b190dcaf2853bb8ccde199b563', 2, 33, 100, 1696356543229, false, 'Astro Aurora Navigator', 331, NULL, NULL, NULL, 3, 2);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (92, '0x1f137f133df19d65669165a0963fe72485c7fd0a', 1, 79, 87, NULL, false, 'Ion Zenith Guardian', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (77, '0x3cc47738fe7fc2587914d63420caf37cce129a02', 1, 27, 60, NULL, false, 'Omega Beacon Raider', NULL, NULL, NULL, NULL, 2, 1);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (31, '0xcc8356a48083c08c4792869ba6eb089cecb21797', 1, 1, 5, 1692874548135, false, 'Echo Velocity Enigma', NULL, 211, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (46, '0x47bff18e462912ab61a465b2bc229e3857491aa6', 1, 3, 4, 1693187521639, false, 'Solar Beacon Zenith', 170, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (18, '0x6c96d29e8763ca0996f983c0469630a60b108c9f', 1, 66, 72, 1692232220046, false, 'Void Terminus Enigma', NULL, NULL, 258, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (16, '0xc9634ebc37b543cbee414fcc4426f447370e50b5', 1, 50, 50, NULL, false, 'Zenith Xenith Mariner', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (22, '0x932bad9228d2bb187548677ce6712f9b001993a9', 1, 16, 27, 1692358714455, false, 'Omega Drift Pulsar', NULL, NULL, 189, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (21, '0xccdf7faf3e42b9cbfc529c2ba5fde4b2a6892b80', 1, 40, 65, NULL, false, 'Temporal Exodus Voyager', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (26, '0xf282529a89e131791f15ca45d32c6e1267987ced', 1, 11, 3, 1692399867377, false, 'Solar Horizon Traveller', 223, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (23, '0x542325af03aff2b3ac9f0882b4442590717362c0', 1, 9, 12, 1692366684298, false, 'Zephyr Drift Harbinger', NULL, 101, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (2, '0x3c69cf466b8ccede9b7d25a96080eafbd02c446d', 1, 82, 14, NULL, false, 'Void Nebula Harbinger', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (29, '0xc9ac4dcb8927891274442484701c104845a23367', 1, 6, 1, 1692562479942, false, 'Penta Zenith Enigma', NULL, 234, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (17, '0x17b339dd9579aec49d075d539729552b3488ebd2', 1, 50, 50, NULL, false, 'Ultra Nova Mariner', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (42, '0x1af51642db6ec70e43e9d0cbc36872dd2f647f32', 1, 42, 70, NULL, false, 'Gamma Drift Drifter', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (47, '0x27b7739f3aea9bc357526319c9cd82a0acb1887c', 1, 55, 58, 1693241866963, false, 'Void Odyssey Seeker', NULL, 232, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (30, '0x506b61f9dd0b2b3e93ef4646b35e64eaf5388d54', 1, 44, 50, NULL, false, 'Hyper Warp Adventurer', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (45, '0xd3a2978a9ad5ea4e76520594646ef7e8e1fffe1f', 1, 53, 69, NULL, false, 'Xenon Exodus Conqueror', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (14, '0xd7b2913be8247d7b54ec38366dc45fbe21fb4587', 1, 1, 1, NULL, false, 'Penta Radiant Enigma', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (33, '0x3e95e93ace1d56792d3ed326b3f20d32f050fd9f', 1, 11, 35, NULL, false, 'Phantom Eclipse Seeker', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (27, '0xa56cc2cc3fab1a0da80268ea83effbac3daaedc0', 1, 41, 40, NULL, false, 'Dark Sigma Pioneer', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (35, '0x0d960b67269b0837c0ebf6a09cce69377590f020', 1, 55, 70, 1692759203275, false, 'Void Quasar Sentinel', NULL, NULL, 257, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (49, '0x2d17e331a7eb8073c647ebb70bf44a429f9d9b91', 1, 7, 7, NULL, false, 'Zenith Eclipse Nomad', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (50, '0x0bddf4e169c35b77186c6ce1c987408689c4634d', 1, 49, 52, 1693313554750, false, 'Omni Vortex Enigma', 163, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (36, '0x9f8d9c183150f15ffba39b7b17c3e1a78e5e5478', 5, 97, 85, NULL, false, 'Gamma Exodus Voyager', NULL, NULL, NULL, NULL, 5, 4);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (7, '0xd887474fe347562450a9a892204abb3d13039550', 1, 48, 44, NULL, false, 'Cypher Radiant Freighter', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (9, '0xe13abdb784435f7e12656daa2fee2687b4486152', 1, NULL, NULL, NULL, false, 'Zenith Beacon Sentinel', NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (48, '0xf363b614cd6536f2191ac6bf3bbdfc4030ed94da', 1, 18, 98, 1695135862954, false, 'Ethereal Infinity Odyssey', NULL, 401, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (11, '0xebd9a48ed1128375eb4383ed4d53478b4fd85a8d', 4, 66, 56, NULL, false, 'Zephyr Zone Mariner', NULL, NULL, NULL, NULL, 3, 3);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (55, '0xb8df3eebbb49a09495e08e284545f48c29013f98', 1, 20, 22, NULL, false, 'Zenith Quasar Enigma', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (13, '0xfa5a1f0e3b506acb0d5183dbff6d0d6f33bcaea5', 1, 20, 69, 1695053559859, false, 'Ethereal Radiant Juggernaut', 349, NULL, NULL, NULL, 2, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (70, '0x75e5ef92fd7b6bcd54869f096e8278cc079f5036', 1, 12, 89, 1696378618531, false, 'Lunar Infinity Nomad', 350, NULL, NULL, NULL, 1, 1);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (60, '0x0939ece40293c89df6f4639af3c7c35d799b5f00', 3, 81, 14, NULL, false, 'Ethereal Aurora Pulsar', NULL, NULL, NULL, NULL, 3, 2);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (56, '0x124b76631b4add879a9bf5a7759cfa3a1d78ca2c', 1, 1, 2, 1695918800072, false, 'Zephyr Exodus Voyager', 456, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (19, '0x4a74228bcac7cc2e6fa52eeb644005edbcb7ed9a', 2, 26, 60, NULL, false, 'The Pulsar Conqueror', NULL, NULL, NULL, NULL, 1, 1);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (51, '0x1770de12a1b5b1283d56cd7a1e5fbe4fe284511e', 3, 18, 23, 1696278980697, false, 'Void Warp Harbinger', 354, NULL, NULL, NULL, 3, 2);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (54, '0x5017ac3361cd1a702f28eb20545a2af858b491ab', 1, 42, 48, 1696373620812, false, 'Hyper Infinity Voyager', NULL, NULL, 288, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (5, '0x914bd52a86f6f2f3fc72843e69ee2dd8a54ed50c', 1, 10, 92, 1693655672304, false, 'Pulsar Vortex Seeker', NULL, 230, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (61, '0x485f8eced21e7581ed582f8d9394a4e7584c7d8e', 1, 45, 45, NULL, false, 'Nebula Quasar Drifter', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (34, '0xc9792727ef67867670d85ba7b8b694368f10ab5c', 1, 23, 1, NULL, false, 'Phantom Radiant Pathfinder', NULL, NULL, NULL, NULL, 3, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (58, '0x613f2f6ef6f175a7f60217f3cb1c168ca922bc2d', 2, 9, 75, 1695209744439, false, 'Phantom Odyssey Zenith', 347, NULL, NULL, NULL, 1, 2);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (25, '0x064401fa3796467257940bfc230e14abad73f378', 1, 50, 50, NULL, false, 'Zenith Aurora Invictus', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (40, '0x3b3c5ba49da136c2761ac39a888e50d7c02edf88', 3, 22, 29, 1696263599581, false, 'Zephyr Xenith Drifter', NULL, NULL, 514, NULL, 4, 3);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (37, '0xedcd33a9c1a6cff9a887e9054bb5933002ca13cc', 1, 13, 36, NULL, false, 'Xenon Horizon Seeker', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (15, '0x9420282ce93e91a0e756b8a33a48e64e863bca3e', 3, 5, 26, NULL, false, 'Pulsar Cosmos Drifter', NULL, NULL, NULL, NULL, 3, 3);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (43, '0xb9072e7f4b25b523cd2144b05e8734b68e18fcb9', 3, 55, 5, NULL, false, 'Holo Sigma Sentinel', NULL, NULL, NULL, NULL, 4, 2);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (20, '0x031aeada4ff6096cca3ed161ec6a06125ba3d066', 1, 25, 97, NULL, false, 'Ethereal Flux Traveller', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (64, '0x9d67abaaa744b564fc605216dba6a8d684599537', 1, 2, 2, NULL, false, 'Ultra Lumen Crusader', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (38, '0x96b59ac7d6d40bb27c90202a4793ad571cab15b3', 1, 23, 30, NULL, false, 'Cypher Nova Odyssey', NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (3, '0xcda3f9f535587a85aed04397d933864256dfe1dc', 1, 72, 8, 1695239951392, false, 'Warp Flux Sentinel', 323, NULL, NULL, NULL, 0, 1);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (24, '0xf0c56251ce95e39882cc58f3cc14272771ae2f44', 1, 1, 53, NULL, false, 'Quantum Stardust Juggernaut', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (73, '0x135ebc63378e52d4b62081edd1a8db4c580a3441', 1, 1, 51, 1695192794807, false, 'Void Zenith Odyssey', 337, NULL, NULL, NULL, 1, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (136, '0xdbfff9ca5955bcd25ce77dbeb27183cc329c8e24', 1, 5, 29, NULL, false, 'Penta Xenith Voyager', NULL, NULL, NULL, NULL, 2, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (120, '0x78cccc65a0bc2bbe502c07d28416649c5c6623b1', 1, 32, 15, 1695210503960, false, 'Xenon Journey Voyager', NULL, 425, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (105, '0x9bc66deb421faf05041ee69f8db194f6a34bdc37', 1, 13, 8, NULL, false, 'Cypher Eclipse Pioneer', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (128, '0x414f5774846944908142e7c1fc6c91b5c14e0eea', 1, 14, 91, NULL, false, 'Solar Horizon Marauder', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (141, '0xd690b90480010dcd01e13a26835d67d1c71fdae8', 1, 40, 42, 1695329858162, false, 'Ethereal Cosmos Traveller', 409, NULL, NULL, NULL, 1, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (123, '0x34a0829701d144253566c789c4c4635132355ccd', 2, 66, 87, 1695430554175, false, 'The Lumen Explorer', NULL, NULL, 491, NULL, 2, 1);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (122, '0x9fcf1483f750dd5a8555797b8190af62e5fe4d44', 3, 22, 42, NULL, false, 'Temporal Nebula Explorer', NULL, NULL, NULL, NULL, 5, 3);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (101, '0x14f7c96aa0229a406efd67688c5187bee694de79', 1, 16, 22, NULL, false, 'Zenith Vector Phantom', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (133, '0xf8340c4d26d3787207133946e5a31f2ff4484df5', 4, 14, 11, NULL, false, 'Stellar Pulsar Invictus', NULL, NULL, NULL, NULL, 5, 3);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (107, '0xaffc193174e262e1201961ac3b5286a82d0e622e', 1, 66, 11, NULL, false, 'Meteor Terminus Invictus', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (103, '0x4ce80cef4e36936a76ef8260afb9364cb44d6b82', 2, 33, 84, 1695235661844, false, 'Nebula Aurora Odyssey', 365, NULL, NULL, NULL, 1, 2);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (112, '0x875576dfac97ef162a4b7b55fded46f2dd312ef0', 1, 9, 31, NULL, false, 'Pulsar Journey Pathfinder', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (4, '0x3013999a39d108e08193058054eac9db213a85be', 6, 35, 57, 1696373001688, false, 'Phantom Comet Phantom', NULL, 373, NULL, NULL, 5, 3);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (118, '0x4350bfccfcd52bb5512244fcc3ce2bc878e9aa82', 1, 14, 16, NULL, false, 'Hyper Pulsar Marauder', NULL, NULL, NULL, NULL, 2, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (109, '0x8bde4d211b511fb5b65977010315e6322a67044f', 1, 27, 38, NULL, false, 'Stellar Xenith Juggernaut', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (144, '0xf0db619363881ceb6ba06b9ae3dd4886652aa896', 1, 52, 61, 1696196932174, false, 'Ion Stardust Juggernaut', NULL, 437, NULL, NULL, 2, 1);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (99, '0x56c0723288e40e7edc516f358c9a9f01075c83bc', 1, 69, 69, 1695241821923, false, 'Gamma Aurora Invictus', NULL, 407, NULL, NULL, 1, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (113, '0x6013ad1e49066dc25bb8a82e2eb467add62265f9', 1, 6, 5, 1695195732108, false, 'Phantom Orbit Juggernaut', NULL, NULL, 488, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (124, '0x5ec37ef774357717d06c53870c5bacac7d63fa07', 1, 1, 55, NULL, false, 'Ultra Aurora Pioneer', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (100, '0x0581da444a46693496968d6611b15065fcf42140', 1, 2, 1, NULL, false, 'Radiant Sigma Odyssey', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (119, '0xfd80f0c6e080599dafd2a3d0160f60f9c8868f9d', 1, 48, 40, 1695737416921, false, 'Meteor Exodus Navigator', NULL, 421, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (130, '0xcbacf618fb3dcbe9a9000143be58eb01235efe9f', 2, 11, 88, NULL, false, 'Pulsar Xenith Phantom', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (139, '0x2bf136e8ccb32e9a213a4ae6778d703cf55b5889', 1, 45, 54, NULL, false, 'Omni Terminus Zenith', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (110, '0x0efdcf9840fe91e3925e386d3633debed4369c27', 1, 29, 50, NULL, false, 'Stellar Horizon Seeker', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (117, '0x536ee857fcffe9e0b33d5cb17b69264588728a78', 1, 55, 62, 1695298277192, false, 'Ion Aurora Freighter', NULL, NULL, 463, NULL, 1, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (129, '0xaff85fbaefefb64fa0a535de424117a0a9d35b74', 1, 29, 37, NULL, false, 'Pulsar Journey Zenith', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (108, '0x7cebae9a7fadf20087b6ac67cdb5d2c4e89fa667', 1, 51, 19, 1696293261881, false, 'Hyper Lumen Invictus', 334, NULL, NULL, NULL, 3, 1);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (121, '0x27534ee6a1d10afae2cef0a68f17623d060f01c7', 1, 65, 65, NULL, false, 'Gamma Exodus Wanderer', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (131, '0x0fbebbcff5d4b0d8f6e440507350c7bb72bcd02e', 1, 7, 10, NULL, false, 'Nebula Lumen Marauder', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (104, '0x09a5e9ffe158e81e677ff5b7ac7a966780ff2427', 2, 48, 93, 1695597432977, false, 'Echo Horizon Invictus', NULL, NULL, 402, NULL, 1, 2);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (125, '0xabaf086c29e5ace29ba1fc79f0220c2f92385984', 1, 44, 95, 1695290955729, false, 'Cypher Terminus Guardian', 362, NULL, NULL, NULL, 0, 1);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (106, '0x8812f12bf1b651b4c8231e033efc93b2cb8891fd', 1, 39, 5, 1695313783057, false, 'Astro Terminus Nomad', NULL, NULL, 290, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (115, '0x514d58823c12ec695ef378d4cb3013faa147105c', 1, 1, 5, NULL, false, 'Gamma Sigma Zenith', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (138, '0x85799ff1c86f89fe9fb07773d1d240763b6039ce', 1, 1, 49, 1695303923263, false, 'Ion Sigma Phantom', NULL, NULL, 582, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (132, '0x51a4545bf235564f263fd165728c06c0c0296413', 1, 42, 70, NULL, false, 'Lunar Drift Raider', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (140, '0x80595a71b57636856b61e51a939aa511a5d4008d', 1, 31, 34, NULL, false, 'Ultra Beacon Voyager', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (116, '0x8cd78a617bffcfba5daf0c01b6af522590952fce', 1, 64, 74, NULL, false, 'Astro Nebula Adventurer', NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (114, '0xed66e493e956849ff67b3e546f8daf3d68ec380e', 1, 25, 48, 1695886937179, false, 'Phantom Cosmos Adventurer', 304, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (111, '0x6eeca55c7cad1b1c1c3f872e1b5659f520c19a1f', 1, 9, 75, NULL, false, 'Nova Zone Drifter', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (127, '0xcf61d8fc50f84767ca932945d167fd613f5da53a', 2, 26, 14, NULL, false, 'Zephyr Zone Voyager', NULL, NULL, NULL, NULL, 1, 1);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (102, '0x6b3a4bd72e25d26160e698d6e826c2ecbadef9c8', 1, 27, 65, NULL, false, 'Holo Pulsar Raider', NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (126, '0x9210cbb688eb68d0c0dec88da9d7ee8a6b8b4dec', 1, 46, 50, 1695859401865, false, 'Ethereal Quasar Odyssey', 356, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (135, '0xca19d045317224c3bb84af1a403f70bd3589ef56', 4, 2, 77, 1696343070171, false, 'Nova Nebula Nomad', NULL, NULL, 573, NULL, 5, 6);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (143, '0x0f617402b5954a8118ce951fbbddaf1a4ac16310', 1, 2, 37, 1695565797996, false, 'Temporal Terminus Invictus', 322, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (142, '0xa65660a7c3c4408fe1ef6a33dfc3b1d312263b1b', 1, 7, 19, NULL, false, 'Holo Cosmos Enigma', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (134, '0x8c6b1d93b59db869fd232a0e7ca38bcc696914c9', 2, 98, 99, 1695466070720, false, 'Gamma Vector Navigator', NULL, 392, NULL, NULL, 2, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (152, '0x1bc65b00eabd7af0eb41f8d6d9934783391afea3', 1, 3, 7, NULL, false, 'Zephyr Kinetic Mariner', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (150, '0x8d0b928e34d0c2ea626fd84e79d6b221feab5030', 1, 50, 66, 1695417315613, false, 'Holo Stardust Juggernaut', NULL, NULL, 598, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (157, '0xc339adc4352e66ac2d6bc14097d24b83dee5c01c', 1, 5, 98, NULL, false, 'Hyper Vortex Guardian', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (148, '0x34cd39508ecaa638538e5a1b1be00ea3b7b5f2d6', 1, 100, 100, NULL, false, 'Echo Pulsar Phantom', NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (147, '0xde848f5949206a9e66e1800e2c5a69d2601fbc22', 1, 62, 32, NULL, false, 'Ion Velocity Traveller', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (153, '0x62c85407bfa12cf5350dc6ac5cf1fdf3f45cc15f', 1, NULL, NULL, NULL, false, 'Omega Beacon Adventurer', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (160, '0x5ee6e7174e759092a9e2408a3c73078ae5fb9c87', 1, 79, 84, 1696097382598, false, 'Ethereal Vortex Voyager', NULL, NULL, 525, NULL, 3, 3);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (145, '0x16ecc0d028190ce0b74d52b450c4e00a19145885', 1, 53, 62, NULL, false, 'Omega Cosmos Zenith', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (172, '0x7d233827ec2949f79894ff9b37e35ff51216d080', 1, 2, 14, NULL, false, 'Quantum Infinity Voyager', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (164, '0x8c9ce89b2db559276ae9d7cbc473ca90e65b36b7', 1, 1, 49, NULL, false, 'Stellar Comet Pulsar', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (174, '0x6a74ce0ccc415d439f3c908e0817bb69c6d9046e', 1, 8, 5, NULL, false, 'Nebula Quasar Marauder', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (165, '0x4dc809d195167bb0e4e0405d3072d4595b443acb', 1, 1, 46, NULL, false, 'Omni Drift Guardian', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (163, '0x740f995effa4e423b42f491a3e772ae82227224d', 1, 1, 55, NULL, false, 'Warp Vortex Crusader', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (158, '0x93bf79e6a9944e1aa6c843680066dbcaab226f17', 1, 1, 1, NULL, false, 'Echo Nova Drifter', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (169, '0xb600df397c596b0baad105c85374c1863226eff2', 2, 50, 47, 1696369295093, false, 'Meteor Quasar Zenith', 268, NULL, NULL, NULL, 4, 2);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (155, '0x491ffc953e1ab2751817ff90a5f32694a4841474', 1, 53, 57, 1695695623498, false, 'Echo Warp Invictus', NULL, 379, NULL, NULL, 2, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (146, '0xe1c2fe8ee6d476debfa59e7e0b055cdee246fdef', 1, 46, 49, NULL, false, 'Nebula Vector Pulsar', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (168, '0xbcd663e4856def593d86eca8898006d0eef03016', 2, 71, 99, 1696171546288, false, 'Quantum Stardust Guardian', NULL, 447, NULL, NULL, 1, 1);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (167, '0x7c719c3c98f416bb5fab3c00c09e518e5eb5c1b7', 1, 35, 70, NULL, false, 'Omni Drift Traveller', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (149, '0x9c854bf81c81cb5038ff3dd702e9e552f20fe1b5', 1, 2, 3, NULL, false, 'Lunar Xenith Explorer', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (171, '0x5a6e9f05910e58c4fc2f8a0a766f576cafd49765', 3, 58, 73, NULL, false, 'Ion Pulsar Drifter', NULL, NULL, NULL, NULL, 2, 2);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (161, '0x8a9865785dbbd747fd67536112daf3ee161bc287', 1, 35, 32, NULL, false, 'Ion Xenith Guardian', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (162, '0xdfdcc1a06b5d833c89197b8c216ac497d67ca5d9', 1, 1, 64, NULL, false, 'Nova Comet Zenith', NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (1, '0x6f61d896a9b9e1087065e1630be44f394786f3d1', 1, 75, 80, 1696274653630, false, 'Phantom Nova Juggernaut', NULL, NULL, 494, NULL, 1, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (159, '0x1d0e5f3459e16dd67bb3a985aca0f1e92d72fe09', 3, 84, 88, 1695987759499, false, 'Radiant Quasar Juggernaut', NULL, 636, NULL, NULL, 3, 3);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (166, '0x3ceec57a1f2be530c970f5dbd675d23d0ff3adfa', 1, 2, 76, NULL, false, 'Gamma Zone Mariner', NULL, NULL, NULL, NULL, 0, 1);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (74, '0x43766a37ef46c17f493803f6d190b1f7d0ac2e7a', 3, 48, 88, NULL, false, 'Meteor Vector Harbinger', NULL, NULL, NULL, NULL, 2, 2);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (173, '0xa3eedbe55d34899d8957470a20c35243a951cec6', 1, 12, 20, NULL, false, 'Omega Quasar Guardian', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (170, '0xa209a754da05c44e23d656a2bef3f6614d1cbeab', 1, 1, 61, NULL, false, 'Ion Infinity Pathfinder', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (12, '0x0145582cb27bd79163462029a81bbb0b56a3991e', 3, 24, 29, 1696353919311, false, 'Ion Pulsar Raider', NULL, 705, NULL, NULL, 5, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (65, '0xc37f000de73a3032eeaa4fa4cbf4db8ec527552f', 1, 60, 100, NULL, false, 'Omni Terminus Raider', NULL, NULL, NULL, NULL, 4, 1);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (156, '0x34fab622936f58a77f18ea21cd4d3386afa68449', 1, 4, 95, NULL, false, 'Solar Quasar Mariner', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (154, '0x4b22a3c99bcc08d2ea14a5fb6a4d09777a65e6ff', 3, 63, 7, NULL, false, 'Ion Beacon Explorer', NULL, NULL, NULL, NULL, 5, 4);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (137, '0xf8c01c7bdfbb7d2add39ed08368217d605d31f2f', 2, 31, 82, 1696378365992, false, 'Zenith Aurora Traveller', 331, NULL, NULL, NULL, 1, 1);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (151, '0x3edb1be154d8c8fc4818fa7695da7620ecd5ef91', 1, 22, 11, NULL, false, 'Void Pulsar Pulsar', NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (41, '0x25341068524e657dd9434b6cf3738d27da87d66c', 6, 11, 33, NULL, false, 'Penta Xenith Drifter', NULL, NULL, NULL, NULL, 5, 6);
INSERT INTO public.vessel (id, owner_address, range, x, y, mining_end_time, is_locked, name, pending_astralite, pending_samarium, pending_calamarite, model, speed, radar) VALUES (8, '0x319b916a699865618121b99e66e34b1cc597ec32', 6, 11, 35, NULL, false, 'Nebula Nova Navigator', NULL, NULL, NULL, NULL, 5, 6);


--
-- TOC entry 3591 (class 0 OID 0)
-- Dependencies: 218
-- Name: chunk_constraint_name; Type: SEQUENCE SET; Schema: _timescaledb_catalog; Owner: postgres
--

SELECT pg_catalog.setval('_timescaledb_catalog.chunk_constraint_name', 1, false);


--
-- TOC entry 3592 (class 0 OID 0)
-- Dependencies: 215
-- Name: chunk_id_seq; Type: SEQUENCE SET; Schema: _timescaledb_catalog; Owner: postgres
--

SELECT pg_catalog.setval('_timescaledb_catalog.chunk_id_seq', 1, false);


--
-- TOC entry 3593 (class 0 OID 0)
-- Dependencies: 211
-- Name: dimension_id_seq; Type: SEQUENCE SET; Schema: _timescaledb_catalog; Owner: postgres
--

SELECT pg_catalog.setval('_timescaledb_catalog.dimension_id_seq', 1, false);


--
-- TOC entry 3594 (class 0 OID 0)
-- Dependencies: 213
-- Name: dimension_slice_id_seq; Type: SEQUENCE SET; Schema: _timescaledb_catalog; Owner: postgres
--

SELECT pg_catalog.setval('_timescaledb_catalog.dimension_slice_id_seq', 1, false);


--
-- TOC entry 3595 (class 0 OID 0)
-- Dependencies: 206
-- Name: hypertable_id_seq; Type: SEQUENCE SET; Schema: _timescaledb_catalog; Owner: postgres
--

SELECT pg_catalog.setval('_timescaledb_catalog.hypertable_id_seq', 1, false);


--
-- TOC entry 3596 (class 0 OID 0)
-- Dependencies: 221
-- Name: bgw_job_id_seq; Type: SEQUENCE SET; Schema: _timescaledb_config; Owner: postgres
--

SELECT pg_catalog.setval('_timescaledb_config.bgw_job_id_seq', 1000, false);


--
-- TOC entry 3597 (class 0 OID 0)
-- Dependencies: 253
-- Name: exhausted_tile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.exhausted_tile_id_seq', 86949, true);


--
-- TOC entry 3598 (class 0 OID 0)
-- Dependencies: 247
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 28, true);


--
-- TOC entry 3599 (class 0 OID 0)
-- Dependencies: 255
-- Name: random_seed_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.random_seed_id_seq', 1, true);


--
-- TOC entry 3416 (class 2606 OID 18017)
-- Name: manta_stats PK_2d6d1695de0085961a05e56d32a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manta_stats
    ADD CONSTRAINT "PK_2d6d1695de0085961a05e56d32a" PRIMARY KEY (address);


--
-- TOC entry 3422 (class 2606 OID 19753)
-- Name: update PK_5991fe3985c2f96f8f40ae5ac05; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.update
    ADD CONSTRAINT "PK_5991fe3985c2f96f8f40ae5ac05" PRIMARY KEY (version);


--
-- TOC entry 3408 (class 2606 OID 17508)
-- Name: vessel PK_87cc5d99bd07c65028ddcc9c785; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vessel
    ADD CONSTRAINT "PK_87cc5d99bd07c65028ddcc9c785" PRIMARY KEY (id);


--
-- TOC entry 3402 (class 2606 OID 17483)
-- Name: migrations PK_8c82d7f526340ab734260ea46be; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT "PK_8c82d7f526340ab734260ea46be" PRIMARY KEY (id);


--
-- TOC entry 3418 (class 2606 OID 18311)
-- Name: base_stats PK_8da530bfb8995249c91002c5f57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.base_stats
    ADD CONSTRAINT "PK_8da530bfb8995249c91002c5f57" PRIMARY KEY (address);


--
-- TOC entry 3404 (class 2606 OID 17491)
-- Name: users PK_951b8f1dfc94ac1d0301a14b7e1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "PK_951b8f1dfc94ac1d0301a14b7e1" PRIMARY KEY (uuid);


--
-- TOC entry 3424 (class 2606 OID 20112)
-- Name: login_tracker PK_9da3ab196b59ed146f0cfdc89f9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login_tracker
    ADD CONSTRAINT "PK_9da3ab196b59ed146f0cfdc89f9" PRIMARY KEY (date);


--
-- TOC entry 3410 (class 2606 OID 17516)
-- Name: manta_resource PK_b219fc58b7b50c8cda32e82e207; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manta_resource
    ADD CONSTRAINT "PK_b219fc58b7b50c8cda32e82e207" PRIMARY KEY (owner_address);


--
-- TOC entry 3412 (class 2606 OID 17527)
-- Name: exhausted_tile PK_c842e0f6cfe5acc6f400a5cb0e3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exhausted_tile
    ADD CONSTRAINT "PK_c842e0f6cfe5acc6f400a5cb0e3" PRIMARY KEY (id);


--
-- TOC entry 3406 (class 2606 OID 17499)
-- Name: blockchain PK_d89e2e25ee7d2d400e54ab98a13; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blockchain
    ADD CONSTRAINT "PK_d89e2e25ee7d2d400e54ab98a13" PRIMARY KEY (name);


--
-- TOC entry 3420 (class 2606 OID 18335)
-- Name: base_resource PK_eb6812f300126f6b94475efbb93; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.base_resource
    ADD CONSTRAINT "PK_eb6812f300126f6b94475efbb93" PRIMARY KEY (owner_address);


--
-- TOC entry 3414 (class 2606 OID 17535)
-- Name: random_seed PK_f41c4792d91b996496398b9d25d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.random_seed
    ADD CONSTRAINT "PK_f41c4792d91b996496398b9d25d" PRIMARY KEY (id);


--
-- TOC entry 3586 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2023-10-03 19:34:13 EST

--
-- PostgreSQL database dump complete
--


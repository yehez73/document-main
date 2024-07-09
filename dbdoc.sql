--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

-- Started on 2024-07-09 09:12:04

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
-- TOC entry 860 (class 1247 OID 17167)
-- Name: role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.role AS ENUM (
    'Pemohon',
    'Atasan Pemohon',
    'Penerima',
    'Atasan Penerima',
    'Disusun oleh',
    'Disahkan oleh',
    'Direview oleh',
    'Diketahui oleh'
);


ALTER TYPE public.role OWNER TO postgres;

--
-- TOC entry 854 (class 1247 OID 17141)
-- Name: status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.status AS ENUM (
    'Draft',
    'Published'
);


ALTER TYPE public.status OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17128)
-- Name: document_order_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.document_order_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.document_order_seq OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 223 (class 1259 OID 17213)
-- Name: document_ms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.document_ms (
    document_id bigint NOT NULL,
    document_uuid character varying(128) NOT NULL,
    document_order integer DEFAULT nextval('public.document_order_seq'::regclass),
    document_code character varying(20) NOT NULL,
    document_name character varying(100) NOT NULL,
    document_format_number character varying(100),
    created_by character varying(100) NOT NULL,
    created_at timestamp(0) without time zone DEFAULT now() NOT NULL,
    updated_by character varying(100) DEFAULT ''::character varying,
    updated_at timestamp(0) without time zone,
    deleted_by character varying(100) DEFAULT ''::character varying,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.document_ms OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 17145)
-- Name: form_ms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.form_ms (
    form_id bigint NOT NULL,
    form_uuid character varying(128) NOT NULL,
    document_id bigint NOT NULL,
    user_id bigint NOT NULL,
    project_id bigint,
    form_number character varying(100) NOT NULL,
    form_ticket character varying(100) NOT NULL,
    form_status public.status NOT NULL,
    form_data json NOT NULL,
    is_approve boolean,
    reason character varying(128) DEFAULT NULL::character varying,
    created_by character varying(100) NOT NULL,
    created_at timestamp(0) without time zone DEFAULT now() NOT NULL,
    updated_by character varying(100) DEFAULT ''::character varying,
    updated_at timestamp(0) without time zone,
    deleted_by character varying(100) DEFAULT ''::character varying,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.form_ms OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 17199)
-- Name: hak_akses_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hak_akses_info (
    form_id bigint NOT NULL,
    info_uuid character varying(128) NOT NULL,
    host character varying(128),
    name character varying(128) NOT NULL,
    instansi character varying(128) NOT NULL,
    "position" character varying(128) NOT NULL,
    username character varying(128) NOT NULL,
    password character varying(128) NOT NULL,
    scope character varying(128) NOT NULL,
    type character varying(128),
    matched boolean,
    description text,
    created_by character varying(100) NOT NULL,
    created_at timestamp(0) without time zone DEFAULT now() NOT NULL,
    updated_by character varying(100) DEFAULT ''::character varying,
    updated_at timestamp(0) without time zone,
    deleted_by character varying(100) DEFAULT ''::character varying,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.hak_akses_info OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 17099)
-- Name: product_order_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_order_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_order_seq OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 17100)
-- Name: product_ms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_ms (
    product_id bigint NOT NULL,
    product_uuid character varying(128) NOT NULL,
    product_order integer DEFAULT nextval('public.product_order_seq'::regclass),
    product_name character varying(128) NOT NULL,
    product_owner character varying(128) NOT NULL,
    created_by character varying(100) NOT NULL,
    created_at timestamp(0) without time zone DEFAULT now() NOT NULL,
    updated_by character varying(100) DEFAULT ''::character varying,
    updated_at timestamp(0) without time zone,
    deleted_by character varying(100) DEFAULT ''::character varying,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.product_ms OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 17111)
-- Name: project_order_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.project_order_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_order_seq OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 17112)
-- Name: project_ms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.project_ms (
    project_id bigint NOT NULL,
    project_uuid character varying(128) NOT NULL,
    product_id bigint NOT NULL,
    project_order integer DEFAULT nextval('public.project_order_seq'::regclass),
    project_name character varying(128) NOT NULL,
    project_code character varying(20) NOT NULL,
    project_manager character varying(128) NOT NULL,
    created_by character varying(100) NOT NULL,
    created_at timestamp(0) without time zone DEFAULT now() NOT NULL,
    updated_by character varying(100) DEFAULT ''::character varying,
    updated_at timestamp(0) without time zone,
    deleted_by character varying(100) DEFAULT ''::character varying,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.project_ms OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17175)
-- Name: sign_form; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sign_form (
    user_id bigint NOT NULL,
    sign_uuid character varying(128) NOT NULL,
    form_id bigint NOT NULL,
    name character varying(128) NOT NULL,
    "position" character varying(128) NOT NULL,
    role_sign public.role NOT NULL,
    is_sign boolean DEFAULT false,
    created_by character varying(100) NOT NULL,
    created_at timestamp(0) without time zone DEFAULT now() NOT NULL,
    updated_by character varying(100) DEFAULT ''::character varying,
    updated_at timestamp(0) without time zone,
    deleted_by character varying(100) DEFAULT ''::character varying,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.sign_form OWNER TO postgres;

--
-- TOC entry 4905 (class 0 OID 17213)
-- Dependencies: 223
-- Data for Name: document_ms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.document_ms (document_id, document_uuid, document_order, document_code, document_name, document_format_number, created_by, created_at, updated_by, updated_at, deleted_by, deleted_at) FROM stdin;
1707109904824217	48748d46-77ed-4115-994a-c7287bfca6f0	1	BA	Dampak Analisa	DA/XII/2023/12/DA	super admin	2024-07-08 13:41:52		\N		\N
\.


--
-- TOC entry 4902 (class 0 OID 17145)
-- Dependencies: 220
-- Data for Name: form_ms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.form_ms (form_id, form_uuid, document_id, user_id, project_id, form_number, form_ticket, form_status, form_data, is_approve, reason, created_by, created_at, updated_by, updated_at, deleted_by, deleted_at) FROM stdin;
1	769598a3-fa83-471c-81d5-555e6bb82b71	1707109904824217	1760000	1	213125	1	Draft	{}	\N	\N	SUPER ADMIN	2024-07-08 13:53:21		\N		\N
\.


--
-- TOC entry 4904 (class 0 OID 17199)
-- Dependencies: 222
-- Data for Name: hak_akses_info; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hak_akses_info (form_id, info_uuid, host, name, instansi, "position", username, password, scope, type, matched, description, created_by, created_at, updated_by, updated_at, deleted_by, deleted_at) FROM stdin;
1	beb020d1-a74a-4cba-a9ef-83d9b6680079	\N	Nathan	AINO	Intern	nathan	123	idk	\N	\N	\N	Super Admin	2024-07-08 13:56:10		\N		\N
\.


--
-- TOC entry 4898 (class 0 OID 17100)
-- Dependencies: 216
-- Data for Name: product_ms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_ms (product_id, product_uuid, product_order, product_name, product_owner, created_by, created_at, updated_by, updated_at, deleted_by, deleted_at) FROM stdin;
1	79bceb29-b678-4319-9510-2667ac5af6eb	2	hape	jov	Super Admin	2024-07-08 13:32:41		\N		\N
\.


--
-- TOC entry 4900 (class 0 OID 17112)
-- Dependencies: 218
-- Data for Name: project_ms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.project_ms (project_id, project_uuid, product_id, project_order, project_name, project_code, project_manager, created_by, created_at, updated_by, updated_at, deleted_by, deleted_at) FROM stdin;
1	61977fb4-44e5-4083-9300-3f0e06ac3e5c	1	2	goleng	55582	syaiful	Super Admin	2024-07-08 13:33:31		\N		\N
\.


--
-- TOC entry 4903 (class 0 OID 17175)
-- Dependencies: 221
-- Data for Name: sign_form; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sign_form (user_id, sign_uuid, form_id, name, "position", role_sign, is_sign, created_by, created_at, updated_by, updated_at, deleted_by, deleted_at) FROM stdin;
1	a7fe79b5-05d6-452a-9596-bfa6a34ba290	1	yehez	Head	Pemohon	f	Super Admin	2024-07-08 13:55:10		\N		\N
2	84cefc65-7f88-465f-b263-11e6d72e32d8	1	james	Head	Atasan Penerima	f	Super Admin	2024-07-08 14:06:10		\N		\N
\.


--
-- TOC entry 4911 (class 0 OID 0)
-- Dependencies: 219
-- Name: document_order_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.document_order_seq', 1, true);


--
-- TOC entry 4912 (class 0 OID 0)
-- Dependencies: 215
-- Name: product_order_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_order_seq', 2, true);


--
-- TOC entry 4913 (class 0 OID 0)
-- Dependencies: 217
-- Name: project_order_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.project_order_seq', 2, true);


--
-- TOC entry 4748 (class 2606 OID 17223)
-- Name: document_ms document_ms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_ms
    ADD CONSTRAINT document_ms_pkey PRIMARY KEY (document_id);


--
-- TOC entry 4744 (class 2606 OID 17155)
-- Name: form_ms form_ms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.form_ms
    ADD CONSTRAINT form_ms_pkey PRIMARY KEY (form_id);


--
-- TOC entry 4740 (class 2606 OID 17110)
-- Name: product_ms product_ms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_ms
    ADD CONSTRAINT product_ms_pkey PRIMARY KEY (product_id);


--
-- TOC entry 4742 (class 2606 OID 17122)
-- Name: project_ms project_ms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_ms
    ADD CONSTRAINT project_ms_pkey PRIMARY KEY (project_id);


--
-- TOC entry 4746 (class 2606 OID 17185)
-- Name: sign_form sign_form_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sign_form
    ADD CONSTRAINT sign_form_pkey PRIMARY KEY (user_id, sign_uuid);


--
-- TOC entry 4750 (class 2606 OID 17224)
-- Name: form_ms fk_form_ms_document_ms; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.form_ms
    ADD CONSTRAINT fk_form_ms_document_ms FOREIGN KEY (document_id) REFERENCES public.document_ms(document_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4751 (class 2606 OID 17229)
-- Name: form_ms fk_form_ms_project_ms; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.form_ms
    ADD CONSTRAINT fk_form_ms_project_ms FOREIGN KEY (project_id) REFERENCES public.project_ms(project_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4753 (class 2606 OID 17207)
-- Name: hak_akses_info hak_akses_info_form_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hak_akses_info
    ADD CONSTRAINT hak_akses_info_form_id_fkey FOREIGN KEY (form_id) REFERENCES public.form_ms(form_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4749 (class 2606 OID 17123)
-- Name: project_ms project_ms_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_ms
    ADD CONSTRAINT project_ms_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product_ms(product_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4752 (class 2606 OID 17186)
-- Name: sign_form sign_form_form_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sign_form
    ADD CONSTRAINT sign_form_form_id_fkey FOREIGN KEY (form_id) REFERENCES public.form_ms(form_id) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2024-07-09 09:12:04

--
-- PostgreSQL database dump complete
--


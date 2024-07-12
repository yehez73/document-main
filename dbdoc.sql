--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

-- Started on 2024-07-12 13:10:26

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
1720496554354683	7d80c588-485e-44f0-9c7b-4edff97a145a	2	DA	Dampak Analisa	\N	admin	2024-07-09 10:12:21		\N		\N
1720587983707224	f24b02a6-352e-4d9a-a318-976649895110	3	ITCM	IT Change Management	\N	Super Admin	2024-07-10 11:27:13		\N		\N
1720589493563055	add2f73b-693a-4367-8252-9b4ac819639a	4	BA	Berita Acara ITCM	\N	Super Admin	2024-07-10 11:28:01		\N		\N
\.


--
-- TOC entry 4902 (class 0 OID 17145)
-- Dependencies: 220
-- Data for Name: form_ms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.form_ms (form_id, form_uuid, document_id, user_id, project_id, form_number, form_ticket, form_status, form_data, is_approve, reason, created_by, created_at, updated_by, updated_at, deleted_by, deleted_at) FROM stdin;
1720602202487573	ec6b732f-eb71-4552-a595-4cc7bff38376	1720496554354683	1720513615963810	1720586586327302	0001/PED/F/VII/2024	2131978	Draft	{"nama_analis":"Nathan","jabatan":"Head","departemen":"AINO","jenis_perubahan":"PT","detail_dampak_perubahan":"mantap","rencana_pengembangan_perubahan":"","rencana_pengujian_perubahan_sistem":"mantap","rencana_rilis_perubahan_dan_implementasi":"2024-07-10"}	\N	\N	nathan	2024-07-10 15:42:37		\N		\N
1720606081265552	4414a8f3-3eaa-433e-be3b-e56854e02c36	1720496554354683	1720513615963810	1720586586327302	0002/PED/F/VII/2024	3408394	Draft	{"nama_analis":"anals 1","jabatan":"jabtn 1","departemen":"dprtmn 1","jenis_perubahan":"oi","detail_dampak_perubahan":"oh","rencana_pengembangan_perubahan":"","rencana_pengujian_perubahan_sistem":"kn","rencana_rilis_perubahan_dan_implementasi":"2024-07-10"}	\N	\N	nathan	2024-07-10 16:01:20		\N		\N
1720604291860695	7702fe75-09c6-48b1-9cf8-f6ba038ba7cb	1720589493563055	1720513615963810	1720586586327302	0001/HC/BA/VII/2024	92734	Draft	{"judul":"RUSt","tanggal":"2024-07-10","nama_aplikasi":"kdl","no_da":"P9809","no_itcm":"90790","dilakukan_oleh":"kdhf","didampingi_oleh":"sdofj"}	\N	\N	nathan	2024-07-10 16:03:02		\N		\N
1720605202594863	054cd13a-8e8e-45df-a3d6-5a493e8c7238	1720496554354683	1720513615963810	1720586586327302	0003/PED/F/VII/2024	90234	Draft	{"nama_analis":"Analis 1","jabatan":"Jabatan 1","departemen":"Departemen 1","jenis_perubahan":"none","detail_dampak_perubahan":"none","rencana_pengembangan_perubahan":"","rencana_pengujian_perubahan_sistem":"none","rencana_rilis_perubahan_dan_implementasi":"2024-07-10"}	\N	\N	nathan	2024-07-10 16:07:09		\N		\N
1720606548079909	91adb1d0-d752-413f-b0e7-64610f03efe7	1720589493563055	1720513615963810	1720587620504971	0002/HC/BA/VII/2024	92130	Draft	{"judul":"Zig","tanggal":"2024-07-10","nama_aplikasi":"ZIG","no_da":"I0980","no_itcm":")0890U","dilakukan_oleh":"Rasyid","didampingi_oleh":"Syaiful"}	\N	\N	nathan	2024-07-10 16:15:08		\N		\N
1720603573686170	999d4de9-a27d-4d18-8f8c-116be3f500cb	1720587983707224	1720513615963810	1720586680480488	0001/F/ITCM/VII/2024	920341	Draft	{"no_da":"O09890","nama_pemohon":"Rasyid","instansi":"Instansi 1","tanggal":"2024-07-10","perubahan_aset":"none","deskripsi":"ok"}	\N	\N	nathan	2024-07-10 16:16:24		\N		\N
1720606589866450	d22ebb4a-642b-4acc-9f80-edb68ba559a9	1720587983707224	1720513615963810	1720586586327302	0002/F/ITCM/VII/2024	4555365	Draft	{"no_da":"970","nama_pemohon":"zain","instansi":"inztansi 1","tanggal":"2024-07-10","perubahan_aset":"oke","deskripsi":"ok"}	\N	\N	nathan	2024-07-10 16:18:35		\N		\N
1720603993763910	3441a138-ea0b-4ff8-a058-be575c8dd216	1720587983707224	1720513615963810	1	0003/F/ITCM/VII/2024	1313	Draft	{"no_da":"rr","nama_pemohon":"eee","instansi":"fcef","tanggal":"2024-07-10","perubahan_aset":"berubah","deskripsi":"wsw"}	\N	\N	nathan	2024-07-10 16:20:05		\N		\N
\.


--
-- TOC entry 4904 (class 0 OID 17199)
-- Dependencies: 222
-- Data for Name: hak_akses_info; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hak_akses_info (form_id, info_uuid, host, name, instansi, "position", username, password, scope, type, matched, description, created_by, created_at, updated_by, updated_at, deleted_by, deleted_at) FROM stdin;
\.


--
-- TOC entry 4898 (class 0 OID 17100)
-- Dependencies: 216
-- Data for Name: product_ms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_ms (product_id, product_uuid, product_order, product_name, product_owner, created_by, created_at, updated_by, updated_at, deleted_by, deleted_at) FROM stdin;
1	79bceb29-b678-4319-9510-2667ac5af6eb	2	hape	jov	Super Admin	2024-07-08 13:32:41		\N		\N
1720503233024014	adcc651e-3045-47cd-b6d3-e0442175114c	3	Aplikasi	zain	admin	2024-07-09 11:33:04		\N		\N
\.


--
-- TOC entry 4900 (class 0 OID 17112)
-- Dependencies: 218
-- Data for Name: project_ms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.project_ms (project_id, project_uuid, product_id, project_order, project_name, project_code, project_manager, created_by, created_at, updated_by, updated_at, deleted_by, deleted_at) FROM stdin;
1	61977fb4-44e5-4083-9300-3f0e06ac3e5c	1	2	goleng	55582	syaiful	Super Admin	2024-07-08 13:33:31		\N		\N
1720586680480488	1a523788-c3e1-43c5-a34f-973fdd405a9b	1720503233024014	5	.NET Server	nste28	Nathan	Admin	2024-07-10 10:58:48		\N		\N
1720586586327302	c9bdc8f9-a97a-42b8-a87c-991077516465	1	3		JU791-2	Rasyid	Admin	2024-07-10 10:55:07	Super Admin	2024-07-10 16:22:47		\N
1720587620504971	fca9c576-db0f-4313-aad0-0314306d5c20	1720503233024014	4		792u1j	Zain	Admin	2024-07-10 10:57:28	Super Admin	2024-07-10 16:23:21		\N
\.


--
-- TOC entry 4903 (class 0 OID 17175)
-- Dependencies: 221
-- Data for Name: sign_form; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sign_form (user_id, sign_uuid, form_id, name, "position", role_sign, is_sign, created_by, created_at, updated_by, updated_at, deleted_by, deleted_at) FROM stdin;
\.


--
-- TOC entry 4911 (class 0 OID 0)
-- Dependencies: 219
-- Name: document_order_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.document_order_seq', 4, true);


--
-- TOC entry 4912 (class 0 OID 0)
-- Dependencies: 215
-- Name: product_order_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_order_seq', 3, true);


--
-- TOC entry 4913 (class 0 OID 0)
-- Dependencies: 217
-- Name: project_order_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.project_order_seq', 5, true);


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


-- Completed on 2024-07-12 13:10:26

--
-- PostgreSQL database dump complete
--


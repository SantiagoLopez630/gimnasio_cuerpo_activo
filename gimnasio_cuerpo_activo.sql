--
-- PostgreSQL database dump
--

\restrict Ad1kUL2BFE9d54M3MraBQUrfw0nFXz2fhf27h4LvEfN2NRDQqZdPMO5tiy0VYm1

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

-- Started on 2026-11-19 23:31:18

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- TOC entry 228 (class 1259 OID 16752)
-- Name: clase_grupal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clase_grupal (
    id_clase integer NOT NULL,
    id_entrenador integer NOT NULL,
    nombre character varying(50) NOT NULL,
    dia_semana character varying(20) NOT NULL,
    hora time without time zone NOT NULL,
    cupo integer NOT NULL,
    estado character varying(15) DEFAULT 'activa'::character varying NOT NULL,
    CONSTRAINT chk_estado_clase CHECK (((estado)::text = ANY ((ARRAY['activa'::character varying, 'suspendida'::character varying])::text[]))),
    CONSTRAINT clase_grupal_cupo_check CHECK ((cupo > 0))
);


ALTER TABLE public.clase_grupal OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16751)
-- Name: clase_grupal_id_clase_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clase_grupal_id_clase_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.clase_grupal_id_clase_seq OWNER TO postgres;

--
-- TOC entry 5106 (class 0 OID 0)
-- Dependencies: 227
-- Name: clase_grupal_id_clase_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clase_grupal_id_clase_seq OWNED BY public.clase_grupal.id_clase;


--
-- TOC entry 226 (class 1259 OID 16739)
-- Name: entrenador; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.entrenador (
    id_entrenador integer NOT NULL,
    nombre character varying(100) NOT NULL,
    especialidad character varying(100) NOT NULL,
    correo character varying(100) NOT NULL
);


ALTER TABLE public.entrenador OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16738)
-- Name: entrenador_id_entrenador_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.entrenador_id_entrenador_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.entrenador_id_entrenador_seq OWNER TO postgres;

--
-- TOC entry 5107 (class 0 OID 0)
-- Dependencies: 225
-- Name: entrenador_id_entrenador_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.entrenador_id_entrenador_seq OWNED BY public.entrenador.id_entrenador;


--
-- TOC entry 220 (class 1259 OID 16683)
-- Name: ficha_medica; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ficha_medica (
    numero_documento_socio character varying(20) NOT NULL,
    peso numeric(5,2) NOT NULL,
    estatura numeric(4,2) NOT NULL,
    lesiones text,
    CONSTRAINT ficha_medica_estatura_check CHECK ((estatura > (0)::numeric)),
    CONSTRAINT ficha_medica_peso_check CHECK ((peso > (0)::numeric))
);


ALTER TABLE public.ficha_medica OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16771)
-- Name: inscripcion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inscripcion (
    id_inscripcion integer NOT NULL,
    numero_documento_socio character varying(20) NOT NULL,
    id_clase integer NOT NULL,
    fecha_inscripcion date DEFAULT CURRENT_DATE NOT NULL
);


ALTER TABLE public.inscripcion OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16770)
-- Name: inscripcion_id_inscripcion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inscripcion_id_inscripcion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.inscripcion_id_inscripcion_seq OWNER TO postgres;

--
-- TOC entry 5108 (class 0 OID 0)
-- Dependencies: 229
-- Name: inscripcion_id_inscripcion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inscripcion_id_inscripcion_seq OWNED BY public.inscripcion.id_inscripcion;


--
-- TOC entry 224 (class 1259 OID 16716)
-- Name: membresia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.membresia (
    id_membresia integer NOT NULL,
    numero_documento_socio character varying(20) NOT NULL,
    id_plan integer NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_fin date NOT NULL,
    valor_pagado numeric(10,2) NOT NULL,
    CONSTRAINT membresia_check CHECK ((fecha_fin >= fecha_inicio)),
    CONSTRAINT membresia_fecha_fin_check CHECK ((fecha_fin > fecha_inicio)),
    CONSTRAINT membresia_valor_pagado_check CHECK ((valor_pagado > (0)::numeric))
);


ALTER TABLE public.membresia OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16715)
-- Name: membresia_id_membresia_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.membresia_id_membresia_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.membresia_id_membresia_seq OWNER TO postgres;

--
-- TOC entry 5109 (class 0 OID 0)
-- Dependencies: 223
-- Name: membresia_id_membresia_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.membresia_id_membresia_seq OWNED BY public.membresia.id_membresia;


--
-- TOC entry 232 (class 1259 OID 16815)
-- Name: ocupacion_clases; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.ocupacion_clases AS
 SELECT c.id_clase,
    c.nombre AS clase,
    c.dia_semana,
    c.hora,
    c.cupo,
    count(i.id_inscripcion) AS inscritos
   FROM (public.clase_grupal c
     LEFT JOIN public.inscripcion i ON ((c.id_clase = i.id_clase)))
  WHERE ((c.estado)::text = 'activa'::text)
  GROUP BY c.id_clase, c.nombre, c.dia_semana, c.hora, c.cupo;


ALTER VIEW public.ocupacion_clases OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16701)
-- Name: plan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.plan (
    id_plan integer NOT NULL,
    nombre character varying(50) NOT NULL,
    duracion_meses integer NOT NULL,
    precio numeric(10,2) NOT NULL,
    CONSTRAINT plan_duracion_meses_check CHECK ((duracion_meses > 0)),
    CONSTRAINT plan_precio_check CHECK ((precio > (0)::numeric))
);


ALTER TABLE public.plan OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16700)
-- Name: plan_id_plan_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.plan_id_plan_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.plan_id_plan_seq OWNER TO postgres;

--
-- TOC entry 5110 (class 0 OID 0)
-- Dependencies: 221
-- Name: plan_id_plan_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.plan_id_plan_seq OWNED BY public.plan.id_plan;


--
-- TOC entry 219 (class 1259 OID 16673)
-- Name: socio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.socio (
    numero_documento character varying(20) NOT NULL,
    nombre character varying(100) NOT NULL,
    telefono character varying(20) NOT NULL,
    correo character varying(100),
    acepta_whatsapp character varying(2) DEFAULT 'no'::character varying NOT NULL,
    CONSTRAINT socio_acepta_whatsapp_check CHECK (((acepta_whatsapp)::text = ANY ((ARRAY['si'::character varying, 'no'::character varying])::text[])))
);


ALTER TABLE public.socio OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16810)
-- Name: socios_vencidos; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.socios_vencidos AS
 SELECT s.numero_documento,
    s.nombre,
    s.telefono,
    s.acepta_whatsapp,
    max(m.fecha_fin) AS fecha_vencimiento
   FROM (public.socio s
     JOIN public.membresia m ON (((s.numero_documento)::text = (m.numero_documento_socio)::text)))
  GROUP BY s.numero_documento, s.nombre, s.telefono, s.acepta_whatsapp
 HAVING (max(m.fecha_fin) < CURRENT_DATE);


ALTER VIEW public.socios_vencidos OWNER TO postgres;

--
-- TOC entry 4896 (class 2604 OID 16755)
-- Name: clase_grupal id_clase; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clase_grupal ALTER COLUMN id_clase SET DEFAULT nextval('public.clase_grupal_id_clase_seq'::regclass);


--
-- TOC entry 4895 (class 2604 OID 16742)
-- Name: entrenador id_entrenador; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrenador ALTER COLUMN id_entrenador SET DEFAULT nextval('public.entrenador_id_entrenador_seq'::regclass);


--
-- TOC entry 4898 (class 2604 OID 16774)
-- Name: inscripcion id_inscripcion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscripcion ALTER COLUMN id_inscripcion SET DEFAULT nextval('public.inscripcion_id_inscripcion_seq'::regclass);


--
-- TOC entry 4894 (class 2604 OID 16719)
-- Name: membresia id_membresia; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membresia ALTER COLUMN id_membresia SET DEFAULT nextval('public.membresia_id_membresia_seq'::regclass);


--
-- TOC entry 4893 (class 2604 OID 16704)
-- Name: plan id_plan; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plan ALTER COLUMN id_plan SET DEFAULT nextval('public.plan_id_plan_seq'::regclass);


--
-- TOC entry 5098 (class 0 OID 16752)
-- Dependencies: 228
-- Data for Name: clase_grupal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clase_grupal (id_clase, id_entrenador, nombre, dia_semana, hora, cupo, estado) FROM stdin;
1	1	Spinning	Lunes	07:00:00	2	activa
2	2	Yoga	Martes	08:30:00	10	activa
3	1	Funcional	Miércoles	18:00:00	12	activa
4	2	Pilates	Jueves	17:00:00	8	suspendida
5	2	Pilates	Viernes	18:00:00	12	activa
\.


--
-- TOC entry 5096 (class 0 OID 16739)
-- Dependencies: 226
-- Data for Name: entrenador; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.entrenador (id_entrenador, nombre, especialidad, correo) FROM stdin;
1	Camila Torres	Spinning y Cardio	camila.torres@cuerpoactivo.com
2	Diego Herrera	Yoga y Movilidad	diego.herrera@cuerpoactivo.com
3	Javier Morales	CrossFit y Fuerza	javier.morales@cuerpoactivo.com
\.


--
-- TOC entry 5090 (class 0 OID 16683)
-- Dependencies: 220
-- Data for Name: ficha_medica; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ficha_medica (numero_documento_socio, peso, estatura, lesiones) FROM stdin;
1001	62.50	1.65	Ninguna
1002	78.00	1.78	Esguince leve de tobillo derecho en 2024
1003	55.20	1.60	Ninguna
1004	84.30	1.81	Dolor lumbar ocasional
\.


--
-- TOC entry 5100 (class 0 OID 16771)
-- Dependencies: 230
-- Data for Name: inscripcion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inscripcion (id_inscripcion, numero_documento_socio, id_clase, fecha_inscripcion) FROM stdin;
1	1001	1	2026-11-02
2	1002	1	2026-11-03
3	1001	2	2026-11-04
4	1001	3	2026-11-05
5	1002	3	2026-11-06
6	1003	2	2026-11-07
7	1003	4	2026-11-08
8	1004	2	2026-11-09
9	1004	3	2026-11-10
10	1005	4	2026-11-11
11	1005	2	2026-11-12
12	1007	2	2026-11-13
13	1007	3	2026-11-14
14	1008	4	2026-11-15
\.


--
-- TOC entry 5094 (class 0 OID 16716)
-- Dependencies: 224
-- Data for Name: membresia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.membresia (id_membresia, numero_documento_socio, id_plan, fecha_inicio, fecha_fin, valor_pagado) FROM stdin;
1	1001	1	2026-09-01	2026-10-01	90000.00
2	1001	2	2026-11-01	2027-02-01	210000.00
3	1002	1	2026-08-15	2026-09-15	90000.00
4	1003	3	2026-11-05	2027-11-05	850000.00
5	1004	1	2026-11-10	2026-12-10	90000.00
6	1005	2	2026-11-12	2027-02-12	240000.00
7	1006	1	2026-11-15	2026-12-15	90000.00
11	1001	1	2026-11-18	2026-12-18	90000.00
12	1008	1	2026-08-01	2026-09-01	90000.00
13	1007	2	2026-09-10	2026-12-10	240000.00
14	1003	1	2026-10-05	2026-11-05	90000.00
15	1004	2	2026-11-19	2027-02-19	220000.00
16	1005	1	2026-10-20	2026-11-20	90000.00
\.


--
-- TOC entry 5092 (class 0 OID 16701)
-- Dependencies: 222
-- Data for Name: plan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.plan (id_plan, nombre, duracion_meses, precio) FROM stdin;
1	Mensual	1	90000.00
2	Trimestral	3	240000.00
3	Anual	12	850000.00
\.


--
-- TOC entry 5089 (class 0 OID 16673)
-- Dependencies: 219
-- Data for Name: socio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.socio (numero_documento, nombre, telefono, correo, acepta_whatsapp) FROM stdin;
1003	Sofía Martínez	3003334455	sofia.martinez@email.com	no
1005	Valentina Díaz	3005556677	\N	no
1006	Mateo Castro	3006667788	mateo.castro@email.com	no
1001	Laura Gómez	3001112233	laura.gomez@email.com	si
1002	Carlos Pérez	3209998877	carlos.perez@email.com	si
1004	Andrés Rojas	3004445566	andres.rojas@email.com	si
1007	Valeria Ríos	3007778899	valeria.rios@email.com	si
1008	Camilo Mendoza	3008889900	\N	no
\.


--
-- TOC entry 5111 (class 0 OID 0)
-- Dependencies: 227
-- Name: clase_grupal_id_clase_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clase_grupal_id_clase_seq', 5, true);


--
-- TOC entry 5112 (class 0 OID 0)
-- Dependencies: 225
-- Name: entrenador_id_entrenador_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.entrenador_id_entrenador_seq', 3, true);


--
-- TOC entry 5113 (class 0 OID 0)
-- Dependencies: 229
-- Name: inscripcion_id_inscripcion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inscripcion_id_inscripcion_seq', 14, true);


--
-- TOC entry 5114 (class 0 OID 0)
-- Dependencies: 223
-- Name: membresia_id_membresia_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.membresia_id_membresia_seq', 16, true);


--
-- TOC entry 5115 (class 0 OID 0)
-- Dependencies: 221
-- Name: plan_id_plan_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.plan_id_plan_seq', 3, true);


--
-- TOC entry 4927 (class 2606 OID 16804)
-- Name: clase_grupal clase_grupal_id_entrenador_dia_semana_hora_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clase_grupal
    ADD CONSTRAINT clase_grupal_id_entrenador_dia_semana_hora_key UNIQUE (id_entrenador, dia_semana, hora);


--
-- TOC entry 4929 (class 2606 OID 16764)
-- Name: clase_grupal clase_grupal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clase_grupal
    ADD CONSTRAINT clase_grupal_pkey PRIMARY KEY (id_clase);


--
-- TOC entry 4923 (class 2606 OID 16750)
-- Name: entrenador entrenador_correo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrenador
    ADD CONSTRAINT entrenador_correo_key UNIQUE (correo);


--
-- TOC entry 4925 (class 2606 OID 16748)
-- Name: entrenador entrenador_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrenador
    ADD CONSTRAINT entrenador_pkey PRIMARY KEY (id_entrenador);


--
-- TOC entry 4915 (class 2606 OID 16694)
-- Name: ficha_medica ficha_medica_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ficha_medica
    ADD CONSTRAINT ficha_medica_pkey PRIMARY KEY (numero_documento_socio);


--
-- TOC entry 4931 (class 2606 OID 16781)
-- Name: inscripcion inscripcion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscripcion
    ADD CONSTRAINT inscripcion_pkey PRIMARY KEY (id_inscripcion);


--
-- TOC entry 4921 (class 2606 OID 16727)
-- Name: membresia membresia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membresia
    ADD CONSTRAINT membresia_pkey PRIMARY KEY (id_membresia);


--
-- TOC entry 4917 (class 2606 OID 16714)
-- Name: plan plan_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plan
    ADD CONSTRAINT plan_nombre_key UNIQUE (nombre);


--
-- TOC entry 4919 (class 2606 OID 16712)
-- Name: plan plan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plan
    ADD CONSTRAINT plan_pkey PRIMARY KEY (id_plan);


--
-- TOC entry 4911 (class 2606 OID 16682)
-- Name: socio socio_correo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socio
    ADD CONSTRAINT socio_correo_key UNIQUE (correo);


--
-- TOC entry 4913 (class 2606 OID 16680)
-- Name: socio socio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socio
    ADD CONSTRAINT socio_pkey PRIMARY KEY (numero_documento);


--
-- TOC entry 4933 (class 2606 OID 16783)
-- Name: inscripcion uq_socio_clase; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscripcion
    ADD CONSTRAINT uq_socio_clase UNIQUE (numero_documento_socio, id_clase);


--
-- TOC entry 4937 (class 2606 OID 16765)
-- Name: clase_grupal clase_grupal_id_entrenador_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clase_grupal
    ADD CONSTRAINT clase_grupal_id_entrenador_fkey FOREIGN KEY (id_entrenador) REFERENCES public.entrenador(id_entrenador);


--
-- TOC entry 4934 (class 2606 OID 16805)
-- Name: ficha_medica ficha_medica_numero_documento_socio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ficha_medica
    ADD CONSTRAINT ficha_medica_numero_documento_socio_fkey FOREIGN KEY (numero_documento_socio) REFERENCES public.socio(numero_documento) ON DELETE CASCADE;


--
-- TOC entry 4938 (class 2606 OID 16789)
-- Name: inscripcion inscripcion_id_clase_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscripcion
    ADD CONSTRAINT inscripcion_id_clase_fkey FOREIGN KEY (id_clase) REFERENCES public.clase_grupal(id_clase);


--
-- TOC entry 4939 (class 2606 OID 16784)
-- Name: inscripcion inscripcion_numero_documento_socio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscripcion
    ADD CONSTRAINT inscripcion_numero_documento_socio_fkey FOREIGN KEY (numero_documento_socio) REFERENCES public.socio(numero_documento);


--
-- TOC entry 4935 (class 2606 OID 16733)
-- Name: membresia membresia_id_plan_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membresia
    ADD CONSTRAINT membresia_id_plan_fkey FOREIGN KEY (id_plan) REFERENCES public.plan(id_plan);


--
-- TOC entry 4936 (class 2606 OID 16728)
-- Name: membresia membresia_numero_documento_socio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membresia
    ADD CONSTRAINT membresia_numero_documento_socio_fkey FOREIGN KEY (numero_documento_socio) REFERENCES public.socio(numero_documento);


-- Completed on 2026-11-19 23:31:19

--
-- PostgreSQL database dump complete
--

\unrestrict Ad1kUL2BFE9d54M3MraBQUrfw0nFXz2fhf27h4LvEfN2NRDQqZdPMO5tiy0VYm1


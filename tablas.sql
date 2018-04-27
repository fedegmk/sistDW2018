
-- crear user "postgres" con pass "postgres"

CREATE DATABASE datawarehouse
    WITH 
    OWNER = "postgres"
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
    
-- secuencia para claves subrogadas de empresas

CREATE SEQUENCE public.empresa_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.empresa_id_seq
    OWNER TO postgres;

GRANT ALL ON SEQUENCE public.empresa_id_seq TO postgres;

-- secuencia para claves subrogadas de contenedores

CREATE SEQUENCE public.cont_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.cont_id_seq
    OWNER TO postgres;

GRANT ALL ON SEQUENCE public.cont_id_seq TO postgres;

-- secuencia de claves subrogadas de hogares

CREATE SEQUENCE public.hogar_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.hogar_id_seq
    OWNER TO postgres;
    
-- secuencia de claves subrogadas de hogares-contenedores 

CREATE SEQUENCE public.hogar_cont_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.hogar_cont_id_seq
    OWNER TO postgres;

GRANT ALL ON SEQUENCE public.hogar_cont_id_seq TO postgres;

-- secuencia de claves subrogadas de empresas-contenedores

CREATE SEQUENCE public.empresa_cont_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.empresa_cont_id_seq
    OWNER TO postgres;

GRANT ALL ON SEQUENCE public.empresa_cont_id_seq TO postgres;   

-- secuencia de claves subrogadas de recolección cont.

CREATE SEQUENCE public.rec_cont_sec_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.rec_cont_sec_id_seq
    OWNER TO postgres;

GRANT ALL ON SEQUENCE public.rec_cont_sec_id_seq TO postgres;

-- dim tiempo
    
CREATE TABLE public.tiempo
(
    id_tiempo SMALLINT NOT NULL,
    nom_dia varchar(10) COLLATE pg_catalog."default" NOT NULL,
    tipo_dia varchar(15) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT tiempo_pkey PRIMARY KEY (id_tiempo)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.tiempo
    OWNER to postgres;

-- dim horario
  
CREATE TABLE public.horario
(
    id_horario SMALLINT NOT NULL,
    rango_horario varchar(20) COLLATE pg_catalog."default" NOT NULL,
    tipo_rango varchar(20) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT horario_pkey PRIMARY KEY (id_horario)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.horario
    OWNER to postgres;

-- dim problema de vivienda

CREATE TABLE public.problema_vivienda
(
    id_problema_vivienda SMALLINT NOT NULL,
    descripcion_problema varchar(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT problema_vivienda_pkey PRIMARY KEY (id_problema_vivienda)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.problema_vivienda
    OWNER to postgres;

-- dim hogar

CREATE TABLE public.hogar
(
    id_hogar bigint NOT NULL DEFAULT nextval('hogar_id_seq'::regclass),
    tipo_hogar character varying(50) COLLATE pg_catalog."default" NOT NULL,
    sanitaria character varying(50) COLLATE pg_catalog."default" NOT NULL,
    asentamiento character varying(50) COLLATE pg_catalog."default" NOT NULL,
    estrato_social character varying(50) COLLATE pg_catalog."default" NOT NULL,
    personas_mayores_14 smallint NOT NULL DEFAULT 0,
    personas_menores_14 smallint NOT NULL DEFAULT 0,
    numero bigint NOT NULL,
    CONSTRAINT hogar_pkey PRIMARY KEY (id_hogar)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.hogar
    OWNER to postgres;

-- dim empresa

CREATE TABLE public.empresa
(
    id_empresa bigint NOT NULL DEFAULT nextval('empresa_id_seq'::regclass),
    tipo_empresa character varying(50) COLLATE pg_catalog."default" NOT NULL,
    estado_hab character varying(50) COLLATE pg_catalog."default" NOT NULL,
    rut character varying(50) COLLATE pg_catalog."default" NOT NULL DEFAULT 'S/D'::character varying,
    razon_social character varying(100) COLLATE pg_catalog."default" NOT NULL,
    direccion character varying(100) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT empresa_pkey PRIMARY KEY (id_empresa)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.empresa
    OWNER to postgres;

-- dim ccz-municipio

CREATE TABLE public.ccz_municipio
(
    id_ccz_municipio SMALLINT NOT NULL,
    ccz varchar(50) COLLATE pg_catalog."default" NOT NULL,
    municipio varchar(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT ccz_municipio_pkey PRIMARY KEY (id_ccz_municipio)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.ccz_municipio
    OWNER to postgres;

-- dim barrio 

CREATE TABLE public.barrio
(
    id_barrio SMALLINT NOT NULL,
    nom_barrio varchar(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT barrio_pkey PRIMARY KEY (id_barrio)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.barrio
    OWNER to postgres;

-- dim contenedor residuos

CREATE TABLE public.contenedor_residuos
(
    id_contenedor_res bigint NOT NULL DEFAULT nextval('cont_id_seq'::regclass),
    circuito character varying(50) COLLATE pg_catalog."default" NOT NULL,
    municipio character varying(50) COLLATE pg_catalog."default" NOT NULL,
    gid integer NOT NULL,
    CONSTRAINT contenedor_residuos_pkey PRIMARY KEY (id_contenedor_res)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.contenedor_residuos
    OWNER to postgres;

COMMENT ON COLUMN public.contenedor_residuos.gid
    IS 'es el único dato que me permite individualizar contenedores';

-- dim contenedor reciclable

CREATE TABLE public.contenedor_reciclable
(
    id_contenedor_rec SMALLINT NOT NULL,
    tipo_local varchar(50) COLLATE pg_catalog."default" NOT NULL,
    nombre_local varchar(50) COLLATE pg_catalog."default" NOT NULL,
    direccion_local varchar(100) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT contenedor_reciclable_pkey PRIMARY KEY (id_contenedor_rec)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.contenedor_reciclable
    OWNER to postgres;

-- dim contenedor especial

CREATE TABLE public.contenedor_especial
(
    id_contenedor_esp SMALLINT NOT NULL,
    material varchar(50) COLLATE pg_catalog."default" NOT NULL,
    direccion_contenedor varchar(100) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT contenedor_especial_pkey PRIMARY KEY (id_contenedor_esp)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.contenedor_especial
    OWNER to postgres;

-- fact recolección cont. residuos (req. I)

CREATE TABLE public.recoleccion_cont_residuos
(
    id_contenedor_res bigint NOT NULL,
    id_ccz_municipio smallint NOT NULL,
    id_barrio smallint NOT NULL,
    id_tiempo smallint NOT NULL,
    id_horario smallint NOT NULL,
    frec_recoleccion integer NOT NULL DEFAULT 0,
    id_rec_cont_residuos bigint NOT NULL DEFAULT nextval('hogar_cont_id_seq'::regclass),
    CONSTRAINT recoleccion_cont_residuos_pkey PRIMARY KEY (id_rec_cont_residuos)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.recoleccion_cont_residuos
    OWNER to postgres;
    
-- fact hogar-contenedor (req. II)

CREATE TABLE public.hogar_contenedor
(
    id_contenedor_res bigint NOT NULL,
    id_ccz_municipio_cont smallint NOT NULL,
    id_barrio_cont smallint NOT NULL,
    id_hogar bigint NOT NULL,
    id_ccz_municipio_hogar smallint NOT NULL,
    id_barrio_hogar smallint NOT NULL,
    id_problema_vivienda smallint NOT NULL,
    cant_pers_mayor_14 integer NOT NULL DEFAULT 0,
    cant_pers_menor_14 integer NOT NULL DEFAULT 0,
    id_hogar_contenedor bigint NOT NULL DEFAULT nextval('hogar_cont_id_seq'::regclass),
    CONSTRAINT hogar_contenedor_pkey PRIMARY KEY (id_hogar_contenedor)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.hogar_contenedor
    OWNER to postgres;

-- fact empresa-contenedor (req. II)

CREATE TABLE public.empresa_contenedor
(
    id_empresa_contenedor bigint NOT NULL DEFAULT nextval('empresa_cont_id_seq'::regclass),
    id_contenedor_res bigint NOT NULL REFERENCES contenedor_residuos (id_contenedor_res),
    id_ccz_municipio_cont SMALLINT NOT NULL REFERENCES ccz_municipio (id_ccz_municipio),
    id_barrio_cont SMALLINT NOT NULL REFERENCES barrio (id_barrio),
    id_empresa bigint NOT NULL REFERENCES empresa (id_empresa),
    id_ccz_municipio_empresa SMALLINT NOT NULL REFERENCES ccz_municipio (id_ccz_municipio),
    id_barrio_empresa SMALLINT NOT NULL REFERENCES barrio (id_barrio),
    CONSTRAINT empresa_contenedor_pkey PRIMARY KEY (id_contenedor_res,id_ccz_municipio_cont,id_barrio_cont,id_empresa,id_ccz_municipio_empresa,id_barrio_empresa)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.empresa_contenedor
    OWNER to postgres;

-- inserciones en la dim tiempo

INSERT INTO public.tiempo(
    id_tiempo, nom_dia, tipo_dia)
    VALUES
       (0, 'S/D', 'S/D'), 
           (1, 'LUN', 'S'),
           (2, 'MAR', 'S'),
           (3, 'MIE', 'S'),
           (4, 'JUE', 'S'),
           (5, 'VIE', 'S'),
           (6, 'SAB', 'FS'),
           (7, 'DOM', 'FS');

-- inserciones en la dim horario

INSERT INTO public.horario(
    id_horario, rango_horario, tipo_rango)
    VALUES 
       (0, 'S/D', 'S/D'),
           (1, '06-14', 'MAT'),
           (2, '14-22', 'VES'),
           (3, '22-06', 'NOC');

-- problemas de vivienda
INSERT INTO public.problema_vivienda(
    id_problema_vivienda, descripcion_problema)
    VALUES
       (0,'S/D'),
       (1,'HUMEDADES EN TECHOS'),
       (2,'GOTERAS EN TECHOS'),
       (3,'MUROS AGRIETADOS'),
       (4,'PUERTAS O VENTADAS EN MAL ESTADO'),
       (5,'GRIETAS EN PISOS'),
       (6,'CAÍDA DE REVOQUE DE PAREDES O TECHOS'),
       (7,'CIELOS RASOS DESPRENDIDOS'),
       (8,'POCA LUZ SOLAR'),
       (9,'ESCASA VENTILACIÓN'),
       (10,'SE INUNDA CUANDO LLUEVE'),
       (11,'PELIGRO DE DERRUMBE'),
       (12,'HUMEDADES EN LOS CIMIENTOS');

-- tupla por defecto en ccz_municipio

INSERT INTO public.ccz_municipio(
    id_ccz_municipio, ccz, municipio)
    VALUES (0, 'S/D', 'S/D');

-- tupla por defecto en barrio

INSERT INTO public.barrio(
    id_barrio, nom_barrio)
    VALUES (0, 'S/D');

-- tupla por defecto en empresa

INSERT INTO public.empresa(
    id_empresa, tipo_empresa, estado_hab, rut, razon_social, direccion)
    VALUES (0, 'S/D', 'S/D', 'S/D', 'S/D', 'S/D');

-- tupla por defecto en hogar

INSERT INTO public.hogar(
    id_hogar, tipo_hogar, sanitaria, asentamiento, estrato_social, personas_mayores_14, personas_menores_14, numero)
    VALUES (0, 'S/D', 'S/D', 'S/D', 'S/D', 0, 0, 0);

-- tupla por defecto contenedores

INSERT INTO public.contenedor_residuos(
    id_contenedor_res, circuito, municipio, gid)
    VALUES (0, 'S/D', 'S/D', 0);
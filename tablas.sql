
-- crear user "postgres" con pass "postgres"

CREATE DATABASE datawarehouse
    WITH 
    OWNER = "postgres"
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
    
    

    
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




CREATE TABLE public.hogar
(
    id_hogar SMALLINT NOT NULL,
    tipo_hogar varchar(50) COLLATE pg_catalog."default" NOT NULL,
    sanitaria varchar(50) COLLATE pg_catalog."default" NOT NULL,
    asentamiento varchar(50) COLLATE pg_catalog."default" NOT NULL,
    estrato_social varchar(50) COLLATE pg_catalog."default" NOT NULL,
    personas_mayores_14 smallint default 0 NOT NULL,
    personas_menores_14 smallint default 0 NOT NULL ,
    CONSTRAINT hogar_pkey PRIMARY KEY (id_hogar)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.hogar
    OWNER to postgres;



CREATE TABLE public.empresa
(
    id_empresa SMALLINT NOT NULL,
    tipo_empresa varchar(50) COLLATE pg_catalog."default" NOT NULL,
    estado_hab varchar(50) COLLATE pg_catalog."default" NOT NULL,
    RUT varchar(50) COLLATE pg_catalog."default" NOT NULL,
    razon_social varchar(50) COLLATE pg_catalog."default" NOT NULL,
	dirección varchar(100) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT empresa_pkey PRIMARY KEY (id_empresa)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.empresa
    OWNER to postgres;


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


CREATE TABLE public.contenedor_residuos
(
    id_contenedor_res SMALLINT NOT NULL,
    circuito varchar(50) COLLATE pg_catalog."default" NOT NULL,
    municipio varchar(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT contenedor_residuos_pkey PRIMARY KEY (id_contenedor_res)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.contenedor_residuos
    OWNER to postgres;

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


CREATE TABLE public.recoleccion_cont_residuos
(
    id_contenedor_res SMALLINT NOT NULL REFERENCES contenedor_residuos (id_contenedor_res),
    id_ccz_municipio SMALLINT NOT NULL REFERENCES ccz_municipio (id_ccz_municipio),
    id_barrio SMALLINT NOT NULL REFERENCES barrio (id_barrio),
    id_tiempo SMALLINT NOT NULL REFERENCES tiempo (id_tiempo),
    id_horario SMALLINT NOT NULL REFERENCES horario (id_horario),
    frec_recoleccion INTEGER DEFAULT 0 NOT NULL,
    CONSTRAINT recoleccion_cont_residuos_pkey PRIMARY KEY (id_contenedor_res,id_ccz_municipio,id_barrio,id_tiempo,id_horario)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.recoleccion_cont_residuos
    OWNER to postgres;
    

CREATE TABLE public.hogar_contenedor
(
    id_contenedor_res SMALLINT NOT NULL REFERENCES contenedor_residuos (id_contenedor_res),
    id_ccz_municipio_cont SMALLINT NOT NULL REFERENCES ccz_municipio (id_ccz_municipio),
    id_barrio_cont SMALLINT NOT NULL REFERENCES barrio (id_barrio),
    id_hogar SMALLINT NOT NULL REFERENCES hogar (id_hogar),
    id_ccz_municipio_hogar SMALLINT NOT NULL REFERENCES ccz_municipio (id_ccz_municipio),
    id_barrio_hogar SMALLINT NOT NULL REFERENCES barrio (id_barrio),
    id_problema_vivienda SMALLINT NOT NULL REFERENCES problema_vivienda(id_problema_vivienda),
    cant_pers_mayor_14 INTEGER DEFAULT 0 NOT NULL,
    cant_pers_menor_14 INTEGER DEFAULT 0 NOT NULL,
    CONSTRAINT hogar_contenedor_pkey PRIMARY KEY (id_contenedor_res,id_ccz_municipio_cont, id_barrio_cont,id_hogar,id_ccz_municipio_hogar, id_barrio_hogar,id_problema_vivienda)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.hogar_contenedor
    OWNER to postgres;


CREATE TABLE public.empresa_contenedor
(
    id_contenedor_res SMALLINT NOT NULL REFERENCES contenedor_residuos (id_contenedor_res),
    id_ccz_municipio_cont SMALLINT NOT NULL REFERENCES ccz_municipio (id_ccz_municipio),
    id_barrio_cont SMALLINT NOT NULL REFERENCES barrio (id_barrio),
    id_empresa SMALLINT NOT NULL REFERENCES empresa (id_empresa),
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
-- Table: staging.stg_barrio

-- DROP TABLE staging.stg_barrio;

CREATE TABLE staging.stg_barrio
(
    nro_barrio smallint NOT NULL,
    cod_barrio character varying(5) COLLATE pg_catalog."default" NOT NULL,
    desc_barrio character varying(100) COLLATE pg_catalog."default" NOT NULL,
    geometria character varying COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE staging.stg_barrio
    OWNER to postgres;

-- Table: staging.stg_ccz

-- DROP TABLE staging.stg_ccz;

CREATE TABLE staging.stg_ccz
(
    nro_ccz smallint NOT NULL,
    cod_ccz character varying(5) COLLATE pg_catalog."default" NOT NULL,
    geometria character varying COLLATE pg_catalog."default",
    cod_mun character varying(5) COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE staging.stg_ccz
    OWNER to postgres;

-- Table: staging.stg_circ

-- DROP TABLE staging.stg_circ;

CREATE TABLE staging.stg_circ
(
    nro_circ smallint NOT NULL,
    cod_circ character varying(50) COLLATE pg_catalog."default" NOT NULL,
    cod_mun character varying(5) COLLATE pg_catalog."default" NOT NULL,
    geometria character varying COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE staging.stg_circ
    OWNER to postgres;

-- Table: staging.stg_cont

-- DROP TABLE staging.stg_cont;

CREATE TABLE staging.stg_cont
(
    nro_cont smallint NOT NULL,
    cod_circ character varying(50) COLLATE pg_catalog."default" NOT NULL,
    turno_horario character varying(100) COLLATE pg_catalog."default" NOT NULL,
    geometria character varying COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE staging.stg_cont
    OWNER to postgres;

-- Table: staging.stg_mun

-- DROP TABLE staging.stg_mun;

CREATE TABLE staging.stg_mun
(
    cod_mun character varying(5) COLLATE pg_catalog."default" NOT NULL,
    geometria character varying COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE staging.stg_mun
    OWNER to postgres;
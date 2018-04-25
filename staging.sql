-- SCHEMA: staging

-- DROP SCHEMA staging ;

CREATE SCHEMA staging
    AUTHORIZATION postgres;

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
    cod_circ character varying(50) COLLATE pg_catalog."default" NOT NULL,
    turno_horario character varying(100) COLLATE pg_catalog."default" NOT NULL,
    geometria character varying COLLATE pg_catalog."default",
    nro_barrio smallint NOT NULL DEFAULT 0,
    nro_ccz smallint NOT NULL DEFAULT 0,
    gid integer NOT NULL,
    nro_segm integer NOT NULL DEFAULT 0,
    geo_cont geometry
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE staging.stg_cont
    OWNER to postgres;

-- Table: staging.stg_emps

-- DROP TABLE staging.stg_emps;

CREATE TABLE staging.stg_emps
(
    razon_soc character varying(100) COLLATE pg_catalog."default",
    dir_emp character varying(100) COLLATE pg_catalog."default",
    tipo_emp character varying(50) COLLATE pg_catalog."default",
    estado_hab character varying(50) COLLATE pg_catalog."default",
    rut character varying(50) COLLATE pg_catalog."default",
    geometria character varying COLLATE pg_catalog."default",
    geo_emp geometry,
    nro_ccz integer NOT NULL DEFAULT 0,
    nro_barrio integer NOT NULL DEFAULT 0
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE staging.stg_emps
    OWNER to postgres;

-- Table: staging.stg_hogar

-- DROP TABLE staging.stg_hogar;

CREATE TABLE staging.stg_hogar
(
    pv_hum_tech smallint NOT NULL,
    pv_inund smallint NOT NULL,
    pv_pel_derrum smallint NOT NULL,
    pv_hum_cim smallint NOT NULL,
    pv_gotera smallint NOT NULL,
    pv_mur_agr smallint NOT NULL,
    pv_ab_mal_est smallint NOT NULL,
    pv_pis_agr smallint NOT NULL,
    pv_caida_rev smallint NOT NULL,
    pv_cielor_desp smallint NOT NULL,
    pv_poca_luz_sol smallint NOT NULL,
    pv_esc_vent smallint NOT NULL,
    cant_hog smallint NOT NULL,
    cant_pers_may14 smallint NOT NULL,
    cant_pers_men14 smallint NOT NULL,
    numero bigint NOT NULL,
    segm smallint NOT NULL,
    barrio smallint NOT NULL,
    ccz smallint NOT NULL,
    estr_soc character varying(100) COLLATE pg_catalog."default",
    tipo_hog character varying(100) COLLATE pg_catalog."default",
    asentamiento character varying(5) COLLATE pg_catalog."default",
    sanitaria character varying(50) COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE staging.stg_hogar
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

-- Table: staging.stg_segm

-- DROP TABLE staging.stg_segm;

CREATE TABLE staging.stg_segm
(
    num_segm smallint NOT NULL,
    geometria character varying COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE staging.stg_segm
    OWNER to postgres;

-- estrato

CREATE TABLE staging.stg_estr_soc
(
    id_estrato smallint NOT NULL,
    desc_estrato character varying COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE staging.stg_estr_soc
    OWNER to postgres;
    
    

INSERT INTO staging.stg_estr_soc(
    id_estrato, desc_estrato)
    VALUES
       (0,'S/D'),
       (1,'Nivel económico bajo'),
       (2,'Nivel económico medio - bajo'),
       (3,'Nivel económico medio'),
       (4,'Nivel económico medio - alto'),
       (5,'Nivel económico alto'),
       (6,'Zona metropolitana');


-- tipo hogar

CREATE TABLE staging.stg_tipo_hog
(
    id_tipo_vivienda smallint NOT NULL,
    tipo_vivienda character varying COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE staging.stg_tipo_hog
    OWNER to postgres;
    

INSERT INTO staging.stg_tipo_hog(
    id_tipo_vivienda, tipo_vivienda)
    VALUES
       (0,'S/D'),
       (1,'Casa'),
       (2,'Apartamento o casa en complejo habitacional'),
       (3,'Apartamento en edificio de altura'),
       (4,'Apartamento en edificio de una planta'),
       (5,'Local no construido para vivienda');



--- sanitaria

CREATE TABLE staging.stg_sanit
(
    id_sanitaria smallint NOT NULL,
    sanitaria character varying COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE staging.stg_sanit
    OWNER to postgres;
    

INSERT INTO staging.stg_sanit(
    id_sanitaria, sanitaria)
    VALUES
       (0,'S/D'),
       (1,'Sí\, con cisterna'),
       (2,'Sí\, sin cisterna'),
       (3,'No');
  
-- asentamiento

CREATE TABLE staging.stg_asent
(
    id_asentamiento smallint NOT NULL,
    asentamiento character varying COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE staging.stg_asent
    OWNER to postgres;
    

INSERT INTO staging.stg_asent(
    id_asentamiento, asentamiento)
    VALUES
       (0,'S/D'),
       (1,'Sí'),
       (2,'NO');    
    
    

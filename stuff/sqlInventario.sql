-- This script was generated by a beta version of the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE IF NOT EXISTS public.ajuste
(
    id_ajuste integer NOT NULL DEFAULT nextval('ajuste_id_ajuste_seq'::regclass),
    fecha time with time zone NOT NULL,
    comentario text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT ajuste_pkey PRIMARY KEY (id_ajuste)
);

CREATE TABLE IF NOT EXISTS public.cliente
(
    id_cliente integer NOT NULL DEFAULT nextval('cliente_id_cliente_seq'::regclass),
    nombre character varying(45) COLLATE pg_catalog."default" NOT NULL,
    apellido character varying(45) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT cliente_pkey PRIMARY KEY (id_cliente)
);

CREATE TABLE IF NOT EXISTS public.compra
(
    id_compra integer NOT NULL DEFAULT nextval('compra_id_compra_seq'::regclass),
    id_proveedor integer NOT NULL DEFAULT nextval('compra_id_proveedor_seq'::regclass),
    fecha time with time zone NOT NULL,
    proveedor_compra character varying(45) COLLATE pg_catalog."default" NOT NULL,
    total money NOT NULL,
    CONSTRAINT compra_pkey PRIMARY KEY (id_compra)
);

CREATE TABLE IF NOT EXISTS public.detalle_ajuste
(
    id_detalle_ajuste integer NOT NULL DEFAULT nextval('detalle_ajuste_id_detalle_ajuste_seq'::regclass),
    id_ajuste integer NOT NULL DEFAULT nextval('detalle_ajuste_id_ajuste_seq'::regclass),
    producto character varying(45) COLLATE pg_catalog."default" NOT NULL,
    cantidad integer NOT NULL,
    costo money NOT NULL,
    subtotal money NOT NULL GENERATED ALWAYS AS ((cantidad * costo)) STORED,
    CONSTRAINT detalle_ajuste_pkey PRIMARY KEY (id_detalle_ajuste, id_ajuste)
);

CREATE TABLE IF NOT EXISTS public.detalle_compra
(
    id_detalle_compra integer NOT NULL DEFAULT nextval('detalle_compra_id_detalle_compra_seq'::regclass),
    id_compra integer NOT NULL DEFAULT nextval('detalle_compra_id_compra_seq'::regclass),
    producto character varying(45) COLLATE pg_catalog."default" NOT NULL,
    cantidad integer NOT NULL,
    costo money NOT NULL,
    subtotal money NOT NULL,
    CONSTRAINT detalle_compra_pkey PRIMARY KEY (id_detalle_compra, id_compra)
);

CREATE TABLE IF NOT EXISTS public.detalle_factura
(
    id_detalle_factura integer NOT NULL DEFAULT nextval('detalle_factura_id_detalle_factura_seq'::regclass),
    id_factura integer NOT NULL DEFAULT nextval('detalle_factura_id_factura_seq'::regclass),
    producto_vendido character varying(45) COLLATE pg_catalog."default" NOT NULL,
    cantidad integer NOT NULL,
    precio money NOT NULL,
    subtotal money NOT NULL,
    CONSTRAINT detalle_factura_pkey PRIMARY KEY (id_detalle_factura, id_factura)
);

CREATE TABLE IF NOT EXISTS public.factura
(
    id_factura integer NOT NULL DEFAULT nextval('factura_id_factura_seq'::regclass),
    id_cliente integer NOT NULL DEFAULT nextval('factura_id_cliente_seq'::regclass),
    fecha time with time zone NOT NULL,
    subtotal money NOT NULL,
    impuesto money NOT NULL,
    descuento money NOT NULL,
    total money NOT NULL GENERATED ALWAYS AS (((subtotal + impuesto) - descuento)) STORED,
    CONSTRAINT factura_pkey PRIMARY KEY (id_factura)
);

CREATE TABLE IF NOT EXISTS public.kardex
(
    id_kardex integer NOT NULL DEFAULT nextval('kardex_id_kardex_seq'::regclass),
    id_producto integer NOT NULL DEFAULT nextval('kardex_id_producto_seq'::regclass),
    usuario_editor character varying(50) COLLATE pg_catalog."default" NOT NULL,
    nombre_operacion character varying(45) COLLATE pg_catalog."default" NOT NULL,
    producto character varying(45) COLLATE pg_catalog."default" NOT NULL,
    cantidad integer NOT NULL,
    costo money NOT NULL,
    precio money NOT NULL,
    fecha time with time zone NOT NULL,
    inventario_antes integer NOT NULL,
    inventario_despues integer NOT NULL,
    CONSTRAINT kardex_pkey PRIMARY KEY (id_kardex)
);

CREATE TABLE IF NOT EXISTS public.privilegio
(
    id_privilegio integer NOT NULL DEFAULT nextval('privilegio_id_privilegio_seq'::regclass),
    id_kardex integer NOT NULL DEFAULT nextval('privilegio_id_kardex_seq'::regclass),
    nombre character varying(45) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT privilegio_pkey PRIMARY KEY (id_privilegio, id_kardex)
);

CREATE TABLE IF NOT EXISTS public.producto
(
    id_producto integer NOT NULL DEFAULT nextval('producto_id_producto_seq'::regclass),
    nombre character varying(45) COLLATE pg_catalog."default" NOT NULL,
    costo money NOT NULL,
    categoria character varying(45) COLLATE pg_catalog."default" NOT NULL,
    marca character varying(45) COLLATE pg_catalog."default" NOT NULL,
    precio money NOT NULL,
    ex_min integer NOT NULL,
    ex_max integer NOT NULL,
    estado boolean NOT NULL DEFAULT true,
    CONSTRAINT producto_pkey PRIMARY KEY (id_producto)
);

CREATE TABLE IF NOT EXISTS public.producto_detalle_ajuste
(
    id_detalle_ajuste integer NOT NULL DEFAULT nextval('producto_detalle_ajuste_id_detalle_ajuste_seq'::regclass),
    id_ajuste integer NOT NULL DEFAULT nextval('producto_detalle_ajuste_id_ajuste_seq'::regclass),
    id_producto integer NOT NULL DEFAULT nextval('producto_detalle_ajuste_id_producto_seq'::regclass),
    CONSTRAINT producto_detalle_ajuste_pkey PRIMARY KEY (id_detalle_ajuste, id_ajuste, id_producto)
);

CREATE TABLE IF NOT EXISTS public.producto_detalle_compra
(
    id_producto integer NOT NULL DEFAULT nextval('producto_detalle_compra_id_producto_seq'::regclass),
    id_detalle_compra integer NOT NULL DEFAULT nextval('producto_detalle_compra_id_detalle_compra_seq'::regclass),
    id_compra integer NOT NULL DEFAULT nextval('producto_detalle_compra_id_compra_seq'::regclass),
    CONSTRAINT producto_detalle_compra_pkey PRIMARY KEY (id_producto, id_detalle_compra, id_compra)
);

CREATE TABLE IF NOT EXISTS public.producto_detalle_factura
(
    id_producto integer NOT NULL DEFAULT nextval('producto_detalle_factura_id_producto_seq'::regclass),
    id_detalle_factura integer NOT NULL DEFAULT nextval('producto_detalle_factura_id_detalle_factura_seq'::regclass),
    id_factura integer NOT NULL DEFAULT nextval('producto_detalle_factura_id_factura_seq'::regclass),
    CONSTRAINT producto_detalle_factura_pkey PRIMARY KEY (id_producto, id_detalle_factura, id_factura)
);

CREATE TABLE IF NOT EXISTS public.proveedor
(
    id_proveedor integer NOT NULL DEFAULT nextval('proveedor_id_proveedor_seq'::regclass),
    nombre character varying(45) COLLATE pg_catalog."default" NOT NULL,
    direccion character varying(100) COLLATE pg_catalog."default" NOT NULL,
    telefono character varying(45) COLLATE pg_catalog."default" NOT NULL,
    nombre_contacto_principal character varying(45) COLLATE pg_catalog."default" NOT NULL,
    estado boolean NOT NULL DEFAULT true,
    CONSTRAINT proveedor_pkey PRIMARY KEY (id_proveedor)
);

CREATE TABLE IF NOT EXISTS public.rol
(
    id_rol integer NOT NULL DEFAULT nextval('rol_id_rol_seq'::regclass),
    id_kardex integer NOT NULL DEFAULT nextval('rol_id_kardex_seq'::regclass),
    id_privilegio integer NOT NULL DEFAULT nextval('rol_id_privilegio_seq'::regclass),
    CONSTRAINT rol_pkey PRIMARY KEY (id_rol)
);

CREATE TABLE IF NOT EXISTS public.rol_privilegio
(
    id_rol integer NOT NULL DEFAULT nextval('rol_privilegio_id_rol_seq'::regclass),
    id_kardex integer NOT NULL DEFAULT nextval('rol_privilegio_id_kardex_seq'::regclass),
    id_privilegio integer NOT NULL DEFAULT nextval('rol_privilegio_id_privilegio_seq'::regclass),
    CONSTRAINT rol_privilegio_pkey PRIMARY KEY (id_rol, id_kardex, id_privilegio)
);

CREATE TABLE IF NOT EXISTS public.usuario
(
    id_usuario integer NOT NULL DEFAULT nextval('usuario_id_usuario_seq'::regclass),
    nombre character varying(45) COLLATE pg_catalog."default" NOT NULL,
    apellido character varying(45) COLLATE pg_catalog."default" NOT NULL,
    email character varying(50) COLLATE pg_catalog."default" NOT NULL,
    username character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario)
);

CREATE TABLE IF NOT EXISTS public.usuario_rol
(
    id_usuario integer NOT NULL DEFAULT nextval('usuario_rol_id_usuario_seq'::regclass),
    id_rol integer NOT NULL DEFAULT nextval('usuario_rol_id_rol_seq'::regclass),
    CONSTRAINT usuario_rol_pkey PRIMARY KEY (id_rol, id_usuario)
);

ALTER TABLE IF EXISTS public.compra
    ADD CONSTRAINT fk_proveedor_compra_p FOREIGN KEY (id_proveedor)
    REFERENCES public.proveedor (id_proveedor) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;


ALTER TABLE IF EXISTS public.detalle_ajuste
    ADD CONSTRAINT fk_detalle_ajuste_a FOREIGN KEY (id_ajuste)
    REFERENCES public.ajuste (id_ajuste) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;


ALTER TABLE IF EXISTS public.detalle_compra
    ADD CONSTRAINT fk_detalle_compra_co FOREIGN KEY (id_compra)
    REFERENCES public.compra (id_compra) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;


ALTER TABLE IF EXISTS public.detalle_factura
    ADD CONSTRAINT fk_detalle_factura_f FOREIGN KEY (id_factura)
    REFERENCES public.factura (id_factura) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;


ALTER TABLE IF EXISTS public.factura
    ADD CONSTRAINT fk_factura_cliente FOREIGN KEY (id_cliente)
    REFERENCES public.cliente (id_cliente) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE RESTRICT
    NOT VALID;


ALTER TABLE IF EXISTS public.kardex
    ADD CONSTRAINT fk_kardex_producto FOREIGN KEY (id_producto)
    REFERENCES public.producto (id_producto) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;


ALTER TABLE IF EXISTS public.privilegio
    ADD CONSTRAINT fk_kardex_privilegio_k FOREIGN KEY (id_kardex)
    REFERENCES public.kardex (id_kardex) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE RESTRICT
    NOT VALID;


ALTER TABLE IF EXISTS public.producto_detalle_ajuste
    ADD CONSTRAINT fk_id_detalle_ajuste FOREIGN KEY (id_ajuste, id_detalle_ajuste)
    REFERENCES public.detalle_ajuste (id_ajuste, id_detalle_ajuste) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;


ALTER TABLE IF EXISTS public.producto_detalle_ajuste
    ADD CONSTRAINT fk_id_producto_ajuste FOREIGN KEY (id_producto)
    REFERENCES public.producto (id_producto) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;


ALTER TABLE IF EXISTS public.producto_detalle_compra
    ADD CONSTRAINT fk_id_detalle_compra FOREIGN KEY (id_compra, id_detalle_compra)
    REFERENCES public.detalle_compra (id_compra, id_detalle_compra) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;


ALTER TABLE IF EXISTS public.producto_detalle_compra
    ADD CONSTRAINT fk_id_producto_compra FOREIGN KEY (id_producto)
    REFERENCES public.producto (id_producto) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;


ALTER TABLE IF EXISTS public.producto_detalle_factura
    ADD CONSTRAINT fk_id_detalle_factura FOREIGN KEY (id_factura, id_detalle_factura)
    REFERENCES public.detalle_factura (id_factura, id_detalle_factura) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;


ALTER TABLE IF EXISTS public.producto_detalle_factura
    ADD CONSTRAINT fk_id_producto_factura FOREIGN KEY (id_producto)
    REFERENCES public.producto (id_producto) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;


ALTER TABLE IF EXISTS public.rol_privilegio
    ADD CONSTRAINT fk_id_privilegio FOREIGN KEY (id_kardex, id_privilegio)
    REFERENCES public.privilegio (id_kardex, id_privilegio) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;


ALTER TABLE IF EXISTS public.rol_privilegio
    ADD CONSTRAINT fk_id_rol_privilegio_r FOREIGN KEY (id_rol)
    REFERENCES public.rol (id_rol) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;


ALTER TABLE IF EXISTS public.usuario_rol
    ADD CONSTRAINT fk_id_rol_usuario FOREIGN KEY (id_rol)
    REFERENCES public.rol (id_rol) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;


ALTER TABLE IF EXISTS public.usuario_rol
    ADD CONSTRAINT fk_id_usuario FOREIGN KEY (id_usuario)
    REFERENCES public.usuario (id_usuario) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

END;
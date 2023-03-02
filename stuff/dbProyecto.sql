-- This script was generated by a beta version of the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE IF NOT EXISTS public.ajuste
(
    id_ajuste SERIAL NOT NULL DEFAULT nextval('ajuste_id_ajuste_seq'::regclass),
    fecha timestamp without time zone NOT NULL,
    comentario text COLLATE pg_catalog."default" NOT NULL,
    id_usuario integer NOT NULL,
    CONSTRAINT ajuste_pkey PRIMARY KEY (id_ajuste)
);

CREATE TABLE IF NOT EXISTS public.cliente
(
    id_cliente integer NOT NULL DEFAULT nextval('cliente_id_cliente_seq'::regclass),
    nombre character varying(45) COLLATE pg_catalog."default" NOT NULL,
    apellido character varying(45) COLLATE pg_catalog."default" NOT NULL,
    id_usuario integer NOT NULL,
    CONSTRAINT cliente_pkey PRIMARY KEY (id_cliente)
);

CREATE TABLE IF NOT EXISTS public.compra
(
    id_compra integer NOT NULL,
    id_proveedor integer NOT NULL,
    fecha timestamp without time zone NOT NULL,
    proveedor_compra character varying(45) COLLATE pg_catalog."default" NOT NULL,
    total double precision NOT NULL,
    id_usuario integer NOT NULL,
    CONSTRAINT compra_pkey PRIMARY KEY (id_compra)
);

CREATE TABLE IF NOT EXISTS public.detalle_ajuste
(
    id_detalle_ajuste integer NOT NULL DEFAULT nextval('detalle_ajuste_id_detalle_ajuste_seq'::regclass),
    id_ajuste integer NOT NULL,
    id_producto integer NOT NULL,
    cantidad integer NOT NULL,
    costo double precision NOT NULL,
    subtotal double precision NOT NULL,
    CONSTRAINT detalle_ajuste_pkey PRIMARY KEY (id_detalle_ajuste, id_ajuste)
);

CREATE TABLE IF NOT EXISTS public.detalle_compra
(
    id_detalle_compra integer NOT NULL DEFAULT nextval('detalle_compra_id_detalle_compra_seq'::regclass),
    id_compra integer NOT NULL,
    id_producto integer NOT NULL,
    cantidad integer NOT NULL,
    costo double precision NOT NULL,
    subtotal double precision NOT NULL,
    CONSTRAINT detalle_compra_pkey PRIMARY KEY (id_detalle_compra, id_compra)
);

CREATE TABLE IF NOT EXISTS public.detalle_factura
(
    id_detalle_factura integer NOT NULL DEFAULT nextval('detalle_factura_id_detalle_factura_seq'::regclass),
    id_factura integer NOT NULL,
    id_producto integer NOT NULL,
    cantidad integer NOT NULL,
    precio double precision NOT NULL,
    subtotal double precision NOT NULL,
    CONSTRAINT detalle_factura_pkey PRIMARY KEY (id_detalle_factura, id_factura)
);

CREATE TABLE IF NOT EXISTS public.factura
(
    id_factura integer NOT NULL DEFAULT nextval('factura_id_factura_seq'::regclass),
    id_cliente integer NOT NULL,
    id_usuario integer NOT NULL,
    fecha timestamp without time zone NOT NULL,
    subtotal double precision NOT NULL,
    impuesto double precision NOT NULL,
    descuento double precision NOT NULL,
    total double precision NOT NULL,
    CONSTRAINT factura_pkey PRIMARY KEY (id_factura)
);

CREATE TABLE IF NOT EXISTS public.kardex
(
    id_kardex integer NOT NULL DEFAULT nextval('kardex_id_kardex_seq'::regclass),
    id_producto integer NOT NULL,
    usuario_editor integer NOT NULL,
    nombre_operacion character varying(45) COLLATE pg_catalog."default" NOT NULL,
    producto character varying(45) COLLATE pg_catalog."default" NOT NULL,
    cantidad integer NOT NULL,
    costo double precision NOT NULL,
    precio double precision NOT NULL,
    fecha timestamp without time zone NOT NULL,
    proyecto_inventario_antes integer NOT NULL,
    proyecto_inventario_despues integer NOT NULL,
    CONSTRAINT kardex_pkey PRIMARY KEY (id_kardex)
);

CREATE TABLE IF NOT EXISTS public.privilegio
(
    id_privilegio integer NOT NULL,
    nombre character varying(45) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT privilegio_pkey PRIMARY KEY (id_privilegio)
);

CREATE TABLE IF NOT EXISTS public.producto
(
    id_producto integer NOT NULL DEFAULT nextval('producto_id_producto_seq'::regclass),
    id_usuario integer NOT NULL,
    nombre character varying(45) COLLATE pg_catalog."default" NOT NULL,
    costo double precision NOT NULL,
    categoria character varying(45) COLLATE pg_catalog."default" NOT NULL,
    marca character varying(45) COLLATE pg_catalog."default" NOT NULL,
    precio double precision NOT NULL,
    existencia_min integer NOT NULL,
    existencia_max integer NOT NULL,
    estado smallint NOT NULL,
    CONSTRAINT producto_pkey PRIMARY KEY (id_producto)
);

CREATE TABLE IF NOT EXISTS public.proveedor
(
    id_proveedor integer NOT NULL DEFAULT nextval('proveedor_id_proveedor_seq'::regclass),
    nombre character varying(45) COLLATE pg_catalog."default" NOT NULL,
    direccion character varying(45) COLLATE pg_catalog."default" NOT NULL,
    telefono character varying(45) COLLATE pg_catalog."default" NOT NULL,
    nombre_contacto_principal character varying(45) COLLATE pg_catalog."default" NOT NULL,
    estado smallint NOT NULL,
    id_usuario integer NOT NULL,
    CONSTRAINT proveedor_pkey PRIMARY KEY (id_proveedor)
);

CREATE TABLE IF NOT EXISTS public.rol
(
    id_rol integer NOT NULL,
    nombre character varying(45) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT rol_pkey PRIMARY KEY (id_rol)
);

CREATE TABLE IF NOT EXISTS public.rol_privilegio
(
    id_rol integer NOT NULL,
    id_privilegio integer NOT NULL,
    CONSTRAINT rol_privilegio_pkey PRIMARY KEY (id_rol, id_privilegio)
);

CREATE TABLE IF NOT EXISTS public.usuario
(
    id_usuario integer NOT NULL,
    nombre character varying(45) COLLATE pg_catalog."default" NOT NULL,
    apellido character varying(45) COLLATE pg_catalog."default" NOT NULL,
    email character varying(50) COLLATE pg_catalog."default" NOT NULL,
    nombre_usuario character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario)
);

CREATE TABLE IF NOT EXISTS public.usuario_rol
(
    id_usuario integer NOT NULL,
    id_rol integer NOT NULL,
    CONSTRAINT usuario_rol_pkey PRIMARY KEY (id_usuario, id_rol)
);

ALTER TABLE IF EXISTS public.ajuste
    ADD CONSTRAINT fk_ajuste_usuario FOREIGN KEY (id_usuario)
    REFERENCES public.usuario (id_usuario) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;
CREATE INDEX IF NOT EXISTS ajuste_fk_ajuste_usuario_idx
    ON public.ajuste(id_usuario);


ALTER TABLE IF EXISTS public.cliente
    ADD CONSTRAINT fk_cliente_usuario FOREIGN KEY (id_usuario)
    REFERENCES public.usuario (id_usuario) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;
CREATE INDEX IF NOT EXISTS cliente_fk_cliente_usuario_idx
    ON public.cliente(id_usuario);


ALTER TABLE IF EXISTS public.compra
    ADD CONSTRAINT fk_compra_usuario FOREIGN KEY (id_usuario)
    REFERENCES public.usuario (id_usuario) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;
CREATE INDEX IF NOT EXISTS compra_fk_compra_usuario_idx
    ON public.compra(id_usuario);


ALTER TABLE IF EXISTS public.compra
    ADD CONSTRAINT fk_proveedor_compra_p FOREIGN KEY (id_proveedor)
    REFERENCES public.proveedor (id_proveedor) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;
CREATE INDEX IF NOT EXISTS compra_fk_proveedor_compra_p_idx
    ON public.compra(id_proveedor);


ALTER TABLE IF EXISTS public.detalle_ajuste
    ADD CONSTRAINT fk_ajuste_detalle_ajuste FOREIGN KEY (id_ajuste)
    REFERENCES public.ajuste (id_ajuste) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;
CREATE INDEX IF NOT EXISTS detalle_ajuste_fk_ajuste_detalle_ajuste_idx
    ON public.detalle_ajuste(id_ajuste);


ALTER TABLE IF EXISTS public.detalle_ajuste
    ADD CONSTRAINT fk_detalle_ajuste_producto FOREIGN KEY (id_producto)
    REFERENCES public.producto (id_producto) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;
CREATE INDEX IF NOT EXISTS detalle_ajuste_fk_detalle_ajuste_producto_idx
    ON public.detalle_ajuste(id_producto);


ALTER TABLE IF EXISTS public.detalle_compra
    ADD CONSTRAINT fk_compra_detalle_compra FOREIGN KEY (id_compra)
    REFERENCES public.compra (id_compra) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;
CREATE INDEX IF NOT EXISTS detalle_compra_fk_compra_detalle_compra_idx
    ON public.detalle_compra(id_compra);


ALTER TABLE IF EXISTS public.detalle_compra
    ADD CONSTRAINT fk_detalle_compra_producto FOREIGN KEY (id_producto)
    REFERENCES public.producto (id_producto) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;
CREATE INDEX IF NOT EXISTS detalle_compra_fk_detalle_compra_producto_idx
    ON public.detalle_compra(id_producto);


ALTER TABLE IF EXISTS public.detalle_factura
    ADD CONSTRAINT fk_detalle_factura_producto FOREIGN KEY (id_producto)
    REFERENCES public.producto (id_producto) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;
CREATE INDEX IF NOT EXISTS detalle_factura_fk_detalle_factura_producto_idx
    ON public.detalle_factura(id_producto);


ALTER TABLE IF EXISTS public.detalle_factura
    ADD CONSTRAINT fk_factura_detalle_factura FOREIGN KEY (id_factura)
    REFERENCES public.factura (id_factura) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;
CREATE INDEX IF NOT EXISTS detalle_factura_fk_factura_detalle_factura_idx
    ON public.detalle_factura(id_factura);


ALTER TABLE IF EXISTS public.factura
    ADD CONSTRAINT fk_factura_cliente FOREIGN KEY (id_cliente)
    REFERENCES public.cliente (id_cliente) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;
CREATE INDEX IF NOT EXISTS factura_fk_factura_cliente1_idx
    ON public.factura(id_cliente);


ALTER TABLE IF EXISTS public.factura
    ADD CONSTRAINT fk_factura_usuario FOREIGN KEY (id_usuario)
    REFERENCES public.usuario (id_usuario) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;
CREATE INDEX IF NOT EXISTS factura_fk_factura_usuario_idx
    ON public.factura(id_usuario);


ALTER TABLE IF EXISTS public.kardex
    ADD CONSTRAINT fk_kardex_producto FOREIGN KEY (id_producto)
    REFERENCES public.producto (id_producto) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;
CREATE INDEX IF NOT EXISTS kardex_fk_kardex_producto1_idx
    ON public.kardex(id_producto);


ALTER TABLE IF EXISTS public.kardex
    ADD CONSTRAINT fk_kardex_usuario FOREIGN KEY (usuario_editor)
    REFERENCES public.usuario (id_usuario) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;
CREATE INDEX IF NOT EXISTS kardex_fk_kardex_usuario_idx
    ON public.kardex(usuario_editor);


ALTER TABLE IF EXISTS public.producto
    ADD CONSTRAINT fk_producto_usuario FOREIGN KEY (id_usuario)
    REFERENCES public.usuario (id_usuario) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;
CREATE INDEX IF NOT EXISTS producto_fk_producto_usuario_idx
    ON public.producto(id_usuario);


ALTER TABLE IF EXISTS public.proveedor
    ADD CONSTRAINT fk_proveedor_usuario FOREIGN KEY (id_usuario)
    REFERENCES public.usuario (id_usuario) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;
CREATE INDEX IF NOT EXISTS proveedor_fk_proveedor_usuario_idx
    ON public.proveedor(id_usuario);


ALTER TABLE IF EXISTS public.rol_privilegio
    ADD CONSTRAINT fk_id_privilegio FOREIGN KEY (id_privilegio)
    REFERENCES public.privilegio (id_privilegio) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;
CREATE INDEX IF NOT EXISTS rol_privilegio_fk_id_privilegio_idx
    ON public.rol_privilegio(id_privilegio);


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
CREATE INDEX IF NOT EXISTS usuario_rol_fk_id_rol_usuario_idx
    ON public.usuario_rol(id_rol);


ALTER TABLE IF EXISTS public.usuario_rol
    ADD CONSTRAINT fk_id_usuario FOREIGN KEY (id_usuario)
    REFERENCES public.usuario (id_usuario) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

END;
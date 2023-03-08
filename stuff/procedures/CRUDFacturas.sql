CREATE PROCEDURE sp_factura_create(
	sp_usuario_creador character varying(50),
	sp_subtotal double precision,
	sp_porcentaje_descuento double precision
) LANGUAGE 'plpgsql' BEGIN ATOMIC DECLARE sp_impuesto double precision := sp_subtotal * 0.15;

DECLARE sp_descuento double precision := sp_subtotal * (sp_porcentaje_descuento / 100);

DECLARE sp_total double precision := sp_subtotal + sp_impuesto - sp_descuento;

INSERT INTO
	factura(
		usuario_creador,
		subtotal,
		impuesto,
		descuento,
		total
	)
VALUES
	(
		sp_usuario_creador,
		sp_subtotal,
		sp_impuesto,
		sp_descuento,
		sp_total
	);

END;

CREATE PROCEDURE sp_factura_create(
	IN sp_usuario_creador character varying(50),
	IN sp_subtotal double precision,
	IN sp_porcentaje_descuento double precision
) 
LANGUAGE plpgsql
AS $$

DECLARE 
	sp_impuesto double precision := sp_subtotal * 0.15;
	sp_descuento double precision := sp_subtotal * (sp_porcentaje_descuento / 100);
	sp_total double precision := sp_subtotal + sp_impuesto - sp_descuento;
BEGIN
INSERT INTO
	factura(
		usuario_creador,
		subtotal,
		impuesto,
		descuento,
		total
	)
VALUES
	(
		sp_usuario_creador,
		sp_subtotal,
		sp_impuesto,
		sp_descuento,
		sp_total
	);
END;
$$;


-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_factura_read(sp_id_factura integer) LANGUAGE SQL BEGIN ATOMIC
SELECT
	*
FROM
	factura
WHERE
	id_factura = sp_id_factura;

END;

CALL sp_read_factura(1);

CREATE PROCEDURE sp_factura_read(
	sp_id_factura integer,
	get_result IN OUT refcursor
) LANGUAGE 'plpgsql' AS $ BODY $ BEGIN open get_result for
SELECT
	*
FROM
	factura
WHERE
	id_factura = sp_id_factura;

END $ BODY $;

CREATE OR REPLACE FUNCTION sp_factura_read(sp_id_factura integer)
RETURNS TABLE(id_factura integer, id_cliente integer, usuario_creador varchar, subtotal double precision, impuesto double precision, descuento double precision, total double precision, usuario_modificador varchar, fecha_creacion TIMESTAMP, fecha_modificacion TIMESTAMP)
LANGUAGE 'plpgsql'

AS $BODY$
BEGIN
RETURN QUERY
	SELECT * FROM factura WHERE id_factura = sp_id_factura;
END;
$BODY$


-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE OR REPLACE PROCEDURE sp_factura_update(
  IN sp_id_factura integer,
  IN sp_subtotal double precision,
  IN sp_porcentaje_descuento double precision,
  IN sp_usuario_modificador character varying(50)
)
LANGUAGE plpgsql
AS $$
DECLARE
  sp_impuesto double precision := sp_subtotal * 0.15;
  sp_descuento double precision := sp_subtotal * (sp_porcentaje_descuento / 100);
  sp_total double precision := sp_subtotal + sp_impuesto - sp_descuento;
BEGIN
  UPDATE factura
  SET subtotal = sp_subtotal,
      impuesto = sp_impuesto,
      descuento = sp_descuento,
      usuario_modificador = sp_usuario_modificador,
      fecha_modificacion = now(),
      total = sp_total
  WHERE id_factura = sp_id_factura;
END;
$$;

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_factura_delete(sp_id_factura integer) LANGUAGE SQL BEGIN ATOMIC
DELETE FROM
	factura
WHERE
	id_factura = sp_id_factura RETURNING *;

END;
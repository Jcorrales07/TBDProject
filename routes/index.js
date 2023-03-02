const express = require('express');

const ajustesRouter = require('./ajuste.router');
const clientesRouter = require('./clientes.router');
const comprasRouter = require('./compras.router');
const facturasRouter = require('./facturas.router');
const kardexRouter = require('./kardex.router');
const privilegiosRouter = require('./privilegio.router');
const productosRouter = require('./productos.router');
const proveedoresRouter = require('./proveedores.router');
const rolesRouter = require('./rol.router');
const usuariosRouter = require('./usuarios.router');

function routerApi(app) {
    const router = express.Router();
    app.use('/api/v1', router);

    router.use('/ajustes', ajustesRouter);
    router.use('/clientes', clientesRouter);
    router.use('/compras', comprasRouter);
    router.use('/facturas', facturasRouter);
    router.use('/kardex', kardexRouter);
    router.use('/privilegios', privilegiosRouter);
    router.use('/productos', productosRouter);
    router.use('/proveedores', proveedoresRouter);
    router.use('/roles', rolesRouter);
    router.use('/usuarios', usuariosRouter);
}

module.exports = routerApi;

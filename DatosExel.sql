INSERT INTO Proveedores (Nombre)
VALUES ('TRUPPER');


INSERT INTO Descuentos (Categoria, Porcentaje) VALUES 
('PrecioNormal', 0.00),
('PUBLICO1', 0.00),
('HERRERO2', 0.00),
('HERRERO3', 0.00),
('HERRERO4', 0.00),
('MAYOREO1', 0.00),
('MAYOREO2', 0.00),
('LABB', 0.00);

INSERT INTO Categorias (Nombre) VALUES
('ANGULO'),
('Angulo Lig'),
('CUADRADO'),
('REDONDO'),
('TORCIDO'),
('SOLERA'),
('TEE'),
('MONTEN'),
('PTR'),
('TUBO CED.30'),
('TUBO CED.40'),
('TUBO GALV'),
('Base Tinaco'),
('TUB. C20'),
('TABLEROS'),
('MOFLERO'),
('T.INDUSTRIAL'),
('TABULAR'),
('TABULAR ZINTRO'),
('TABULAR C.20'),
('Espiral Redondo'),
('Espiral Cuadrado');


ALTER TABLE Productos DROP CONSTRAINT chk_Precios;

ALTER TABLE Productos
DROP COLUMN PrecioVenta;

ALTER TABLE Productos
ADD COLUMN Peso1 DECIMAL(10,2),
ADD COLUMN Peso2 DECIMAL(10,2),
ADD COLUMN PesoTotal DECIMAL(10,2);

ALTER TABLE Productos
ADD COLUMN `C.extra` FLOAT NULL;

DELIMITER $$

CREATE TRIGGER trg_insert_calcular_peso_total
BEFORE INSERT ON Productos
FOR EACH ROW
BEGIN
    IF NEW.Peso1 IS NULL AND NEW.Peso2 IS NULL THEN
        SET NEW.PesoTotal = NULL;
    ELSEIF NEW.Peso1 IS NULL THEN
        SET NEW.PesoTotal = NEW.Peso2;
    ELSEIF NEW.Peso2 IS NULL THEN
        SET NEW.PesoTotal = NEW.Peso1;
    ELSE
        SET NEW.PesoTotal = (NEW.Peso1 + NEW.Peso2) / 2.0;
    END IF;
END$$

CREATE TRIGGER trg_update_calcular_peso_total
BEFORE UPDATE ON Productos
FOR EACH ROW
BEGIN
    IF NEW.Peso1 IS NULL AND NEW.Peso2 IS NULL THEN
        SET NEW.PesoTotal = NULL;
    ELSEIF NEW.Peso1 IS NULL THEN
        SET NEW.PesoTotal = NEW.Peso2;
    ELSEIF NEW.Peso2 IS NULL THEN
        SET NEW.PesoTotal = NEW.Peso1;
    ELSE
        SET NEW.PesoTotal = (NEW.Peso1 + NEW.Peso2) / 2.0;
    END IF;
END$$

DELIMITER ;

Modificar en Trigger ProductoUpdateBefore,ya lo deje corregido




INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('3x6 C-16',0,0,4515590060655,8,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('4x6 C-16',0,0,6166503700405,8,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('3x6',0,0,1523908016643,8,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('4x4',0,0,3584606383208,8,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('4x5',0,0,4572751331790,8,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('4x6',0,0,8674505804299,8,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('5x5',0,0,4704431387273,8,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('5x6',0,0,3751986399240,8,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('6x6',0,0,3484440050120,8,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('8x6',0,0,1689113556587,8,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('8x8',0,0,6069966188040,8,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('10x10',0,0,1776398702155,8,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('3/4',0,0,5129059531539,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('1 C13',0,0,6108853781775,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('1 C14',0,0,5797663511565,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('1 C16',0,0,6326190065643,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('1 1/4 C13',0,0,8836008348330,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('1 1/4 C14',0,0,2468574198507,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('1 1/4 C16',0,0,3627778113344,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('1 1/2 C12',0,0,7059137116755,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('1 1/2 C14',0,0,6344499382448,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('1 1/2 C16',0,0,5596223034888,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('2 C12',0,0,9242268160602,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('2 C14',0,0,4635264936761,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('2" C16',0,0,7120052642655,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('2X1 C14',0,0,8413701921980,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('2 x 1" C16',0,0,6848898999034,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('2 1/2 C11',0,0,5303288578672,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('2 1/2 C14',0,0,9886781389545,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('2-1/2 x 1-1/2 C-14',0,0,7451142884225,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('3 C8',0,0,3896039751738,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('3 C11',0,0,9125150806108,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('3 C14',0,0,6163609384052,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('3 1/2 C10',0,0,4319850343819,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('3 1/2 C11',0,0,3483324149607,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('3 X 1 1/2 C14',0,0,3501445469625,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('3X2 C11',0,0,6957491972499,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('3 x 2 C-14',0,0,6244401967252,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('4 C11',0,0,7556953773178,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('4 C14',0,0,4325609637849,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('4x11/2 C-14',0,0,5408898956091,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('4 x 2 C-11',0,0,9868077481255,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('4 X 2 C14',0,0,5996018599459,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('6 x 2 C-14',0,0,1791283085905,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('PTR galv 1 1/2',0,0,9281016652356,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('PTR galv   1 3/4',0,0,8187315704691,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('PTR galv    2',0,0,7072691038543,9,1);

INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('1/2 X 30',0,0,2562569966664,9,1);

INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('1/2',0,0,6078547227816,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('3/4',0,0,6208789793367,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('1',0,0,8369846067505,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('1 1/4',0,0,6788764883520,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('1 1/2',0,0,6370954376383,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('2',0,0,2447648244987,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('2 1/2',0,0,7761231600939,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('3',0,0,3451879513850,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('4',0,0,1762607127944,9,1);


INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('TUBO CED. 40',0,0,5052207453168,9,1);


INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('1',0,0,1329841079482,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('3',0,0,5286115402070,9,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('1 3/8',0,0,5279925780175,12,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('1 1/2',0,0,2649391201618,12,1);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('2',0,0,5844750443612,12,1);


INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (1, 2, 501.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (1, 3, 496.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (1, 4, 494.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (1, 5, 492.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (2, 2, 668.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (2, 3, 662.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (2, 4, 659.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (2, 5, 656.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (3, 2, 603.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (3, 3, 598.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (3, 4, 595.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (3, 5, 592.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (4, 2, 528.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (4, 3, 523.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (4, 4, 521.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (4, 5, 518.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (5, 2, 673.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (5, 3, 667.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (5, 4, 664.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (5, 5, 661.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (6, 2, 788.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (6, 3, 781.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (6, 4, 778.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (6, 5, 774.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (7, 2, 728.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (7, 3, 721.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (7, 4, 718.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (7, 5, 715.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (8, 2, 856.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (8, 3, 848.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (8, 4, 844.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (8, 5, 840.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (9, 2, 983.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (9, 3, 974.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (9, 4, 970.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (9, 5, 965.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (10, 2, 1310.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (10, 3, 1298.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (10, 4, 1292.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (10, 5, 1286.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (11, 2, 1752.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (11, 3, 1736.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (11, 4, 1729.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (11, 5, 1721.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (12, 2, 2464.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (12, 3, 2442.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (12, 4, 2431.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (12, 5, 2420.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (13, 2, 253.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (13, 3, 251.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (13, 4, 250.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (13, 5, 249.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (14, 2, 414.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (14, 3, 411.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (14, 4, 409.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (14, 5, 407.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (15, 2, 353.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (15, 3, 350.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (15, 4, 349.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (15, 5, 347.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (16, 2, 289.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (16, 3, 287.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (16, 4, 285.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (16, 5, 284.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (17, 2, 517.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (17, 3, 512.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (17, 4, 510.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (17, 5, 508.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (18, 2, 425.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (18, 3, 421.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (18, 4, 419.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (18, 5, 417.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (19, 2, 360.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (19, 3, 357.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (19, 4, 355.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (19, 5, 353.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (20, 2, 729.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (20, 3, 722.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (20, 4, 719.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (20, 5, 716.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (21, 2, 521.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (21, 3, 517.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (21, 4, 514.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (21, 5, 512.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (22, 2, 440.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (22, 3, 436.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (22, 4, 434.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (22, 5, 432.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (23, 2, 966.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (23, 3, 958.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (23, 4, 953.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (23, 5, 949.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (24, 2, 715.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (24, 3, 708.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (24, 4, 705.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (24, 5, 702.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (25, 2, 605.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (25, 3, 599.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (25, 4, 597.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (25, 5, 594.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (26, 2, 512.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (26, 3, 508.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (26, 4, 506.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (26, 5, 503.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (27, 2, 437.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (27, 3, 433.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (27, 4, 431.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (27, 5, 429.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (28, 2, 1347.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (28, 3, 1335.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (28, 4, 1329.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (28, 5, 1322.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (29, 2, 854.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (29, 3, 846.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (29, 4, 842.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (29, 5, 838.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (30, 2, 707.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (30, 3, 701.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (30, 4, 698.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (30, 5, 695.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (31, 2, 2138.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (31, 3, 2119.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (31, 4, 2110.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (31, 5, 2100.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (32, 2, 1652.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (32, 3, 1637.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (32, 4, 1629.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (32, 5, 1622.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (33, 2, 1070.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (33, 3, 1060.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (33, 4, 1056.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (33, 5, 1051.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (34, 2, 2420.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (34, 3, 2398.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (34, 4, 2387.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (34, 5, 2376.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (35, 2, 1897.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (35, 3, 1880.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (35, 4, 1872.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (35, 5, 1863.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (36, 2, 811.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (36, 3, 803.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (36, 4, 800.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (36, 5, 796.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (37, 2, 1365.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (37, 3, 1352.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (37, 4, 1346.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (37, 5, 1340.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (38, 2, 874.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (38, 3, 866.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (38, 4, 862.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (38, 5, 858.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (39, 2, 2268.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (39, 3, 2247.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (39, 4, 2237.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (39, 5, 2227.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (40, 2, 1417.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (40, 3, 1404.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (40, 4, 1398.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (40, 5, 1391.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (41, 2, 986.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (41, 3, 977.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (41, 4, 973.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (41, 5, 968.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (42, 2, 1641.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (42, 3, 1627.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (42, 4, 1619.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (42, 5, 1612.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (43, 2, 1022.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (43, 3, 1013.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (43, 4, 1009.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (43, 5, 1004.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (44, 2, 1461.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (44, 3, 1448.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (44, 4, 1442.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (44, 5, 1435.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (45, 2, 641.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (45, 3, 635.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (45, 4, 632.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (45, 5, 629.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (46, 2, 751.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (46, 3, 745.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (46, 4, 741.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (46, 5, 738.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (47, 2, 878.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (47, 3, 870.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (47, 4, 866.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (47, 5, 862.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (49, 2, 225.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (49, 3, 223.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (49, 4, 222.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (49, 5, 221.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (50, 2, 279.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (50, 3, 276.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (50, 4, 275.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (50, 5, 274.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (51, 2, 352.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (51, 3, 349.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (51, 4, 347.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (51, 5, 345.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (52, 2, 559.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (52, 3, 554.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (52, 4, 552.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (52, 5, 549.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (53, 2, 643.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (53, 3, 638.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (53, 4, 635.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (53, 5, 632.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (54, 2, 926.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (54, 3, 917.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (54, 4, 913.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (54, 5, 909.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (55, 2, 1265.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (55, 3, 1254.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (55, 4, 1248.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (55, 5, 1242.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (56, 2, 1600.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (56, 3, 1586.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (56, 4, 1579.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (56, 5, 1571.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (57, 2, 2014.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (57, 3, 1996.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (57, 4, 1987.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (57, 5, 1978.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (59, 2, 660.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (59, 3, 654.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (59, 4, 651.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (59, 5, 648.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (60, 2, 3167.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (60, 3, 3139.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (60, 4, 3124.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (60, 5, 3110.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (61, 2, 223.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (61, 3, 221.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (61, 4, 220.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (61, 5, 219.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (62, 2, 344.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (62, 3, 341.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (62, 4, 339.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (62, 5, 338.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (63, 2, 440.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (63, 3, 436.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (63, 4, 434.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (63, 5, 432.0);

INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('1/2', 0, 0, 1000000000001, 17, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (1, 2, 107.0), (1, 3, 106.0), (1, 4, 105.0), (1, 5, 105.0), (1, 6, 104.0), (1, 7, 104.0);

INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('5/8" C18', 0, 0, 1000000000002, 17, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (2, 2, 135.0), (2, 3, 134.0), (2, 4, 134.0), (2, 5, 133.0), (2, 6, 132.0), (2, 7, 132.0);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('3/4" C18', 0, 0, 1000000000003, 16, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (3, 2, 143.0), (3, 3, 142.0), (3, 4, 141.0), (3, 5, 141.0), (3, 6, 140.0), (3, 7, 139.0);

INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('1" C16', 0, 0, 1000000000004, 16, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (4, 2, 240.0), (4, 3, 238.0), (4, 4, 236.0), (4, 5, 235.0), (4, 6, 234.0), (4, 7, 233.0);

INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('1" C18', 0, 0, 1000000000005, 16, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (5, 2, 192.0), (5, 3, 191.0), (5, 4, 190.0), (5, 5, 189.0), (5, 6, 188.0), (5, 7, 187.0);

INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('Chico 3 X 3', 0, 0, 1000000000006, 15, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (6, 2, 265.0), (6, 3, 262.0), (6, 4, 261.0), (6, 5, 260.0), (6, 6, 259.0), (6, 7, 258.0);

INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('Grande 3 X 10', 0, 0, 1000000000007, 15, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (7, 2, 878.0), (7, 3, 870.0), (7, 4, 866.0), (7, 5, 862.0), (7, 6, 858.0), (7, 7, 854.0);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('101', 0, 0, 1000000000008, 14, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (8, 2, 239.0), (8, 3, 237.0), (8, 4, 236.0), (8, 5, 235.0), (8, 6, 234.0), (8, 7, 233.0);

INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('103', 0, 0, 1000000000009, 14, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (9, 2, 282.0), (9, 3, 280.0), (9, 4, 278.0), (9, 5, 277.0), (9, 6, 276.0), (9, 7, 275.0);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('Base tinaco', 0, 0, 1000000000010, 13, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (10, 2, 1962.0), (10, 3, 1936.0), (10, 4, 1919.0), (10, 5, 1906.0), (10, 6, 1893.0), (10, 7, 1879.0);

INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('1-1/4" C18', 0, 0, 1000000000011, 16, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (11, 2, 249), (11, 3, 248), (11, 4, 247), (11, 5, 246), (11, 6, 245), (11, 7, 244);


INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('1-1/2" C18', 0, 0, 1000000000012, 16, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (12, 2, 299), (12, 3, 296), (12, 4, 295), (12, 5, 293), (12, 6, 292), (12, 7, 291);


INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('2 C16', 0, 0, 1000000000013, 16, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (13, 2, 0), (13, 3, 0), (13, 4, 0), (13, 5, 0), (13, 6, 0), (13, 7, 0);


INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('2" C18', 0, 0, 1000000000014, 16, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (14, 2, 394), (14, 3, 390), (14, 4, 388), (14, 5, 387), (14, 6, 385), (14, 7, 383);


INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('3" C18', 0, 0, 1000000000015, 16, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (15, 2, 605), (15, 3, 600), (15, 4, 597), (15, 5, 594), (15, 6, 591), (15, 7, 589);


INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('1/2 x 1/2 C 18', 0, 0, 1000000000016, 18, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (16, 2, 117), (16, 3, 116), (16, 4, 115), (16, 5, 114), (16, 6, 113), (16, 7, 112);


INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('1/2 x 1/2 C 20', 0, 0, 1000000000017, 18, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (17, 2, 110), (17, 3, 109), (17, 4, 108), (17, 5, 107), (17, 6, 106), (17, 7, 105);


INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('3/4 x 3/4 C 18', 0, 0, 1000000000018, 18, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (18, 2, 146), (18, 3, 145), (18, 4, 144), (18, 5, 143), (18, 6, 142), (18, 7, 141);


INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('1 x 1 C 18', 0, 0, 1000000000019, 18, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (19, 2, 176), (19, 3, 175), (19, 4, 174), (19, 5, 173), (19, 6, 172), (19, 7, 171);


INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('1 x 1 C 20', 0, 0, 1000000000020, 18, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (20, 2, 159), (20, 3, 158), (20, 4, 157), (20, 5, 156), (20, 6, 155), (20, 7, 154);

INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('1 x 1/2 C 18', 0, 0, 1000000000021, 18, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (21, 2, 158), (21, 3, 157), (21, 4, 156), (21, 5, 155), (21, 6, 154), (21, 7, 153);


INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('1 x 1/2 C 20', 0, 0, 1000000000022, 18, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (22, 2, 146), (22, 3, 145), (22, 4, 144), (22, 5, 143), (22, 6, 142), (22, 7, 141);


INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('1-1/4 x 1-1/4 C 18', 0, 0, 1000000000023, 18, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (23, 2, 205), (23, 3, 203), (23, 4, 201), (23, 5, 199), (23, 6, 197), (23, 7, 195);

INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('P200', 0, 0, 1000000000024, 18, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (24, 2, 477), (24, 3, 472), (24, 4, 470), (24, 5, 468), (24, 6, 466), (24, 7, 464);


INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('P250', 0, 0, 1000000000025, 18, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (25, 2, 541), (25, 3, 536), (25, 4, 534), (25, 5, 531), (25, 6, 529), (25, 7, 527);


INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('P300', 0, 0, 1000000000026, 18, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (26, 2, 598), (26, 3, 593), (26, 4, 590), (26, 5, 588), (26, 6, 585), (26, 7, 582);

INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('P400', 0, 0, 1000000000027, 18, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (27, 2, 723), (27, 3, 717), (27, 4, 714), (27, 5, 710), (27, 6, 707), (27, 7, 704);


INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('R100', 0, 0, 1000000000028, 18, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (28, 2, 181), (28, 3, 179), (28, 4, 179), (28, 5, 178), (28, 6, 177), (28, 7, 176);


INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('R125', 0, 0, 1000000000029, 18, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (29, 2, 247), (29, 3, 245), (29, 4, 244), (29, 5, 242), (29, 6, 241), (29, 7, 240);


INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('R150', 0, 0, 1000000000030, 18, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (30, 2, 243), (30, 3, 241), (30, 4, 240), (30, 5, 239), (30, 6, 238), (30, 7, 237);

INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('R175', 0, 0, 1000000000031, 18, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (31, 2, 312), (31, 3, 310), (31, 4, 308), (31, 5, 307), (31, 6, 305), (31, 7, 304);


INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('R200', 0, 0, 1000000000032, 18, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (32, 2, 369), (32, 3, 366), (32, 4, 364), (32, 5, 363), (32, 6, 361), (32, 7, 359);


INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('R229', 0, 0, 1000000000033, 18, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (33, 2, 313), (33, 3, 310), (33, 4, 309), (33, 5, 307), (33, 6, 306), (33, 7, 304);

INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('R249', 0, 0, 1000000000034, 18, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (34, 2, 464), (34, 3, 460), (34, 4, 458), (34, 5, 456), (34, 6, 454), (34, 7, 452);


INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('R225', 0, 0, 1000000000035, 18, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (35, 2, 372), (35, 3, 369), (35, 4, 367), (35, 5, 366), (35, 6, 364), (35, 7, 362);


INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('R250', 0, 0, 1000000000036, 18, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (36, 2, 503), (36, 3, 499), (36, 4, 497), (36, 5, 494), (36, 6, 492), (36, 7, 490);


INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('R300', 0, 0, 1000000000037, 18, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (37, 2, 551), (37, 3, 546), (37, 4, 543), (37, 5, 541), (37, 6, 538), (37, 7, 536);


INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('R400', 0, 0, 1000000000038, 18, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (38, 2, 680), (38, 3, 674), (38, 4, 671), (38, 5, 668), (38, 6, 665), (38, 7, 662);


INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('K400 (3 MT)', 0, 0, 1000000000039, 18, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio)
VALUES (39, 2, 841), (39, 3, 833), (39, 4, 829), (39, 5, 825), (39, 6, 822), (39, 7, 818);

INSERT INTO Productos (Nombre, PrecioCompra, PrecioVenta, CodigoBarras, idCategoria, idProveedor)
VALUES 
('3/4 x 1/8', 0, 0, 1000000000001, 1, 1),
('1 x 1/8', 0, 0, 1000000000002, 1, 1),
('1 x 3/16', 0, 0, 1000000000003, 1, 1),
('1-1/4 x 1/8', 0, 0, 1000000000004, 1, 1),
('1-1/4 x 3/16', 0, 0, 1000000000005, 1, 1),
('1-1/4 x 1/4', 0, 0, 1000000000006, 1, 1),
('1-1/2 x 1/8', 0, 0, 1000000000007, 1, 1),
('1-1/2 x 3/16', 0, 0, 1000000000008, 1, 1),
('1-1/2 x 1/4', 0, 0, 1000000000009, 1, 1),
('2 x 1/8', 0, 0, 1000000000010, 1, 1),
('2 x 3/16', 0, 0, 1000000000011, 1, 1),
('2 x 1/4', 0, 0, 1000000000012, 1, 1),
('2-1/2 x 3/16', 0, 0, 1000000000013, 1, 1),
('2-1/2 x 1/4', 0, 0, 1000000000014, 1, 1),
('3 x 1/8', 0, 0, 1000000000015, 1, 1),
('3 x 3/16', 0, 0, 1000000000016, 1, 1),
('3 x 1/4', 0, 0, 1000000000017, 1, 1),
('4 x 3/16', 0, 0, 1000000000018, 1, 1);


INSERT INTO Productos (Nombre, PrecioCompra, PrecioVenta, CodigoBarras, idCategoria, idProveedor)
VALUES 
('3/4 x 109', 0, 0, 1000000000019, 2, 1),
('1 x 109', 0, 0, 1000000000020, 2, 1),
('1-1/4 x 109', 0, 0, 1000000000021, 2, 1),
('1-1/2 x 109', 0, 0, 1000000000022, 2, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (1, 2, 136);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (1, 3, 178);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (1, 4, 177);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (1, 5, 175);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (1, 6, 173);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (1, 7, 172);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (2, 2, 170);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (2, 3, 223);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (2, 4, 221);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (2, 5, 219);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (2, 6, 217);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (2, 7, 215);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (3, 2, 244);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (3, 3, 320);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (3, 4, 317);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (3, 5, 314);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (3, 6, 312);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (3, 7, 309);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (4, 2, 214);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (4, 3, 281);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (4, 4, 278);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (4, 5, 276);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (4, 6, 273);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (4, 7, 271);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (5, 2, 302);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (5, 3, 396);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (5, 4, 393);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (5, 5, 389);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (5, 6, 386);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (5, 7, 382);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (6, 2, 387);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (6, 3, 507);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (6, 4, 502);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (6, 5, 498);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (6, 6, 494);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (6, 7, 491);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (7, 2, 261);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (7, 3, 341);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (7, 4, 338);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (7, 5, 335);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (7, 6, 332);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (7, 7, 329);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (8, 2, 392);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (8, 3, 514);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (8, 4, 509);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (8, 5, 505);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (8, 6, 500);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (8, 7, 496);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (9, 2, 564);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (9, 3, 740);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (9, 4, 733);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (9, 5, 727);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (9, 6, 722);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (9, 7, 714);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (10, 2, 377);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (10, 3, 493);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (10, 4, 489);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (10, 5, 485);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (10, 6, 480);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (10, 7, 476);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (11, 2, 525);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (11, 3, 688);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (11, 4, 682);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (11, 5, 676);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (11, 6, 670);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (11, 7, 663);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (12, 2, 724);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (12, 3, 949);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (12, 4, 940);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (12, 5, 932);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (12, 6, 925);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (12, 7, 915);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (13, 2, 697);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (13, 3, 913);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (13, 4, 905);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (13, 5, 897);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (13, 6, 889);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (13, 7, 885);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (14, 2, 915);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (14, 3, 1199);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (14, 4, 1189);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (14, 5, 1178);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (14, 6, 1168);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (14, 7, 1157);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (15, 2, 564);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (15, 3, 740);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (15, 4, 733);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (15, 5, 727);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (15, 6, 720);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (15, 7, 714);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (16, 2, 834);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (16, 3, 1093);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (16, 4, 1084);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (16, 5, 1074);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (16, 6, 1065);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (16, 7, 1055);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (17, 2, 1087);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (17, 3, 1424);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (17, 4, 1412);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (17, 5, 1399);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (17, 6, 1387);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (17, 7, 1374);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (18, 2, 1483);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (18, 3, 1943);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (18, 4, 1926);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (18, 5, 1909);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (18, 6, 1892);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (18, 7, 1875);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (19, 2, 117);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (19, 3, 153);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (19, 4, 152);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (19, 5, 150);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (19, 6, 149);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (19, 7, 147);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (20, 2, 147);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (20, 3, 192);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (20, 4, 191);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (20, 5, 189);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (20, 6, 186);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (20, 7, 184);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (21, 2, 187);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (21, 3, 246);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (21, 4, 243);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (21, 5, 241);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (21, 6, 238);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (21, 7, 237);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (22, 2, 234);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (22, 3, 306);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (22, 4, 303);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (22, 5, 301);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (22, 6, 298);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (22, 7, 295);


INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor) VALUES 
('3/8', 0, 0, 300000000001, 3, 1),
('12 mm', 0, 0, 300000000002, 3, 1),
('1/2', 0, 0, 300000000003, 3, 1),
('5/8', 0, 0, 300000000004, 3, 1),
('3/4', 0, 0, 300000000005, 3, 1),
('1"', 0, 0, 300000000006, 3, 1);

INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES 
(1, 2, 100), (1, 3, 130), (1, 4, 129), (1, 5, 128), (1, 6, 127), (1, 7, 126), (1, 8, 126),
(2, 2, 166), (2, 3, 213), (2, 4, 212), (2, 5, 210), (2, 6, 208), (2, 7, 207), (2, 8, 206),
(3, 2, 172), (3, 3, 226), (3, 4, 224), (3, 5, 222), (3, 6, 220), (3, 7, 219), (3, 8, 218),
(4, 2, 269), (4, 3, 353), (4, 4, 350), (4, 5, 346), (4, 6, 343), (4, 7, 342), (4, 8, 340),
(5, 2, 381), (5, 3, 500), (5, 4, 495), (5, 5, 491), (5, 6, 487), (5, 7, 484), (5, 8, 482),
(6, 2, 730), (6, 3, 957), (6, 4, 949), (6, 5, 940), (6, 6, 932), (6, 7, 927), (6, 8, 923);

INSERT INTO Productos (Nombre, PrecioCompra, PrecioVenta, CodigoBarras, idCategoria, idProveedor) VALUES ('3/16', 0, 0, 200000000094, 4, 1);
INSERT INTO Productos (Nombre, PrecioCompra, PrecioVenta, CodigoBarras, idCategoria, idProveedor) VALUES ('1/4', 0, 0, 200000000095, 4, 1);
INSERT INTO Productos (Nombre, PrecioCompra, PrecioVenta, CodigoBarras, idCategoria, idProveedor) VALUES ('5/16', 0, 0, 200000000096, 4, 1);
INSERT INTO Productos (Nombre, PrecioCompra, PrecioVenta, CodigoBarras, idCategoria, idProveedor) VALUES ('3/8', 0, 0, 200000000097, 4, 1);
INSERT INTO Productos (Nombre, PrecioCompra, PrecioVenta, CodigoBarras, idCategoria, idProveedor) VALUES ('1/2', 0, 0, 200000000098, 4, 1);
INSERT INTO Productos (Nombre, PrecioCompra, PrecioVenta, CodigoBarras, idCategoria, idProveedor) VALUES ('5/8', 0, 0, 200000000099, 4, 1);
INSERT INTO Productos (Nombre, PrecioCompra, PrecioVenta, CodigoBarras, idCategoria, idProveedor) VALUES ('3/4', 0, 0, 200000000100, 4, 1);
INSERT INTO Productos (Nombre, PrecioCompra, PrecioVenta, CodigoBarras, idCategoria, idProveedor) VALUES ('12MM', 0, 0, 200000000101, 4, 1);
INSERT INTO Productos (Nombre, PrecioCompra, PrecioVenta, CodigoBarras, idCategoria, idProveedor) VALUES ('1', 0, 0, 200000000102, 4, 1);

INSERT INTO Productos (Nombre, PrecioCompra, PrecioVenta, CodigoBarras, idCategoria, idProveedor) VALUES ('3/8', 0, 0, 200000000103, 5, 1);
INSERT INTO Productos (Nombre, PrecioCompra, PrecioVenta, CodigoBarras, idCategoria, idProveedor) VALUES ('12 MM', 0, 0, 200000000104, 5, 1);
INSERT INTO Productos (Nombre, PrecioCompra, PrecioVenta, CodigoBarras, idCategoria, idProveedor) VALUES ('1/2', 0, 0, 200000000105, 5, 1);
INSERT INTO Productos (Nombre, PrecioCompra, PrecioVenta, CodigoBarras, idCategoria, idProveedor) VALUES ('5/8', 0, 0, 200000000106, 5, 1);

INSERT INTO Productos (Nombre, PrecioCompra, PrecioVenta, CodigoBarras, idCategoria, idProveedor) VALUES ('3/8', 0, 0, 200000000088, 3, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (88, 2, 100.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (88, 3, 130.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (88, 4, 129.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (88, 5, 128.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (88, 6, 127.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (88, 7, 126.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (88, 8, 126.00);
INSERT INTO Productos (Nombre, PrecioCompra, PrecioVenta, CodigoBarras, idCategoria, idProveedor) VALUES ('12 mm', 0, 0, 200000000089, 3, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (89, 2, 166.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (89, 3, 213.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (89, 4, 212.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (89, 5, 210.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (89, 6, 208.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (89, 7, 207.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (89, 8, 206.00);
INSERT INTO Productos (Nombre, PrecioCompra, PrecioVenta, CodigoBarras, idCategoria, idProveedor) VALUES ('1/2', 0, 0, 200000000090, 3, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (90, 2, 172.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (90, 3, 226.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (90, 4, 224.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (90, 5, 222.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (90, 6, 220.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (90, 7, 219.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (90, 8, 218.00);
INSERT INTO Productos (Nombre, PrecioCompra, PrecioVenta, CodigoBarras, idCategoria, idProveedor) VALUES ('5/8', 0, 0, 200000000091, 3, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (91, 2, 269.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (91, 3, 353.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (91, 4, 350.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (91, 5, 346.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (91, 6, 343.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (91, 7, 342.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (91, 8, 340.00);
INSERT INTO Productos (Nombre, PrecioCompra, PrecioVenta, CodigoBarras, idCategoria, idProveedor) VALUES ('3/4', 0, 0, 200000000092, 3, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (92, 2, 381.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (92, 3, 500.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (92, 4, 495.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (92, 5, 491.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (92, 6, 487.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (92, 7, 484.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (92, 8, 482.00);
INSERT INTO Productos (Nombre, PrecioCompra, PrecioVenta, CodigoBarras, idCategoria, idProveedor) VALUES ('1"', 0, 0, 200000000093, 3, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (93, 2, 730.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (93, 3, 957.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (93, 4, 949.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (93, 5, 940.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (93, 6, 932.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (93, 7, 927.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (93, 8, 923.00);
INSERT INTO Productos (Nombre, PrecioCompra, PrecioVenta, CodigoBarras, idCategoria, idProveedor) VALUES ('3/16', 0, 0, 200000000094, 4, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (94, 2, 20.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (94, 3, 26.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (94, 4, 26.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (94, 5, 25.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (94, 6, 25.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (94, 7, 25.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (94, 8, 25.00);
INSERT INTO Productos (Nombre, PrecioCompra, PrecioVenta, CodigoBarras, idCategoria, idProveedor) VALUES ('1/4', 0, 0, 200000000095, 4, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (95, 2, 36.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (95, 3, 47.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (95, 4, 47.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (95, 5, 46.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (95, 6, 46.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (95, 7, 46.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (95, 8, 45.00);
INSERT INTO Productos (Nombre, PrecioCompra, PrecioVenta, CodigoBarras, idCategoria, idProveedor) VALUES ('5/16', 0, 0, 200000000096, 4, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (96, 2, 59.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (96, 3, 77.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (96, 4, 76.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (96, 5, 76.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (96, 6, 75.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (96, 7, 75.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (96, 8, 74.00);
INSERT INTO Productos (Nombre, PrecioCompra, PrecioVenta, CodigoBarras, idCategoria, idProveedor) VALUES ('3/8', 0, 0, 200000000097, 4, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (97, 2, 81.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (97, 3, 106.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (97, 4, 105.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (97, 5, 104.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (97, 6, 103.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (97, 7, 102.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (97, 8, 102.00);
INSERT INTO Productos (Nombre, PrecioCompra, PrecioVenta, CodigoBarras, idCategoria, idProveedor) VALUES ('1/2', 0, 0, 200000000098, 4, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (98, 2, 136.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (98, 3, 178.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (98, 4, 176.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (98, 5, 174.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (98, 6, 173.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (98, 7, 172.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (98, 8, 171.00);
INSERT INTO Productos (Nombre, PrecioCompra, PrecioVenta, CodigoBarras, idCategoria, idProveedor) VALUES ('5/8', 0, 0, 200000000099, 4, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (99, 2, 201.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (99, 3, 263.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (99, 4, 261.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (99, 5, 259.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (99, 6, 256.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (99, 7, 255.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (99, 8, 254.00);
INSERT INTO Productos (Nombre, PrecioCompra, PrecioVenta, CodigoBarras, idCategoria, idProveedor) VALUES ('3/4', 0, 0, 200000000100, 4, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (100, 2, 302.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (100, 3, 396.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (100, 4, 392.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (100, 5, 389.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (100, 6, 385.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (100, 7, 384.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (100, 8, 382.00);
INSERT INTO Productos (Nombre, PrecioCompra, PrecioVenta, CodigoBarras, idCategoria, idProveedor) VALUES ('12MM', 0, 0, 200000000101, 4, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (101, 2, 122.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (101, 3, 159.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (101, 4, 158.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (101, 5, 156.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (101, 6, 155.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (101, 7, 154.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (101, 8, 154.00);
INSERT INTO Productos (Nombre, PrecioCompra, PrecioVenta, CodigoBarras, idCategoria, idProveedor) VALUES ('1', 0, 0, 200000000102, 4, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (102, 2, 562.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (102, 3, 737.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (102, 4, 730.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (102, 5, 724.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (102, 6, 717.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (102, 7, 714.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (102, 8, 711.00);
INSERT INTO Productos (Nombre, PrecioCompra, PrecioVenta, CodigoBarras, idCategoria, idProveedor) VALUES ('3/8', 0, 0, 200000000103, 5, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (103, 2, 125.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (103, 3, 164.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (103, 4, 162.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (103, 5, 161.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (103, 6, 160.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (103, 7, 159.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (103, 8, 158.00);
INSERT INTO Productos (Nombre, PrecioCompra, PrecioVenta, CodigoBarras, idCategoria, idProveedor) VALUES ('12 MM', 0, 0, 200000000104, 5, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (104, 2, 166.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (104, 3, 218.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (104, 4, 216.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (104, 5, 214.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (104, 6, 211.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (104, 7, 210.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (104, 8, 210.00);
INSERT INTO Productos (Nombre, PrecioCompra, PrecioVenta, CodigoBarras, idCategoria, idProveedor) VALUES ('1/2', 0, 0, 200000000105, 5, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (105, 2, 184.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (105, 3, 241.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (105, 4, 239.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (105, 5, 237.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (105, 6, 235.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (105, 7, 234.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (105, 8, 232.00);
INSERT INTO Productos (Nombre, PrecioCompra, PrecioVenta, CodigoBarras, idCategoria, idProveedor) VALUES ('5/8', 0, 0, 200000000106, 5, 1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (106, 2, 287.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (106, 3, 377.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (106, 4, 373.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (106, 5, 370.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (106, 6, 367.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (106, 7, 365.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (106, 8, 363.00);

INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('1/2 x 1/8',0,0,978000000001,6,1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (1, 2, 53.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (1, 3, 68.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (1, 4, 68.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (1, 5, 67.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (1, 6, 66.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (1, 7, 66.00);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('1/2 x 3/16',0,0,978000000002,6,1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (2, 2, 75.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (2, 3, 98.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (2, 4, 97.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (2, 5, 96.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (2, 6, 95.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (2, 7, 94.00);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('1/2 x 1/4',0,0,978000000003,6,1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (3, 2, 114.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (3, 3, 150.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (3, 4, 148.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (3, 5, 147.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (3, 6, 146.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (3, 7, 145.00);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('3/4 x 1/8',0,0,978000000004,6,1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (4, 2, 80.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (4, 3, 104.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (4, 4, 103.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (4, 5, 103.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (4, 6, 102.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (4, 7, 101.00);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor)
VALUES ('3/4 x 3/16',0,0,978000000005,6,1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (5, 2, 117.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (5, 3, 153.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (5, 4, 152.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (5, 5, 150.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (5, 6, 149.00);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (5, 7, 148.00);

INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor) VALUES ('4 X 3/16',0,0,9786442700130,6,1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (SCOPE_IDENTITY(), 2, 566.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (SCOPE_IDENTITY(), 3, 742.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (SCOPE_IDENTITY(), 4, 735.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (SCOPE_IDENTITY(), 5, 729.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (SCOPE_IDENTITY(), 6, 722.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (SCOPE_IDENTITY(), 7, 719.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (SCOPE_IDENTITY(), 8, 716.0);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor) VALUES ('4 x 1/4',0,0,9783154568228,6,1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (SCOPE_IDENTITY(), 2, 773.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (SCOPE_IDENTITY(), 3, 1013.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (SCOPE_IDENTITY(), 4, 1004.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (SCOPE_IDENTITY(), 5, 995.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (SCOPE_IDENTITY(), 6, 986.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (SCOPE_IDENTITY(), 7, 982.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (SCOPE_IDENTITY(), 8, 977.0);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor) VALUES ('4 x 3/8',0,0,9785842219540,6,1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (SCOPE_IDENTITY(), 2, 1151.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (SCOPE_IDENTITY(), 3, 1509.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (SCOPE_IDENTITY(), 4, 1496.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (SCOPE_IDENTITY(), 5, 1482.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (SCOPE_IDENTITY(), 6, 1469.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (SCOPE_IDENTITY(), 7, 1462.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (SCOPE_IDENTITY(), 8, 1456.0);
INSERT INTO Productos (Nombre,PrecioCompra,PrecioVenta,CodigoBarras,idCategoria,idProveedor) VALUES ('1 x 1/8',0,0,9784967935169,7,1);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (SCOPE_IDENTITY(), 2, 202.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (SCOPE_IDENTITY(), 3, 264.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (SCOPE_IDENTITY(), 4, 262.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (SCOPE_IDENTITY(), 5, 260.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (SCOPE_IDENTITY(), 6, 257.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (SCOPE_IDENTITY(), 7, 256.0);
INSERT INTO PreciosDescuentos (idProducto, idDescuento, Precio) VALUES (SCOPE_IDENTITY(), 8, 255.0);



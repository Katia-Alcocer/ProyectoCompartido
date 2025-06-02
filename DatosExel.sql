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


ALTER TABLE Productos
DROP CHECK chk_Precios;


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


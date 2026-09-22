-- El nombre canonico de la sede de San Luis Potosi es "Aldea Park".
-- Afecta breadcrumb, tarjetas de sede, menu y el campo Sede de los leads.
SET NAMES utf8mb4;
UPDATE `locations` SET `name`='Aldea Park' WHERE `slug`='oficinas-en-renta-san-luis-potosi';

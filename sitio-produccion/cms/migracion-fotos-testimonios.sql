-- Retratos de las opiniones desde los originales del WordPress anterior (2234 px):
-- los que habia eran de 160 px con las esquinas del recorte en negro o blanco.
-- Solo cambia la foto si sigue siendo la anterior (si el cliente ya la cambio, se respeta).
SET NAMES utf8mb4;
UPDATE testimonials SET avatar='/img/testimonios/eduardo-velazquez.webp' WHERE name='Eduardo Velázquez' AND avatar='/img/av-eduardo.webp';
UPDATE testimonials SET avatar='/img/testimonios/enrique-del-campo.webp' WHERE name='Enrique del Campo' AND avatar='/img/av-enrique.webp';
UPDATE testimonials SET avatar='/img/testimonios/eitzel-galindo.webp' WHERE name='Eitzel Galindo' AND avatar='/img/av-eitzel.webp';
UPDATE testimonials SET avatar='/img/testimonios/miguel-barrientos.webp' WHERE name='Miguel Barrientos' AND avatar='/img/wp/2025/07/Miguel-Barrientos-300x300.webp';
UPDATE testimonials SET avatar='/img/testimonios/salvador-marin.webp' WHERE name='Salvador Marín' AND avatar='/img/wp/2025/07/Salvador-Marin-300x300.webp';

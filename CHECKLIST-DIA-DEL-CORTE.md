# Lista de verificación — Día del corte a aldea.work

## Antes de tocar producción
- [ ] Backup completo del WordPress actual (archivos + base de datos).
- [ ] Contenido final revisado en el CMS (páginas, servicios, ubicaciones, blog).
- [ ] Traducciones EN listas en lo importante (home, servicios, ubicaciones, blog).
- [ ] Tener a la mano: ID de GTM/GA4 de producción, credenciales OAuth de Google, CSV de URLs de Search Console.

## Mover a producción
- [ ] Copiar los archivos del sitio nuevo al docroot de aldea.work.
- [ ] Confirmar que la base `aldea_cms` es accesible desde producción (mismo hosting) o importarla.
- [ ] Revisar `cms/config.php` (credenciales de la base).

## Configurar
- [ ] En **Ajustes**: pegar el **ID de GTM/GA4** real → empieza a medir.
- [ ] Verificar que el sitio carga por **https://aldea.work** (no www roto, no mixed content).
- [ ] **Forzar HTTPS** a nivel servidor/LiteSpeed o HSTS. (NO con `%{HTTPS}` en .htaccess — genera bucle.)
- [ ] Confirmar que el `.htaccess` de routing está en el docroot y que /admin no se cachea.

## Verificar URLs críticas (una por una, deben dar 200 y verse bien)
- [ ] `/`  y  `/en/`
- [ ] `/oficinas-en-renta-san-luis-potosi/`
- [ ] `/coworkings-queretaro/`
- [ ] `/oficinas-en-renta-leon-guanajuato/`
- [ ] `/oficinas-en-renta-queretaro/`
- [ ] `/oficinas-en-renta-aguascalientes/`
- [ ] `/coworking/`  `/domicilio-virtual/`  `/oficina-privada/`
- [ ] `/ubicaciones/`  `/lo-que-ofrecemos/`
- [ ] `/acerca-de-aldea/`  `/contacto/`  `/preguntas-frecuentes/`
- [ ] `/blog/` y 2-3 entradas del blog
- [ ] Un puñado de `/en/…` (las que tienen tráfico)
- [ ] `/sitemap.xml` (debe listar aldea.work) y `/robots.txt` (debe permitir + apuntar al sitemap)
- [ ] Enviar el formulario de contacto de prueba → llega el correo Y aparece el lead en Analítica.

## SEO (el mismo día)
- [ ] Confirmar propiedad de aldea.work en **Search Console**.
- [ ] Subir el **sitemap.xml** nuevo; **eliminar** los sitemaps viejos (estático de xml-sitemaps y el de Yoast).
- [ ] Cargar en **SEO → Redirecciones** las 301 de las URLs que hayan cambiado (usar el CSV como lista maestra).
- [ ] Inspeccionar y "Solicitar indexación" de las URLs top.
- [ ] Confirmar que NO existen las URLs 404 residuales del generador viejo.

## Conectar Google (después del corte, en producción)
- [ ] En **Conexiones**: registrar la URI de redirección de aldea.work en el OAuth de Google.
- [ ] Pegar Client ID, Secret, GA4 Property ID y URL de Search Console → Guardar.
- [ ] Pulsar **Conectar con Google** → autorizar.
- [ ] Verificar en **Analítica** que aparecen datos de GA4 (Tiempo real) y Search Console.

## Monitoreo (2–4 semanas)
- [ ] GA4 midiendo (Tiempo real con visitas).
- [ ] Search Console: cobertura, 404, posición media de las top.
- [ ] Leads reales entrando en el panel.
- [ ] Corregir meta description de Aguascalientes (decía "Querétaro").

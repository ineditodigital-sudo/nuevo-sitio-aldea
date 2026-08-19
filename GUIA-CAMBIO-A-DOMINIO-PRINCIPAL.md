# Guía de cambio a dominio principal — aldea.work
De `temporal.aldea.work` (subdominio de pruebas) → `aldea.work` (producción), sin perder posicionamiento y empezando a medir datos reales.

## Idea clave
El nuevo sitio conserva **los mismos slugs** que el WordPress actual, así que la gran mayoría de URLs no cambian. El canonical y el hreflang **se generan solos según el dominio**, por lo que al vivir en aldea.work saldrán correctos automáticamente. El trabajo es: preparar, mover, forzar HTTPS, y avisar a Google.

---

## FASE 0 — Preparar (ahora, en temporal)
1. **Congelar contenido:** revisar en el CMS que páginas, servicios, ubicaciones, blog y textos estén finales.
2. **Traducciones EN:** completar el inglés de lo importante (home, servicios, ubicaciones, blog). Recuerda: las traducciones NO son automáticas.
3. **Sitemap + robots.txt:** generar el sitemap dinámico del nuevo sitio y el robots.txt. (Lo puedo construir yo.)
4. **Mapa de redirecciones 301:** exportar el CSV de URLs de Search Console (lista maestra). Comparar con las URLs del sitio nuevo. Las que cambien se cargan en el módulo **SEO → Redirecciones**. Las que se mantienen igual (la mayoría) no necesitan nada.
5. **GA4 + GTM:** crear la propiedad de Google Analytics 4 y el contenedor de GTM. Guardar el ID para ponerlo en Ajustes al momento del corte.
6. **Backup del WordPress actual:** respaldo completo (archivos + base de datos) por si hay que revertir.

## FASE 1 — Archivos y base en producción
Depende de si aldea.work está en el **mismo hosting** que temporal:
- **Mismo cPanel/servidor (lo más probable):** copiar los archivos del sitio nuevo desde `temporal.aldea.work/` al docroot de `aldea.work` (normalmente `public_html/`). La base `aldea_cms` ya existe y es accesible.
- **Otro hosting:** migrar archivos por FTP + exportar/importar la base `aldea_cms`.

## FASE 2 — Configuración de producción
1. **config.php:** credenciales de la base `aldea_cms` (ya están).
2. **Canonical / hreflang:** se generan solos por dominio — nada que tocar.
3. **GTM/GA4:** poner el **ID real** en Ajustes.
4. **Formulario:** ya envía a contacto@aldea.work y guarda cada lead en el panel.
5. **HTTPS forzado + trailing slash:** forzar HTTPS a nivel **servidor/LiteSpeed o HSTS**. IMPORTANTE: NO forzar HTTPS con `%{HTTPS} off` en .htaccess — en LiteSpeed genera bucle de redirección (ya nos pasó). Mantener la barra final `/` en las URLs.
6. **robots.txt:** que NO bloquee el sitio y que apunte al sitemap nuevo.

## FASE 3 — El corte (cutover)
1. Poner el WordPress viejo en mantenimiento y respaldarlo.
2. Colocar el sitio nuevo como docroot de aldea.work.
3. Verificar: HTTPS fuerza, barra final, y que la home carga.
4. Probar **una por una** las URLs críticas (con tráfico real):
   `/`, `/oficinas-en-renta-san-luis-potosi/`, `/coworkings-queretaro/`, `/oficinas-en-renta-leon-guanajuato/`, `/oficinas-en-renta-queretaro/`, `/oficinas-en-renta-aguascalientes/`, `/en/`, `/coworking/`, `/domicilio-virtual/`, `/ubicaciones/`, `/lo-que-ofrecemos/`, `/acerca-de-aldea/`, `/contacto/`, y las `/en/…`.

## FASE 4 — SEO el mismo día del corte
1. Subir el **sitemap.xml** nuevo y declararlo en robots.txt.
2. **Search Console:** verificar la propiedad de aldea.work, subir el sitemap nuevo, y **eliminar los sitemaps viejos** (el estático `sitemap.xml` de xml-sitemaps y el de Yoast).
3. **Inspeccionar URLs** clave y pulsar "Solicitar indexación" en las top.
4. Cargar las **redirecciones 301** finales (solo de las URLs que hayan cambiado) en el módulo SEO.
5. NO crear las URLs 404 residuales del generador viejo (`/blog-3/`, `/aldea1/`, `/category/tu-espacio-de-negocio/`, etc.).

## FASE 5 — Medir y monitorear (2–4 semanas)
1. GA4 midiendo en producción — verificar en **Tiempo real** que llegan visitas.
2. En Search Console: vigilar **Cobertura**, errores **404** y la **posición media** de las páginas top.
3. Revisar **leads reales** en el panel de Analítica del CMS.
4. Corregir la meta description de `/oficinas-en-renta-aguascalientes/` (decía "Querétaro" por error) — ya es editable desde el CMS.

---

## Qué puedo dejar listo yo ahora (antes del corte)
- **sitemap.xml dinámico** (incluye /en/ con hreflang) + **robots.txt**.
- **Redirecciones 301** cargadas en el módulo SEO (con tu CSV de Search Console).
- Campo de **GA4/GTM** en Ajustes listo para pegar el ID real.
- Una **lista de verificación (pre-flight)** para el día del corte.

## Lo único que necesita tu lado
- Acceso al docroot de aldea.work (o confirmación de que es el mismo hosting).
- El **ID de GA4/GTM** de producción.
- El **CSV de URLs** exportado de Search Console (para el mapeo de 301).
- Ejecutar el cambio de docroot / DNS y el forzado de HTTPS (o dármelo para hacerlo).

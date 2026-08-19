# Plan de migración SEO — aldea.work
Estado del nuevo sitio (temporal.aldea.work) frente al plan del equipo. Actualizado: 21 jul 2026.

## Leyenda
- ✅ Hecho y verificado en el nuevo sitio
- 🟡 En progreso / parcial
- ⬜ Pendiente (se hace en el corte a producción)

## P0 — Bloqueantes antes de lanzar
- ✅ **Mismas URLs / slugs.** El nuevo CMS replica exactamente las rutas actuales. Home, soluciones, ubicaciones, blog y páginas simples conservan su slug.
- ⬜ **Redirecciones 301.** Módulo de redirecciones ya existe en el CMS (SEO → Redirecciones). Falta cargar el mapeo final de cualquier URL que cambie, usando el CSV maestro de Search Console.
- ⬜ **Forzar HTTPS.** Se configura en el servidor de producción (en LiteSpeed, vía panel/HSTS; NO por .htaccess con %{HTTPS} porque genera bucle).
- ✅ **Trailing slash.** Todas las rutas mantienen la barra final.
- ⬜ **robots.txt + sitemap.** Pendiente generar sitemap dinámico único y declararlo en robots.txt (ver sección Sitemaps).

## P1 — Alta prioridad
- ✅ **Metadatos por página:** title, meta description, H1 y canonical se generan por página (editables desde el CMS → Páginas → SEO).
- ⬜ **Sitemap nuevo en Search Console:** generar y reenviar tras el corte.
- 🟡 **Datos estructurados / Open Graph:** canonical y hreflang ya salen; falta OG y schema.org por página.
- ✅ **Versión inglés /en/ con hreflang.** URLs reales /en/… funcionando, con `hreflang` es/en/x-default, canonical propio y enlaces internos con prefijo /en/. El selector de idioma navega entre las dos URLs.
- ⬜ **Limpieza de sitemaps** (ver sección).

## P2 — Post-lanzamiento
- ⬜ Inspeccionar URLs clave en Search Console tras el deploy.
- ⬜ Monitorear 404 y posición media 2–4 semanas.
- 🟡 **Corregir meta description de /oficinas-en-renta-aguascalientes/** (decía "en Querétaro"). Ahora es editable desde el CMS; validar el texto final.

## Estado por URL prioritaria
### Prioridad 1 (con clics)
| URL | Estado |
|---|---|
| / | ✅ dinámica |
| /oficinas-en-renta-san-luis-potosi/ | ✅ dinámica |
| /coworkings-queretaro/ | 🟡 sirve estático — revisar (tarea #21) |
| /oficinas-en-renta-leon-guanajuato/ | ✅ dinámica |
| /oficinas-en-renta-queretaro/ | ✅ dinámica |
| /oficinas-en-renta-aguascalientes/ | ✅ dinámica |
| /en/ y /en/… | ✅ dinámicas con hreflang |
| /domicilio-virtual/ /coworking/ | ✅ dinámicas (soluciones) |
| /ubicaciones/ /lo-que-ofrecemos/ | ✅ dinámicas (índices) |
| /coworking-mexico/ /nomada-mexico/ | 🟡 estático — revisar (tarea #21) |
| /acerca-de-aldea/ /contacto/ | ✅ dinámicas |
| /membresias/ | ⬜ falta — crear (tarea #21) |

### Prioridad 2 (impresiones)
- ✅ soluciones (oficina-privada, escritorio-privado, oficinas-personalizadas), /preguntas-frecuentes/, /blog/, índices y sus /en/.
- 🟡 /entorno-colaborativo/ (estático — revisar), /author/aldea/, /busqueda/, /corporativo/ (⬜ crear o redirigir).

### Prioridad 3 (blog)
- ✅ Los posts del blog están migrados y son dinámicos. Verificar slugs uno a uno contra el CSV.

## Sitemaps (acciones)
- Eliminar el sitemap estático `/sitemap.xml` (desactualizado, de xml-sitemaps.com).
- Generar un único sitemap dinámico desde el nuevo CMS, incluyendo las URLs /en/ con hreflang.
- Declarar solo ese sitemap en robots.txt.
- NO crear las URLs residuales 404: /blog-3/, /en/blog-3/, /aldea1/, /en/aldea1/, /category/tu-espacio-de-negocio/.

## Nota
temporal.aldea.work es el entorno de pruebas. Redirecciones 301, HTTPS forzado, sitemap y reenvío a Search Console se ejecutan en el corte a producción sobre aldea.work. Exportar el CSV completo de Search Console como lista maestra para el mapeo de 301.

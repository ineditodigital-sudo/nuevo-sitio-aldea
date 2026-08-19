# Auditoría pre-migración — aldea.work

Auditoría completa sobre `temporal.aldea.work` (réplica exacta de lo que irá a producción). Fecha: 22 jul 2026.

## Resultado general: ✅ Listo para migrar

Todo lo verificable antes del corte está correcto. Durante la auditoría se detectaron y **corrigieron** varios huecos de la versión en inglés (detalle abajo).

---

## 1. URLs, redirecciones y 404 ✅

- **62/62** URLs del sitemap responden **200** (31 ES + 31 EN).
- **Redirecciones 301** funcionando: `/membresias/` → `/lo-que-ofrecemos/`, `/corporativo/` → `/ubicaciones/` (y sus variantes `/en/`).
- **Páginas heredadas con tráfico** en 200: `/coworkings-queretaro/`, `/coworking-mexico/`, `/nomada-mexico/`, `/entorno-colaborativo/`, `/blog-2/`.
- **URLs residuales viejas** dan **404** correctamente (no existen): `/blog-3/`, `/aldea1/`, `/category/tu-espacio-de-negocio/`.
- El manejador 404 funciona (una URL inexistente devuelve 404).

## 2. SEO técnico ✅ (con correcciones aplicadas)

- **hreflang**: cada URL declara `es`, `en` y `x-default` (62 × 3 = 186 entradas en el sitemap).
- **Canonical**: autorreferencial por idioma (la ES apunta a la ES, la EN a la `/en/`).
- **Títulos y meta description** por página en ES y EN.
- **html lang**: `es` en las páginas ES, `en` en las `/en/`.

**Corregido durante la auditoría (desplegado en temporal):**

- Meta EN (title + description) de las 3 páginas índice generadas por plantilla: **Lo que ofrecemos**, **Ubicaciones** y **Blog** (estaban en español).
- Viñetas "Qué incluye" de las **5 soluciones** (coworking, oficina privada, domicilio virtual, escritorio privado, oficinas personalizadas): estaban en español en `/en/`, ahora traducidas.
- **Listado del blog** (`/en/blog/`): las tarjetas mostraban título y extracto en español; ahora en inglés.
- **Breadcrumbs** ("Inicio → Home", "Ubicaciones → Locations", "Soluciones → Solutions") en las plantillas de ubicación, solución, post e índices.
- **Páginas de ubicaciones**: se agregó al CMS el campo `intro_en` (+ `address_en`, `seo_title_en`, `seo_desc_en`) y se tradujo el intro/meta de las 4 ciudades. De paso se corrigió el meta de **Aguascalientes**, que antes decía "Querétaro".

Sin regresión en las versiones en español (verificado).

## 3. Sitemap y robots.txt ✅

- **sitemap.xml** dinámico y consciente del host: en producción listará `aldea.work` automáticamente. 62 URLs con hreflang.
- **robots.txt** dinámico:
  - En `temporal.` → `Disallow: /` (bloquea indexación del entorno de pruebas).
  - En producción (`aldea.work`) → `Allow: /`, `Disallow: /admin/ /cms/ /uploads/`, y línea `Sitemap: https://aldea.work/sitemap.xml`.

## 4. Analítica: GA4 / GTM y conexión Google ✅

- **Google Tag Manager** ya configurado (contenedor `GTM-KN2FDL6J`) e inyectado en todas las páginas (ES y EN). La medición GA4 vive dentro del contenedor GTM.
- Módulo **Conexiones** listo con los campos OAuth: `google_client_id`, `google_client_secret`, `ga4_property_id` (para el panel de analítica del CMS vía API).
- Nota: GTM también dispara en `temporal`. Si no quieres contar el tráfico de pruebas, exclúyelo en GTM/GA4 o confirma que `GTM-KN2FDL6J` es el contenedor correcto de producción.

## 5. Formulario de contacto y leads ✅

- Valida nombre + email, tiene **honeypot** anti-spam.
- Guarda el lead en la tabla `leads` **antes** de enviar el correo (el lead se captura aunque el correo falle).
- Envía notificación a **contacto@aldea.work** (Reply-To del prospecto).
- Los leads de prueba en el panel confirman que el flujo completo funciona.

---

## Checklist del día del corte (producción)

1. Backup del WordPress actual (archivos + base).
2. Subir archivos del sitio nuevo + `cms/` + `admin/` a `public_html/` de aldea.work; importar/conectar la base `aldea_cms`.
3. Revisar `cms/config.php` (credenciales de la base en producción).
4. **Forzar HTTPS** a nivel servidor/LiteSpeed o HSTS (NO con `%{HTTPS}` en .htaccess → bucle).
5. Confirmar que `https://aldea.work/robots.txt` ya sirve la versión "Allow + Sitemap" (cambia solo por host).
6. Probar un puñado de URLs ES y `/en/` (incluidas las de ubicaciones y las 4 guías) → 200 y en el idioma correcto.
7. **Search Console**: verificar propiedad, subir el sitemap nuevo, **eliminar** los sitemaps viejos (xml-sitemaps y Yoast).
8. Cargar/confirmar las **301** (ya están en el CMS; viajan con la base).
9. **Conectar Google**: registrar la URI de redirección `https://aldea.work/admin/google-callback.php` en Google Cloud → pegar Client ID/Secret + GA4 Property ID en Conexiones → Conectar.
10. Verificar **GA4 en Tiempo real** y hacer **una prueba real** del formulario de contacto (que llegue el correo y aparezca el lead).

## Monitoreo (2–4 semanas)
GA4 midiendo, cobertura y 404 en Search Console, posición media de las URLs top, y leads reales entrando.

## Pendientes menores (no bloquean la migración)
- **Páginas legales** (Términos, Políticas): el cuerpo en `/en/` cae al español (respaldo). Traducción legal recomendable pero de bajo impacto SEO.
- El breadcrumb "Blog" se mantiene igual en ambos idiomas (es la misma palabra).

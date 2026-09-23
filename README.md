# Aldea — Sitio Web 2026

Sitio de **Aldea Networking**, reemplazo del WordPress de `aldea.work`.

- **En línea:** https://temporal.aldea.work (entorno de trabajo, pendiente el cambio al dominio principal)
- **Panel de administración:** https://temporal.aldea.work/admin/

El sitio es **PHP + MySQL con plantillas del lado del servidor**. No hay build: se editan archivos y se suben. Todo el contenido lo edita el equipo de Aldea desde el panel, sin tocar código.

> **Antes de empezar, lee esto.** La carpeta `src/` contiene un prototipo de React/Vite de las primeras semanas del proyecto, **abandonado**. Tiene solo Home, Header y Footer; nunca se compiló ni se publicó. El sitio real es `sitio-produccion/`. `npm install` no sirve para nada aquí.

---

## Qué carpeta es cuál

| Carpeta | Qué es |
|---|---|
| **`sitio-produccion/`** | **El sitio.** Es lo que está publicado, tal cual. 237 archivos. |
| `deploy/` | Herramienta de despliegue por FTPS. Ver [deploy/README.md](deploy/README.md). |
| `src/`, `public/`, `server/`, `preview-temporal/` | Prototipos abandonados (React/Vite). No se usan. |

---

## Cómo funciona `sitio-produccion/`

```
router.php              Todas las URLs entran aquí y se despachan a una plantilla
send.php                Recibe los formularios y guarda en la tabla leads
s6.css                  Toda la hoja de estilos (~69 KB, un solo archivo)
app6.js                 Carrusel del hero, lightbox de galería, modal de visita, UTMs
admin/                  Panel: páginas, blog, sedes, clientes, testimonios, leads, ajustes
cms/                    Plantillas y núcleo
  site.php              Cabecera, pie, menú y helpers compartidos por todas las páginas
  tpl_home.php          Inicio
  tpl_solution_full.php Oficina Privada, Coworking, Escritorio Privado, Domicilio Virtual
  tpl_location_full.php Las 4 sedes
  tpl_corporativas.php  Oficinas Corporativas
  tpl_page.php          Acerca, Contacto, FAQ y páginas legales
  tpl_post.php          Artículos del blog
  schema.sql            Estructura de la base (13 tablas)
  migracion-*.sql       Migraciones aplicadas, en orden cronológico
img/, video/            Imágenes y video, ya optimizados
```

### El sistema de bloques

Casi todo el texto y las imágenes viven en la tabla **`blocks`**, no en el código. Cada fila es un campo editable:

| Columna | Para qué |
|---|---|
| `page_id` + `section` + `skey` | dónde vive el campo (página, sección, clave) |
| `value_es` / `value_en` | el contenido en cada idioma |
| `label` | cómo se llama el campo en el panel |
| `sort` | en qué orden aparece |

Las plantillas leen esos bloques con helpers (`sv()`, `lt()`, `ct()`, según la plantilla). **Una sección que se queda sin contenido no se dibuja** — así el cliente oculta cosas vaciando campos, sin tocar código.

### Páginas ocultas `sol:` y `loc:`

Las soluciones y las sedes tienen su ficha en las tablas `solutions` y `locations`, pero su contenido largo vive en **páginas ocultas** (`published=0`) llamadas `sol:<slug>` y `loc:<slug>`.

`tpl_solution.php` y `tpl_location.php` comprueban si existe esa página oculta: si existe, delegan en la plantilla completa (`*_full.php`); si no, dibujan el diseño genérico. Es lo que permitió rehacer esas páginas sin romper las que aún no se habían migrado.

### Bilingüe

Cada texto lleva `data-es` y `data-en`. El selector ES/EN del header cambia el idioma en el cliente; `tr_en()` en `site.php` hace la traducción del lado del servidor cuando hace falta.

---

## Poner el proyecto a correr

### Para editar contenido
No hace falta nada local: se entra a `/admin/` y se edita. Es lo que hace el cliente.

### Levantar una copia con el contenido

El código por sí solo dibuja un sitio vacío: **todo el texto y las imágenes viven en la
base de datos**, no en archivos. Para tener una copia igual a la publicada:

1. `cms/schema.sql` — crea las 13 tablas.
2. `cms/contenido.sql` — carga las páginas, los 1,070 bloques de contenido, las sedes,
   las soluciones, el blog, los testimonios y los ajustes.

Ese segundo archivo se regenera desde el CMS con `python deploy/deploy.py dump` y luego
`python deploy/exportar-contenido.py` (ver [deploy/README.md](deploy/README.md)). **No incluye la tabla
`leads`** (datos personales de prospectos) ni `users` (contraseñas del panel): esos se
quedan solo en el servidor.

Los `cms/migracion-*.sql` son el historial de cómo se fue construyendo ese contenido,
en orden cronológico. Sirven para entender por qué algo quedó como quedó, pero para
levantar una copia basta con los dos archivos de arriba.

### Para tocar código

1. Clona el repo.
2. Pide las credenciales de FTP y de la base a quien lleve el proyecto. **No están en el repositorio y no deben subirse.**
3. Crea `deploy/ftp.conf` a partir de [`deploy/ftp.conf.example`](deploy/ftp.conf.example).
4. En el servidor, `cms/config.php` se crea a partir de `cms/config.example.php`.

```bash
cd deploy
python deploy.py status              # qué difiere entre tu copia y el servidor
python deploy.py push ../ruta/archivo.php
python deploy.py dump                # respalda las tablas del CMS a JSON
python deploy.py sql migracion.sql   # ejecuta una migración en el servidor
```

Cada `push` respalda en `deploy/bak/<fecha>` lo que va a sobrescribir, y `restore` lo revierte. Los comandos completos están en [deploy/README.md](deploy/README.md).

Para ver el sitio en tu máquina sin MySQL está [local/README.md](local/README.md). Los cambios se revisan en `temporal.aldea.work`, que es el entorno de pruebas; el sitio del cliente sigue siendo `aldea.work` hasta el cambio de dominio.

---

## Estado del proyecto

Las 11 páginas con brief están construidas y alineadas a lo que pidió el cliente: Inicio, Acerca de Aldea, las 4 soluciones, Oficinas Corporativas y las 4 sedes. Las demás (Ubicaciones, Contacto, Preguntas frecuentes, Lo que ofrecemos, Blog y las legales) se alinearon al mismo criterio.

**Antes de tocar nada, lee [PENDIENTES-CLIENTE.md](PENDIENTES-CLIENTE.md).** Es la lista viva de lo que falta: qué datos se esperan del cliente, qué decisiones están abiertas y qué ya se resolvió para no volver a preguntarlo.

### Otros documentos

| Documento | Para qué |
|---|---|
| [PENDIENTES-CLIENTE.md](PENDIENTES-CLIENTE.md) | lo que falta del cliente y lo ya resuelto |
| [deploy/README.md](deploy/README.md) | comandos de despliegue y trampas del servidor |
| [GUIA-CAMBIO-A-DOMINIO-PRINCIPAL.md](GUIA-CAMBIO-A-DOMINIO-PRINCIPAL.md) | pasos para pasar a `aldea.work` |
| [PLAN-MIGRACION-SEO.md](PLAN-MIGRACION-SEO.md) | redirecciones 301 y sitemaps |
| [CHECKLIST-DIA-DEL-CORTE.md](CHECKLIST-DIA-DEL-CORTE.md) | checklist del día del cambio |
| [AUDITORIA-PRE-MIGRACION.md](AUDITORIA-PRE-MIGRACION.md) | revisión previa a la migración |
| [PROMPTS-PROCESO-CORPORATIVO.md](PROMPTS-PROCESO-CORPORATIVO.md) | imágenes provisionales de Oficinas Corporativas |

`DEPLOY.md` describe la arquitectura del prototipo de React y **está obsoleto**.

---

## Diseño

- Azul de marca: `#182943` (del logo). Azul de acento: `#2563eb`.
- Tipografías: **Jost** para títulos (equivalente a Futura), **Raleway** para texto.
- Los colores son variables CSS al inicio de `s6.css`; cambiar el acento ahí re-tiñe el sitio entero.
- El acento `#2563eb` es propuesta del rediseño y **está pendiente de confirmar con el cliente** (ver PENDIENTES-CLIENTE.md).

## Lo que nunca va al repositorio

`deploy/ftp.conf`, `cms/config.php`, `deploy/bak/`, `deploy/dumps/` y los briefs del cliente. Ya están en `.gitignore`; el repositorio es público.

# Pendientes por confirmar con el cliente

Última actualización: 24 de agosto de 2026
Sitio de trabajo: https://temporal.aldea.work

Todo lo listado aquí está **construido y funcionando**; solo falta el dato real.
Nada de esto bloquea el resto del sitio.

---

## 0. Páginas sin brief — RESUELTO el 24 de agosto de 2026

El cliente autorizó aplicar por consistencia los mismos criterios de los siete briefs a
las páginas que no traían uno. Ya está hecho en las 8 páginas más los 13 posts:

- **Fuera el CTA "Agenda tu tour"** en todo el sitio (0 apariciones verificadas en las
  21 URLs). Lo sustituye **"Cotizar"** → `/contacto/`, el CTA fijo que pide el brief del
  Home. Contacto y las dos páginas legales quedaron sin botón en el hero.
- **Fuera el comparativo de precios por ciudad** en `/ubicaciones/` y `/contacto/`. Las
  tarjetas conservan ciudad, sede y dirección, y cierran con "Ver sede →", igual que las
  del Home. Los precios siguen donde el brief sí los pide: en la landing de cada sede.
- **Nomenclatura alineada al menú nuevo:** `/ubicaciones/` pasa a **"Encuentra tu Aldea"**
  con el texto literal del brief del Home; `/lo-que-ofrecemos/` pasa a **"Espacios de
  trabajo"** en migaja, etiqueta y título del navegador.
- **Banda de cierre reescrita** (blog, FAQ, Ubicaciones, Espacios de trabajo): ya no
  ofrece un tour, invita a cotizar.
- La pregunta *"¿Cómo puedo agendar un tour?"* del FAQ general pasó a **"¿Puedo conocer
  el espacio antes de contratar?"**, y la respuesta habla de agendar una **visita** a la
  sede, que es el flujo que sí conservan los briefs de sede.
- La meta descripción de `/contacto/` seguía vendiendo el tour; ya está corregida.

**Lo que NO se tocó y conviene saber:** la URL `/lo-que-ofrecemos/` se conserva (cambiarla
costaría el posicionamiento que ya tiene; solo cambió lo que ve el usuario).

## 1. Datos que faltan

### URGENTE: la fecha de apertura de Centro Sur ya paso
La sede de Queretaro sigue anunciandose como **"Proximamente"** con el aviso
*"Apertura prevista: 15 de junio de 2026"*. Hoy es **22 de septiembre de 2026**: esa
fecha paso hace tres meses.

Quien entre al sitio va a pensar que la apertura se cayo o que la pagina esta
abandonada. Ademas la etiqueta "Proximamente" aparece en las tarjetas de sede de
todo el sitio (Home, Ubicaciones, Contacto y las cuatro soluciones).

**Que preguntar:** ¿ya abrio Aldea Centro Sur?
- Si abrio: se quita el aviso y la etiqueta, y la sede pasa a operar como las otras
  tres. Son dos campos en el panel (`hero.aviso` y la casilla "Proximamente" de la
  ficha de la sede).
- Si se pospuso: hace falta la fecha nueva.

Es lo unico del sitio que hoy se contradice a si mismo, asi que conviene resolverlo
antes de enseñarlo.

### Precio de Escritorio Privado — RESUELTO el 24 de agosto de 2026
Confirmado por el cliente y cargado en la base. Ya no aparece "Precio a consultar".

| Sede | Privada | Coworking | Escritorio | Virtual |
|---|---|---|---|---|
| Aldea Centro Sur (Qro) | $10,800 | $3,100 | **$3,900** | $2,400 |
| Aldea Poliforum (León) | $8,600 | $3,100 | **$3,900** | $2,400 |
| Aldea Park (SLP) | $8,600 | $3,100 | **$3,900** | $2,400 |
| Aldea Galerías (Ags) | $7,400 | $2,700 | **$3,400** | $2,400 |

### Horarios de atencion de cada sede
Las cuatro sedes ya publican datos estructurados (schema.org) para que Google
muestre la ficha de negocio local. Falta un campo que Google valora mucho y que no
esta en la base: el **horario de atencion**. Si es el mismo en las cuatro, basta un
dato; si varia, hace falta el de cada una.

### Condiciones de estacionamiento — las 4 sedes
El brief de sedes dice literalmente "incluir aquí las condiciones finales". Las cuatro
respuestas del FAQ llevan hoy un **`[PENDIENTE]` visible en la página**. Conviene
resolverlo antes de enseñar el sitio al cliente final.

### Cifras de "Aldea en números" — RESUELTO el 24 de agosto de 2026
El cliente confirmó que **manda el brief**, no el sitio publicado. Las cifras vigentes
son las que ya están en el Home y en Acerca de Aldea:

**2017** año de fundación · **4** ciudades · **+120** empresas · **+1,000** miembros ·
**+6,000 m²** espacios administrados

Consecuencia: `aldea.work` lleva tiempo publicando datos viejos (+130 empresas, +500
miembros, +5,400 m²). Se corrigen solos al cambiar de dominio.

---

## 2. Material que falta

### Video de cada sede — RESUELTO las 4 el 24 de agosto de 2026
Los tres tours de las sedes que ya operan se recuperaron del WordPress viejo (estaban
dentro de widgets de Elementor, del canal oficial "Aldea Networking Leon"):

- Aldea Park (SLP) · Aldea Poliforum (Leon) · Aldea Galerias (Ags)

**Aldea Centro Sur (Queretaro)** lo entregó el cliente el 24 de agosto. Es el único
alojado en el propio servidor (`/video/aldea-centro-sur.mp4`), con póster extraído del
plano del edificio. El lightbox ya distingue un archivo directo de un embed, así que no
hizo falta tocar código. Verificado: el servidor responde con `Accept-Ranges: bytes`, o
sea que el navegador puede saltar dentro del video sin descargarlo completo.

**Pendiente de calidad:** el archivo llegó por WhatsApp, que lo recomprimió a **848×480**
(60 s, 9.4 MB). Es la calidad máxima disponible en ese archivo — reconvertirlo solo
perdería más. Las otras tres sedes se ven en HD porque van por YouTube. Conviene pedir
el master al proveedor de video, o subirlo al canal de YouTube de Aldea como los otros
tres: se ve mejor, pesa cero en el hosting y ajusta calidad según la conexión.

### Fotos del equipo (RH) — RESUELTO el 24 de agosto de 2026
El cliente entregó 7 fotografías reales de RH (team buildings, eventos y staff). Se
recortaron al aspecto exacto de cada hueco, se convirtieron a WebP y viven en
`/img/equipo/`. Quedaron aplicadas en los tres lugares que pedía el brief:

| Dónde | Archivo | Qué se ve |
|---|---|---|
| Hero de Acerca de Aldea | `equipo-hero.webp` | todo el equipo en una actividad al aire libre |
| "Las personas son lo más importante" | `equipo-personas.webp` | equipo con playera de Aldea |
| Galería "Así se vive Aldea" (4 fotos) | `vive-1..4.webp` | staff en sede, team building, valores en playera, evento |

El brief pedía "aproximadamente 3–6 fotografías" y el mosaico está diseñado para que
4 llenen la retícula sin huecos. Quedan **dos espacios libres** (Foto 5 y Foto 6) por si
RH manda más: la sección los absorbe sola.

Una de las 7 fotos era una segunda toma del mismo momento, así que no se usó.

### Testimonios por sede — RESUELTO de forma provisional el 24 de agosto de 2026
El cliente pidió **no retrasar el desarrollo**: se publican los testimonios generales que
ya existen aunque no sean de esa sede, y RH irá consiguiendo los propios de cada una.

La sección ya se ve en las cuatro landings, con tres testimonios cada una y un reparto
rotado para que no se lean iguales:

| Sede | Testimonios |
|---|---|
| Aldea Park (SLP) | Edenred · Banco Azteca · Cemex |
| Aldea Poliforum (León) | Banco Azteca · Cemex · Opzione |
| Aldea Galerías (Ags) | Cemex · Opzione · Royale |
| Aldea Centro Sur (Qro) | Opzione · Royale · Edenred |

El título de la sección es "Lo que dicen nuestros clientes" — habla de Aldea, no de esa
sede en concreto, así que la frase se sostiene. Cuando lleguen los testimonios reales de
cada sede se sustituyen desde el panel, sin tocar código.

**Nota sobre Centro Sur:** es la única sede que aún no abre. Si prefieren que ahí no haya
testimonios, basta con vaciar los tres campos en el panel y la sección desaparece sola.

De paso se le pusieron los acentos que faltaban a los cinco testimonios, tanto en las
sedes como en el Home.

### Material de proyectos corporativos — PARCIALMENTE RESUELTO
Del WordPress viejo se recuperaron **17 fotos de un proyecto corporativo real y
terminado** (cientos de estaciones, cabinas telefonicas, lockers, grafica de marca).
Ya estan en uso:

- el hero de `/oficinas-corporativas/`
- la foto de la seccion "Tu empresa no tiene que adaptarse a una oficina existente"

Antes ambas mostraban una oficina privada de una sede normal, justo lo que el brief
pedia evitar ("tratar esta solucion como una Oficina Privada grande").

**Material de proceso — PROVISIONAL desde el 24 de agosto de 2026.**
La sección "Del proyecto al espacio terminado" ya se muestra con las seis etapas:

| Etapa | Imagen | Origen |
|---|---|---|
| 1 Requerimientos | `e1-requerimientos.webp` | **generada con IA** |
| 2 Zonificación | `e2-zonificacion.webp` | **generada con IA** |
| 3 Render | `e3-render.webp` | **generada con IA** |
| 4 Construcción | `e4-construccion.webp` | **generada con IA** |
| 5 Equipamiento | `e5-equipamiento.webp` | foto real de proyecto Aldea |
| 6 Resultado final | `e6-resultado.webp` | foto real de proyecto Aldea |

Viven en `/img/corporativas/proceso/`, cuadradas de 700 px.

Para no presentar como obra ejecutada algo que no lo es, la sección lleva una **nota al
pie visible**: *"Las primeras cuatro etapas son imágenes ilustrativas del proceso. El
equipamiento y el resultado final corresponden a un proyecto realizado por Aldea."*
Es un campo del panel (`proyecto.nota`): si se sustituyen las cuatro primeras por
material real de los arquitectos, se borra la nota y listo.

**Lo que sigue faltando:** planos, zonificaciones, renders y fotos de obra reales. La
etapa 4 es la que más conviene reemplazar primero — una foto de obra generada se lee
como documental. Aldea acaba de construir Centro Sur, así que es probable que existan
fotos de esa obra.

Nota: no se resolvió con íconos a propósito. El brief dice "utilizar material real de
proyectos" y que el objetivo es "demostrar capacidad de desarrollo, no únicamente diseño
interior". Además la página ya tiene la sección **"De la necesidad a una oficina lista
para operar"** con el proceso en 5 etapas: unos íconos aquí serían el mismo contenido
contado dos veces.

El brief pedía "material real de proyectos cuando esté disponible" y demostrar capacidad
de desarrollo, no solo diseño interior. Sin ese material, la sección cumple la estructura
pero no el objetivo.

Lo mismo con la foto del hero y la de "Tu empresa no tiene que adaptarse a una oficina
existente": hoy usan una oficina privada de Aldea en lugar de un proyecto corporativo.

### Fotos de producto por sede
Las 4 sedes usan las mismas fotos de cada solución. Se hizo así a propósito: es
preferible mostrar la foto real del producto antes que arriesgarse a poner una imagen
de León en la página de Querétaro. Si hay material por sede, se cambia en el panel.

---

## 3. Decisiones pendientes

### Color de acento del sitio
El sitio publicado (`aldea.work`) **no usa azul brillante en ninguna parte**: su color
de acción es un navy casi negro.

| Elemento en aldea.work | Color |
|---|---|
| Botones "Ver más" | #00013b |
| Botón secundario | #021e50 |
| Azul de marca (logo) | #182943 |

El sitio nuevo usa **#2563eb** en **33 reglas** de CSS: chips, flechas, botones,
precios, foco de inputs, enlaces del blog. Esa divergencia viene del rediseño original,
no de los briefs — el README del proyecto la documenta como "propuesta nueva que se
ajustará con las referencias visuales del cliente".

Cambiarlo es un token y se re-tiñe el sitio entero, pero afecta a todas las páginas.
Tiene un costo real: con un acento casi negro, enlaces y flechas dejan de distinguirse
del texto normal.

**Sugerencia:** acento #182943 o #021e50 para botones, y reservar un azul más legible
solo para enlaces en línea. Decisión de marca, no técnica.

### Diferenciadores de "Por qué esta sede"
El brief solo traía los de Aldea Park. Los de las otras tres los redacté a partir de las
introducciones que ya tenía cada sede en la base. **Conviene que el cliente los valide:**

- **Centro Sur:** Piso PH de Torre Capita Sur · Estacionamiento · Acceso desde los principales puntos de la ciudad
- **Poliforum:** Ubicación en Plaza Forum Center · Estacionamiento · A 1.5 km de Poliforum León
- **Galerías:** Ubicación en Galerías Business Square · Estacionamiento · Junto a C.C. Galerías y cerca de Altaria

### Etiqueta de San Luis Potosí en el menú
El brief del Home pide el desplegable como **"Ciudad — Sede"**. Ya está aplicado, pero
para SLP queda **"San Luis Potosí — Park"**, porque el nombre confirmado de la sede es
"Aldea Park". El brief escribía "San Luis Potosí — **The** Park", que es el nombre del
complejo empresarial donde está la sede, no el de la sede.

Ambas lecturas son defendibles. **Confirmar cuál prefieren en el menú.**

### Títulos repetidos en Escritorio Privado
El brief usa **"Encuentra tu Escritorio Privado"** como título de la sección Ubicaciones
y también del Formulario. Quedó literal. Si se quiere diferenciar, es un campo del panel.

### Traducciones al inglés
Todos los briefs llegaron solo en español. El inglés lo redacté yo en todas las páginas
nuevas. **Conviene que el cliente lo revise** antes del cambio de dominio.

---

## 4. Técnico, no del cliente

### `index.html` de respaldo
Es el archivo estático que solo se sirve si la base de datos falla, y **sigue teniendo el
Home viejo**. Cuando se valide el sitio, hay que guardar el HTML renderizado del Home
nuevo y reemplazarlo.

### Enlaces absolutos dentro de los artículos del blog — DECIDIDO: no se toca
Los 13 posts traen 78 enlaces escritos como `https://aldea.work/...` en lugar de rutas
relativas. **Se deja así a propósito:** el sitio se migra al dominio oficial aldea.work,
donde esos enlaces resuelven correctamente.

Único efecto mientras tanto: desde temporal, un enlace interno de un artículo lleva al
WordPress viejo. Avisarlo si se manda la liga de temporal a revisión.

### Mapa con varios puntos
Hoy el mapa es un embed centrado en la sede, con los puntos cercanos como lista al lado.
Marcar varios pines personalizados dentro del mapa requiere clave de Google Maps API o
un mapa de "My Maps". Se puede hacer si el cliente lo quiere así.


---

## 5. Para el día del cambio a aldea.work

Estos no son de contenido, son de accesos y cuentas. Vienen de
`GUIA-CAMBIO-A-DOMINIO-PRINCIPAL.md` y `PLAN-MIGRACION-SEO.md`.

- **Acceso al docroot de `aldea.work`** o confirmación de que es el mismo hosting que
  temporal (todo apunta a que sí).
- **Google Search Console de aldea.work** — para verificar la propiedad, subir el
  sitemap nuevo y **eliminar los dos sitemaps viejos** (el estático de xml-sitemaps y el
  de Yoast). Sin esto, Google seguirá rastreando URLs que ya no existen.
- **CSV maestro de URLs de Search Console** — para cargar el mapeo final de
  redirecciones 301. La mayoría de slugs se conservan, así que deberían ser pocas.
- **Confirmar GA4** — el contenedor GTM ya está configurado (`GTM-KN2FDL6J`); falta
  confirmar que GA4 está conectado dentro de GTM y midiendo.
- **Respaldo completo del WordPress actual** antes del corte, por si hay que revertir.
- **Forzar HTTPS a nivel de servidor** (no por `.htaccess`: en LiteSpeed genera bucle de
  redirección, ya pasó una vez).

---

## Ya resuelto (no preguntar)

- **Open Graph y Twitter Cards (22 de septiembre de 2026)** → 15 etiquetas por pagina
  y 11 imagenes de 1200x630 en `/img/og/`. Antes, compartir cualquier enlace daba una
  vista previa vacia.
- **Pagina 404 (22 de septiembre)** → antes era un `<h1>` pelado de 28 bytes. Ahora
  lleva cabecera, pie y atajos a soluciones, sedes y el resto; devuelve 404 de verdad
  y no se indexa.
- **Datos estructurados (22 de septiembre)** → `Organization` en el Home y
  `LocalBusiness` en las cuatro sedes, con direccion troceada, telefono y correo.

- **Cotejo de los 8 briefs contra el sitio (24 de agosto de 2026)** → las 11 páginas con
  brief coinciden en orden de secciones y en textos. Se encontraron y corrigieron dos
  cosas: `/lo-que-ofrecemos/` seguía usando la lista vieja de amenidades, con "cerveza",
  "Acceso total" y "Eventos" (los tres en la lista de eliminar de cuatro briefs), y
  faltaban acentos en varios textos fijos (Recepción, Áreas comunes, Café y bebidas,
  Paquetería, Próximamente, Teléfono, León, Querétaro, San Luis Potosí, Galerías).

- **"Aldea Park" vs "Aldea The Park"** → confirmado **Aldea Park**, aplicado en toda la base.
- **Imágenes del WordPress viejo** → las 58 se migraron a `/img/wp/`. Cero referencias a
  `wp-content` en el sitio. Esto habría roto galerías y blog el día del cambio de dominio.
- **Landing de Oficinas Corporativas** → publicada en `/oficinas-corporativas/`. La URL
  vieja `/oficinas-personalizadas/`, que estaba en el sitemap del sitio publicado,
  redirige con **301** para conservar su posicionamiento. El menú, el footer y el bloque
  del Home ya apuntan a la nueva.
- **Meta descriptions de las sedes** → corregidas: usan la introducción larga de cada
  sede en vez del subtítulo corto del hero.
- **Solución `oficinas-personalizadas`** → despublicada para que el sitemap no anuncie
  una URL que redirige.
- **Menú "Ciudad — Sede"** → el brief del Home lo pedía y no se había aplicado;
  detectado al cotejar los PDF originales y ya corregido.
- **Videos de sede** → 3 de 4 recuperados del WordPress viejo (SLP, Leon, Ags). Solo
  falta Centro Sur, que aun no abre.
- **Fotos de proyecto corporativo** → 17 recuperadas y aplicadas al hero y a la seccion
  principal de /oficinas-corporativas/.
- **Dirección de Aldea Park** → confirmada por el cliente:
  `Blvd. Antonio Rocha Cordero 157-D201, Fracc. Desarrollo del Pedregal, 78295 San Luis
  Potosí, S.L.P.` El código postal correcto es **78295**; la base tenía 78395.
  Actualizada en la ficha de la sede, el hero, el FAQ y las tarjetas.

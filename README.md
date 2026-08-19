# Aldea — Sitio Web 2026

Rediseño del sitio de Aldea Networking (aldea.work), migrando **fuera de WordPress** a un stack propio Vite + React. Mantiene contenido, marca y assets del sitio actual con una nueva propuesta visual.

## Stack
- **Vite + React 18** (SPA con react-router-dom)
- **i18n bilingüe ES/EN** (i18next / react-i18next) — el idioma se guarda en `localStorage`
- **CSS con design tokens** (sin dependencia de build de Tailwind) — ver `src/styles/tokens.css`

## Cómo correr
```bash
npm install
npm run dev      # http://localhost:5173
npm run build    # genera /dist para producción
```

## Sistema de diseño (base de marca)
- Azul de marca oficial: **#182943** (extraído del logo)
- Tipografía de marca: **Futura** (títulos) → **Jost** como web-font equivalente; **Raleway** para texto
- La paleta de acento (`--accent`) y neutros son **propuesta nueva** y se ajustarán con las referencias visuales del cliente.

## Estructura
```
public/
  logos/           logos de marca (azul, blanco, favicon) + logos de clientes
  img/             fotos de sucursales, optimizadas a .webp
src/
  components/      Header, Footer (+ sus .css)
  pages/           Home (+ home.css)
  i18n/            es.json, en.json, index.js
  styles/          tokens.css, global.css
```

## Mapa de páginas (del sitio actual → a construir)
| Página | Ruta actual | Estado |
|---|---|---|
| Inicio | `/` | ✅ construida (v0) |
| Acerca de Aldea | `/acerca-de-aldea/` | pendiente |
| Lo que ofrecemos | `/lo-que-ofrecemos/` | pendiente |
| Oficina Privada | `/oficina-privada/` | pendiente |
| Coworking | `/coworking/` | pendiente |
| Domicilio Virtual | `/domicilio-virtual/` | pendiente |
| Escritorio Privado | `/escritorio-privado/` | pendiente |
| Oficinas Personalizadas | `/oficinas-personalizadas/` | pendiente |
| Ubicaciones | `/ubicaciones/` | pendiente |
| Sucursal Aguascalientes | `/oficinas-en-renta-aguascalientes/` | pendiente |
| Sucursal León | `/oficinas-en-renta-leon-guanajuato/` | pendiente |
| Sucursal San Luis Potosí | `/oficinas-en-renta-san-luis-potosi/` | pendiente |
| Sucursal Querétaro | `/oficinas-en-renta-queretaro/` | pendiente |
| Blog + posts | `/blog/` | pendiente |
| Contacto | `/contacto/` | pendiente (form embebido en Home) |
| Términos y condiciones | `/terminos-y-condiciones/` | pendiente |
| Políticas de privacidad | `/politicas-de-privacidad/` | pendiente |
| Preguntas frecuentes | `/preguntas-frecuentes/` | pendiente |

## Pendientes / notas
- El **formulario de contacto** hoy no envía (Ninja Forms en WP). Definir backend/servicio (Formspree, Resend, API propia) o esperar al CMS dedicado.
- **Ruteo bilingüe**: falta prefijo `/en/` por ruta (hoy el idioma se cambia con el selector, contenido traducido vía i18n).
- Logos de clientes reales: solo se tienen algunos SVG; el resto se muestra como texto por ahora.
- Futuro: **CMS dedicado** para el equipo de Aldea con módulos mínimos (ubicaciones, blog, testimonios).

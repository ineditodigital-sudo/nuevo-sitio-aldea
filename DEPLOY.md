# Despliegue en cPanel — Aldea 2026

> **OBSOLETO.** Este documento describe el prototipo de React/Vite que se abandono.
> El sitio real es `sitio-produccion/` (PHP) y se despliega con la herramienta de
> [`deploy/`](deploy/README.md). Se conserva solo como referencia historica.

Arquitectura: **frontend estático (React/Vite) + API PHP + MySQL**. Todo vive en el mismo dominio.

```
public_html/
├── index.html, assets/…   ← build del frontend (npm run build → carpeta dist/)
├── img/  logos/           ← se copian desde public/ (van dentro del build)
└── api/                   ← carpeta server/api/ + config.php
    ├── index.php
    ├── bootstrap.php
    ├── .htaccess
    └── config.php         ← creado a partir de config.example.php
```

## 1. Crear la base de datos (cPanel → MySQL® Databases)
1. Crea una base de datos, p. ej. `usuario_aldea`.
2. Crea un usuario MySQL y una contraseña fuerte.
3. Asígnalo a la base con **ALL PRIVILEGES**.

## 2. Importar esquema y contenido (cPanel → phpMyAdmin)
1. Selecciona la base creada.
2. Pestaña **Importar** → sube `server/database/schema.sql` → Continuar.
3. Repite con `server/database/seed.sql` (trae ubicaciones, soluciones,
   testimonios, clientes y los 13 posts del blog ya migrados).

## 3. Configurar la API
1. Copia `server/config.example.php` como `server/config.php`.
2. Pon el nombre de la BD, usuario y contraseña del paso 1.
3. En `cors_origins` deja tu dominio real: `['https://aldea.work']`.

## 4. Compilar el frontend
En tu equipo:
```bash
npm install
# .env con la URL del API (mismo dominio):
echo "VITE_API_URL=https://aldea.work" > .env
npm run build          # genera /dist
```

## 5. Subir archivos
- Sube **el contenido de `dist/`** a `public_html/`.
- Sube la carpeta **`server/api/`** (con tu `config.php`) a `public_html/api/`.
- Sube **`server/database/`** solo si quieres tener los .sql a mano
  (el `.htaccess` ya bloquea el acceso web a los .sql).

## 6. SPA routing (opcional pero recomendado)
Para que las rutas de React funcionen al recargar, crea
`public_html/.htaccess`:
```apache
RewriteEngine On
RewriteBase /
# No tocar la API ni archivos reales
RewriteRule ^api/ - [L]
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule ^ index.html [L]
```

## 7. Probar
- `https://aldea.work/api` → `{"name":"Aldea API","status":"ok"}`
- `https://aldea.work/api/home?lang=es` → JSON con el contenido.
- El formulario de contacto guardará leads en la tabla `leads` y (si el
  hosting permite `mail()`) enviará aviso a `lead_notify_email`.

## Notas
- **Node.js no es necesario en el servidor**: el frontend se sube ya compilado.
- El usuario admin de `seed.sql` es un placeholder — regenera el hash con
  `password_hash('tu-clave', PASSWORD_DEFAULT)` antes de usar el panel.
- El panel de administración (CMS) se construirá en una etapa posterior
  sobre esta misma API y base de datos.

# Copia local del sitio

Sirve para ver y probar `sitio-produccion/` en tu máquina sin MySQL ni FTP.
Solo cubre las páginas públicas; el panel `/admin` necesita la base real.

## Requisitos

- PHP 8 con la extensión `pdo_sqlite` (viene activa en las instalaciones normales).
- Python 3.

## Primera vez

```bash
python local/crear-base.py
```

Crea `local/aldea-local.sqlite` a partir de `sitio-produccion/cms/contenido.sql`, que trae el contenido publicado. Vuelve a correrlo cada vez que se regenere `contenido.sql`.

Si hay una migración que todavía no está en `contenido.sql`, pásala como argumento y se aplica encima:

```bash
python local/crear-base.py sitio-produccion/cms/migracion-nueva.sql
```

## Levantar el sitio

```bash
php -S 127.0.0.1:8765 -t sitio-produccion local/router.php
```

Abre http://127.0.0.1:8765. En el Claude desktop la configuración `aldea-local` de `.claude/launch.json` hace lo mismo.

## Cómo funciona

- `local/router.php` hace lo mismo que el `.htaccess` del servidor: sirve los archivos que existen y manda todo lo demás a `sitio-produccion/router.php`.
- También define `ALDEA_DB_DSN`. Con esa variable, `cms/db.php` se conecta a la base SQLite en vez de leer `cms/config.php`. En el servidor esa variable no existe, así que producción sigue usando MySQL.
- Las imágenes y videos que no están en el repo (lo que el cliente subió desde el panel a `/uploads/`) se piden a https://temporal.aldea.work.
- Al enviar un formulario, `send.php` guarda el registro en la tabla `leads` de la base local e intenta mandar el correo a contacto@aldea.work con `mail()`. Sin un servidor de correo configurado en tu PHP (lo normal en Windows), el correo no sale. Si tu PHP sí tiene SMTP configurado, no pruebes formularios: le llegarían al cliente.

`aldea-local.sqlite` no se sube al repositorio.

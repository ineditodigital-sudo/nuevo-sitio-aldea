# Deploy a temporal.aldea.work

Herramienta de despliegue por FTP para `sitio-produccion/`.

```bash
cd deploy
python deploy.py status
```

## Comandos

| Comando | Qué hace |
|---|---|
| `status` | Compara local contra remoto y lista lo que difiere. Empieza siempre por aquí. |
| `push <ruta>...` | Sube archivos o carpetas concretos. Acepta rutas relativas a `sitio-produccion/`. |
| `push-changed` | Sube todo lo que difiere. Muestra la lista y pide confirmación. |
| `pull <ruta>...` | Baja del servidor al local (útil si alguien editó directo en cPanel). |
| `ls [ruta]` | Lista una carpeta remota. |
| `dump` | Respalda las tablas del CMS a `dumps/`. |
| `sql <archivo.sql>` | Ejecuta un `.sql` **en el servidor**. Sube el archivo, respalda la base y lo corre. |
| `restore <carpeta>` | Revierte usando un respaldo de `bak/`. |

Ejemplos:

```bash
python deploy.py push cms/tpl_home.php s6.css
python deploy.py push cms
python deploy.py sql cms/mi-migracion.sql
python deploy.py restore 20260820-154500
```

## Exportar el contenido al repositorio

`sitio-produccion/cms/contenido.sql` es la copia del contenido publicado (ver el README de la raíz). Después de una migración o de cambios grandes en el panel, se regenera así:

```bash
python deploy.py dump
python exportar-contenido.py dumps/<fecha>-manual.json ../sitio-produccion/cms/contenido.sql <AAAA-MM-DD>
```

Deja fuera `leads` y `users`, igual que antes.

## Cómo protege el trabajo

- **Todo push respalda primero.** Lo que se va a sobrescribir se baja a `bak/<fecha-hora>/` antes de subir nada. `restore` lo devuelve.
- **Verifica después de subir.** Compara el tamaño remoto contra el local archivo por archivo.
- **`sql` respalda la base antes de ejecutar**, a `dumps/`. Cada sentencia se reporta por separado; si una falla, lo dice y sigue con las demás.
- **El runner de SQL es efímero.** Para ejecutar SQL sube un PHP con nombre aleatorio y token de un solo uso, lo llama y lo borra — incluso si la ejecución falla. `cms/` está cerrada por `.htaccess` (ahí vive `config.php`), por eso no se puede ejecutar nada desde ahí.
- **Nunca se manejan las credenciales de la base.** El runner usa la conexión del propio CMS vía `cms/db.php`.

## Lo que nunca se toca

Definido en `EXCLUDE` / `EXCLUDE_DIRS` dentro de `deploy.py`:

```
cms/config.php     credenciales de la base, es del servidor
.htaccess          lo genera cPanel + las reglas del router
php.ini, .user.ini
error_log
uploads/           lo que sube el cliente desde el panel
.well-known/
```

Si alguna vez hay que tocar uno de esos, se hace a mano por cPanel.

## Credenciales

Están en `ftp.conf`, que **no debe subirse a ningún repo ni al servidor**. Ya está en el `.gitignore` de la raíz, junto con `bak/` y `dumps/` (contienen datos del sitio).

Si se rota la contraseña FTP, se cambia ahí y ya.

## Notas del servidor

- `temporal.aldea.work` → `184.168.20.11`. **No usar `ftp.aldea.work`**: el dominio principal está detrás de Cloudflare, que no hace proxy de FTP.
- El usuario FTP se loguea con el formato `usuario@aldea.work`, no solo el usuario.
- El certificado FTPS es del hostname del servidor, no del dominio. La conexión va cifrada pero sin validar el nombre.
- El docroot es `public_html/temporal.aldea.work`. Ojo: `public_html/` a secas es el **WordPress vivo** de aldea.work.

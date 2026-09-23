"""Regenera sitio-produccion/cms/contenido.sql desde un respaldo JSON del CMS (deploy.py dump),
con el mismo formato que el archivo original: DELETE + INSERT por tabla, 80 filas por INSERT.
uso: python exportar-contenido.py <dumps/fecha-manual.json> <../sitio-produccion/cms/contenido.sql> <AAAA-MM-DD>
Deja fuera leads (datos personales) y users (contrasenas del panel)."""
import json, sys, io

TABLAS = ['settings', 'menu_items', 'redirects', 'pages', 'blocks', 'solutions', 'locations', 'testimonials', 'clients', 'posts']
LOTE = 80

def valor(v):
    if v is None:
        return 'NULL'
    if isinstance(v, bool):
        return '1' if v else '0'
    if isinstance(v, (int, float)):
        return str(v)
    s = str(v)
    s = (s.replace('\\', '\\\\').replace('\x00', '\\0').replace('\n', '\\n').replace('\r', '\\r')
          .replace('\x1a', '\\Z').replace("'", "''"))
    return "'" + s + "'"

def main(dump_path, out_path, fecha):
    d = json.load(io.open(dump_path, encoding='utf-8'))
    o = []
    w = o.append
    w('-- Contenido del sitio de Aldea (paginas, bloques, sedes, blog, ajustes).')
    w('-- Generado desde el CMS el %s.' % fecha)
    w('--')
    w('-- Para levantar una copia del sitio: primero cms/schema.sql (la estructura)')
    w('-- y despues este archivo (el contenido). Vacia esas tablas antes de cargar.')
    w('--')
    w('-- NO incluye la tabla leads (datos personales de prospectos) ni users')
    w('-- (contrasenas del panel). Esos se quedan solo en el servidor.')
    w('')
    w('SET NAMES utf8mb4;')
    w('SET FOREIGN_KEY_CHECKS=0;')
    for t in TABLAS:
        filas = d[t]
        if not isinstance(filas, list):
            raise SystemExit('la tabla %s no vino en el respaldo' % t)
        w('')
        w('-- %s: %d filas' % (t, len(filas)))
        w('DELETE FROM `%s`;' % t)
        if not filas:
            continue
        cols = list(filas[0].keys())
        cab = 'INSERT INTO `%s` (%s) VALUES' % (t, ','.join('`%s`' % c for c in cols))
        for i in range(0, len(filas), LOTE):
            w(cab)
            lote = filas[i:i + LOTE]
            w(',\n'.join('(' + ','.join(valor(f[c]) for c in cols) + ')' for f in lote) + ';')
    w('')
    w('SET FOREIGN_KEY_CHECKS=1;')
    io.open(out_path, 'w', encoding='utf-8', newline='\n').write('\n'.join(o) + '\n')

if __name__ == '__main__':
    main(*sys.argv[1:4])

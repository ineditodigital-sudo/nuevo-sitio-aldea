<?php
/**
 * ALDEA API — Front controller.
 * Rutas (todas devuelven JSON). Parámetro de idioma: ?lang=es|en
 *
 *  GET  /api/content                 -> textos de secciones {clave: valor}
 *  GET  /api/solutions               -> lista de soluciones
 *  GET  /api/solutions/{slug}        -> una solución
 *  GET  /api/locations               -> lista de ubicaciones
 *  GET  /api/locations/{slug}        -> una ubicación
 *  GET  /api/testimonials            -> testimonios
 *  GET  /api/clients                 -> logos de clientes
 *  GET  /api/posts                   -> lista de posts del blog
 *  GET  /api/posts/{slug}            -> un post
 *  GET  /api/pages/{slug}            -> una página (legal/genérica)
 *  GET  /api/home                    -> payload agregado para la Home
 *  POST /api/leads                   -> registra un lead del formulario
 */
require __DIR__ . '/bootstrap.php';

// --- Resolver ruta ---
$uri  = parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH);
$base = '/api';
$path = $uri;
if (strpos($uri, $base) === 0) $path = substr($uri, strlen($base));
$path = '/' . trim($path, '/');
$parts = $path === '/' ? [] : explode('/', trim($path, '/'));
$method = $_SERVER['REQUEST_METHOD'] ?? 'GET';
$L = lang();

$resource = $parts[0] ?? '';
$slug     = $parts[1] ?? null;

try {
    switch ($resource) {
        case '': // /api
            json_out(['name' => 'Aldea API', 'version' => '1.0', 'status' => 'ok']);

        case 'content':
            $rows = db()->query("SELECT ckey, value_es, value_en FROM content")->fetchAll();
            $map = [];
            foreach ($rows as $r) {
                $map[$r['ckey']] = ($L === 'en' && !empty($r['value_en'])) ? $r['value_en'] : $r['value_es'];
            }
            json_out($map);

        case 'solutions':
            if ($slug) {
                $st = db()->prepare("SELECT * FROM solutions WHERE slug=? AND published=1");
                $st->execute([$slug]);
                $row = $st->fetch();
                $row ? json_out(localize($row, $L)) : json_error('No encontrado', 404);
            }
            $rows = db()->query("SELECT * FROM solutions WHERE published=1 ORDER BY sort, id")->fetchAll();
            json_out(localize_all($rows, $L));

        case 'locations':
            if ($slug) {
                $st = db()->prepare("SELECT * FROM locations WHERE slug=? AND published=1");
                $st->execute([$slug]);
                $row = $st->fetch();
                $row ? json_out(localize($row, $L)) : json_error('No encontrado', 404);
            }
            $rows = db()->query("SELECT * FROM locations WHERE published=1 ORDER BY sort, id")->fetchAll();
            json_out(localize_all($rows, $L));

        case 'testimonials':
            $rows = db()->query("SELECT * FROM testimonials WHERE published=1 ORDER BY sort, id")->fetchAll();
            json_out(localize_all($rows, $L));

        case 'clients':
            $rows = db()->query("SELECT id, name, logo FROM clients WHERE published=1 ORDER BY sort, id")->fetchAll();
            json_out($rows);

        case 'posts':
            if ($slug) {
                $st = db()->prepare("SELECT * FROM posts WHERE slug=? AND status='publish'");
                $st->execute([$slug]);
                $row = $st->fetch();
                $row ? json_out(localize($row, $L)) : json_error('No encontrado', 404);
            }
            $rows = db()->query(
                "SELECT id, slug, title_es, title_en, excerpt_es, excerpt_en, cover, author, published_at
                 FROM posts WHERE status='publish' ORDER BY published_at DESC"
            )->fetchAll();
            json_out(localize_all($rows, $L));

        case 'pages':
            if (!$slug) json_error('Slug requerido', 400);
            $st = db()->prepare("SELECT * FROM pages WHERE slug=? AND published=1");
            $st->execute([$slug]);
            $row = $st->fetch();
            $row ? json_out(localize($row, $L)) : json_error('No encontrado', 404);

        case 'home':
            $sol  = db()->query("SELECT * FROM solutions WHERE published=1 ORDER BY sort, id LIMIT 3")->fetchAll();
            $loc  = db()->query("SELECT * FROM locations WHERE published=1 ORDER BY sort, id")->fetchAll();
            $test = db()->query("SELECT * FROM testimonials WHERE published=1 ORDER BY sort, id")->fetchAll();
            $cli  = db()->query("SELECT id,name,logo FROM clients WHERE published=1 ORDER BY sort, id")->fetchAll();
            $cont = db()->query("SELECT ckey, value_es, value_en FROM content")->fetchAll();
            $map = [];
            foreach ($cont as $r) $map[$r['ckey']] = ($L === 'en' && !empty($r['value_en'])) ? $r['value_en'] : $r['value_es'];
            json_out([
                'content'      => $map,
                'solutions'    => localize_all($sol, $L),
                'locations'    => localize_all($loc, $L),
                'testimonials' => localize_all($test, $L),
                'clients'      => $cli,
            ]);

        case 'leads':
            if ($method !== 'POST') json_error('Método no permitido', 405);
            $b = json_body();
            $name = trim($b['name'] ?? '');
            if ($name === '') json_error('El nombre es obligatorio', 422);
            $st = db()->prepare(
                "INSERT INTO leads (name,email,phone,message,source,location_id,ip)
                 VALUES (:name,:email,:phone,:message,:source,:loc,:ip)"
            );
            $st->execute([
                ':name'    => $name,
                ':email'   => $b['email']   ?? null,
                ':phone'   => $b['phone']   ?? null,
                ':message' => $b['message'] ?? null,
                ':source'  => $b['source']  ?? 'web',
                ':loc'     => $b['location_id'] ?? null,
                ':ip'      => $_SERVER['REMOTE_ADDR'] ?? null,
            ]);
            // Notificación por correo (best-effort)
            if (!empty($config['lead_notify_email'])) {
                $to = $config['lead_notify_email'];
                $subject = 'Nuevo lead desde el sitio — ' . $name;
                $bodyMsg = "Nombre: $name\nEmail: " . ($b['email'] ?? '-') .
                           "\nTeléfono: " . ($b['phone'] ?? '-') .
                           "\nMensaje: " . ($b['message'] ?? '-') .
                           "\nOrigen: " . ($b['source'] ?? 'web');
                $headers = 'From: ' . ($config['mail_from'] ?? 'no-reply@aldea.work');
                @mail($to, $subject, $bodyMsg, $headers);
            }
            json_out(['ok' => true, 'id' => (int) db()->lastInsertId()], 201);

        default:
            json_error('Ruta no encontrada', 404);
    }
} catch (Throwable $e) {
    json_error('Error interno del servidor', 500);
}

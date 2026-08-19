<?php
/**
 * Bootstrap: config, conexión PDO, helpers de respuesta/idioma.
 */
declare(strict_types=1);

// --- Cargar config ---
$configPath = __DIR__ . '/../config.php';
if (!file_exists($configPath)) {
    http_response_code(500);
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode(['error' => 'Falta config.php. Copia config.example.php.']);
    exit;
}
$config = require $configPath;

// --- CORS ---
$origins = $config['cors_origins'] ?? ['*'];
$reqOrigin = $_SERVER['HTTP_ORIGIN'] ?? '';
if (in_array('*', $origins, true)) {
    header('Access-Control-Allow-Origin: *');
} elseif ($reqOrigin && in_array($reqOrigin, $origins, true)) {
    header('Access-Control-Allow-Origin: ' . $reqOrigin);
    header('Vary: Origin');
}
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json; charset=utf-8');

if (($_SERVER['REQUEST_METHOD'] ?? 'GET') === 'OPTIONS') {
    http_response_code(204);
    exit;
}

// --- Conexión PDO ---
function db(): PDO {
    static $pdo = null;
    global $config;
    if ($pdo === null) {
        $d = $config['db'];
        $dsn = "mysql:host={$d['host']};dbname={$d['name']};charset={$d['charset']}";
        try {
            $pdo = new PDO($dsn, $d['user'], $d['pass'], [
                PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES   => false,
            ]);
        } catch (PDOException $e) {
            json_error('No se pudo conectar a la base de datos', 500);
        }
    }
    return $pdo;
}

// --- Helpers ---
function json_out($data, int $code = 200): void {
    http_response_code($code);
    echo json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit;
}
function json_error(string $msg, int $code = 400): void {
    json_out(['error' => $msg], $code);
}

/** Idioma solicitado: ?lang=es|en (default es) */
function lang(): string {
    $l = strtolower($_GET['lang'] ?? 'es');
    return $l === 'en' ? 'en' : 'es';
}

/**
 * Colapsa columnas *_es / *_en al idioma pedido.
 * name_es/name_en -> name.  Si _en es NULL, cae a _es.
 */
function localize(array $row, string $lang): array {
    $out = [];
    foreach ($row as $k => $v) {
        if (preg_match('/^(.*)_es$/', $k, $m)) {
            $base = $m[1];
            $en = $row[$base . '_en'] ?? null;
            $out[$base] = ($lang === 'en' && $en !== null && $en !== '') ? $en : $v;
        } elseif (preg_match('/_en$/', $k)) {
            continue; // ya manejado por su par _es
        } else {
            $out[$k] = $v;
        }
    }
    return $out;
}
function localize_all(array $rows, string $lang): array {
    return array_map(fn($r) => localize($r, $lang), $rows);
}

/** Body JSON de peticiones POST */
function json_body(): array {
    $raw = file_get_contents('php://input');
    $data = json_decode($raw, true);
    return is_array($data) ? $data : [];
}

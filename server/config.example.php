<?php
/**
 * ALDEA API — Configuración
 * Copia este archivo como `config.php` y coloca los datos reales de tu
 * base de datos de cPanel. NO subas config.php a control de versiones.
 */
return [
    // --- Base de datos MySQL (cPanel > MySQL Databases) ---
    'db' => [
        'host'    => 'localhost',
        'name'    => 'usuario_aldea',      // nombre de la BD en cPanel
        'user'    => 'usuario_aldeauser',  // usuario MySQL
        'pass'    => 'CAMBIA_ESTA_PASSWORD',
        'charset' => 'utf8mb4',
    ],

    // --- CORS: dominios permitidos para consumir la API ---
    // En producción usa tu dominio real: ['https://aldea.work']
    'cors_origins' => ['*'],

    // --- Notificación de leads del formulario de contacto ---
    'lead_notify_email' => 'contacto@aldea.work',
    'mail_from'         => 'no-reply@aldea.work',
];

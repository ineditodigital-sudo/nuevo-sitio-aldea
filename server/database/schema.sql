-- ============================================================
-- ALDEA — Esquema MySQL (limpio, bilingüe ES/EN)
-- Compatible con MySQL 5.7+/8 y MariaDB (cPanel).
-- Convención bilingüe: columnas *_es / *_en. Si _en es NULL,
-- la API cae automáticamente a _es.
-- ============================================================
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ---------- Textos editables de secciones (Home, etc.) ----------
CREATE TABLE IF NOT EXISTS `content` (
  `id`          INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ckey`        VARCHAR(120) NOT NULL,           -- ej: hero.title, contact.phone
  `value_es`    TEXT NULL,
  `value_en`    TEXT NULL,
  `updated_at`  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_content_ckey` (`ckey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------- Soluciones (Lo que ofrecemos) ----------
CREATE TABLE IF NOT EXISTS `solutions` (
  `id`          INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `slug`        VARCHAR(160) NOT NULL,
  `title_es`    VARCHAR(200) NOT NULL,
  `title_en`    VARCHAR(200) NULL,
  `excerpt_es`  TEXT NULL,
  `excerpt_en`  TEXT NULL,
  `body_es`     MEDIUMTEXT NULL,
  `body_en`     MEDIUMTEXT NULL,
  `image`       VARCHAR(255) NULL,
  `icon`        VARCHAR(80) NULL,
  `sort`        INT NOT NULL DEFAULT 0,
  `published`   TINYINT(1) NOT NULL DEFAULT 1,
  `created_at`  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_solutions_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------- Ubicaciones (sucursales) ----------
CREATE TABLE IF NOT EXISTS `locations` (
  `id`          INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `slug`        VARCHAR(160) NOT NULL,
  `name`        VARCHAR(160) NOT NULL,           -- Aldea Poliforum
  `city_es`     VARCHAR(120) NOT NULL,
  `city_en`     VARCHAR(120) NULL,
  `address_es`  TEXT NULL,
  `address_en`  TEXT NULL,
  `body_es`     MEDIUMTEXT NULL,
  `body_en`     MEDIUMTEXT NULL,
  `phone`       VARCHAR(40) NULL,
  `lat`         DECIMAL(10,7) NULL,
  `lng`         DECIMAL(10,7) NULL,
  `maps_url`    VARCHAR(500) NULL,
  `image`       VARCHAR(255) NULL,
  `sort`        INT NOT NULL DEFAULT 0,
  `published`   TINYINT(1) NOT NULL DEFAULT 1,
  `created_at`  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_locations_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------- Testimonios ----------
CREATE TABLE IF NOT EXISTS `testimonials` (
  `id`          INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name`        VARCHAR(160) NOT NULL,
  `company`     VARCHAR(160) NULL,
  `quote_es`    TEXT NOT NULL,
  `quote_en`    TEXT NULL,
  `avatar`      VARCHAR(255) NULL,
  `logo`        VARCHAR(255) NULL,
  `sort`        INT NOT NULL DEFAULT 0,
  `published`   TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------- Clientes (logos) ----------
CREATE TABLE IF NOT EXISTS `clients` (
  `id`          INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name`        VARCHAR(160) NOT NULL,
  `logo`        VARCHAR(255) NULL,
  `sort`        INT NOT NULL DEFAULT 0,
  `published`   TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------- Blog ----------
CREATE TABLE IF NOT EXISTS `posts` (
  `id`           INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `slug`         VARCHAR(200) NOT NULL,
  `title_es`     VARCHAR(255) NOT NULL,
  `title_en`     VARCHAR(255) NULL,
  `excerpt_es`   TEXT NULL,
  `excerpt_en`   TEXT NULL,
  `body_es`      LONGTEXT NULL,
  `body_en`      LONGTEXT NULL,
  `cover`        VARCHAR(255) NULL,
  `author`       VARCHAR(120) NULL,
  `status`       ENUM('draft','publish') NOT NULL DEFAULT 'publish',
  `published_at` DATETIME NULL,
  `created_at`   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_posts_slug` (`slug`),
  KEY `ix_posts_status_date` (`status`,`published_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------- Páginas genéricas (legales, acerca, etc.) ----------
CREATE TABLE IF NOT EXISTS `pages` (
  `id`         INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `slug`       VARCHAR(200) NOT NULL,
  `title_es`   VARCHAR(255) NOT NULL,
  `title_en`   VARCHAR(255) NULL,
  `body_es`    LONGTEXT NULL,
  `body_en`    LONGTEXT NULL,
  `seo_title_es` VARCHAR(255) NULL,
  `seo_title_en` VARCHAR(255) NULL,
  `seo_desc_es`  VARCHAR(300) NULL,
  `seo_desc_en`  VARCHAR(300) NULL,
  `published`  TINYINT(1) NOT NULL DEFAULT 1,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_pages_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------- Leads (formulario de contacto) ----------
CREATE TABLE IF NOT EXISTS `leads` (
  `id`          INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name`        VARCHAR(160) NOT NULL,
  `email`       VARCHAR(200) NULL,
  `phone`       VARCHAR(60) NULL,
  `message`     TEXT NULL,
  `source`      VARCHAR(120) NULL,               -- ej: home, contacto, landing-leon
  `location_id` INT UNSIGNED NULL,
  `status`      ENUM('new','contacted','archived') NOT NULL DEFAULT 'new',
  `ip`          VARCHAR(64) NULL,
  `created_at`  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ix_leads_status` (`status`),
  CONSTRAINT `fk_leads_location` FOREIGN KEY (`location_id`) REFERENCES `locations`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------- Usuarios (para el admin/CMS futuro) ----------
CREATE TABLE IF NOT EXISTS `users` (
  `id`            INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name`          VARCHAR(160) NOT NULL,
  `email`         VARCHAR(200) NOT NULL,
  `password_hash` VARCHAR(255) NOT NULL,
  `role`          ENUM('admin','editor') NOT NULL DEFAULT 'editor',
  `created_at`    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_users_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;

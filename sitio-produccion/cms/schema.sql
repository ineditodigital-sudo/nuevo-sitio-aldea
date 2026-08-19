-- ============================================================
-- ALDEA CMS — Esquema MySQL (sitio dinámico + panel)
-- Cubre: páginas/secciones, soluciones, ubicaciones, blog,
-- testimonios, clientes, precios, menús, SEO, media, usuarios,
-- ajustes (incl. tokens de Google), redirecciones y leads.
-- ============================================================
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ---------- Usuarios del panel ----------
CREATE TABLE IF NOT EXISTS `users` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(120) NOT NULL,
  `username` VARCHAR(60) NOT NULL,
  `email` VARCHAR(160) NULL,
  `password_hash` VARCHAR(255) NOT NULL,
  `role` ENUM('admin','editor') NOT NULL DEFAULT 'admin',
  `last_login` DATETIME NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `uq_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------- Ajustes globales (clave/valor) ----------
-- Guarda: telefono, email, gtm_id, ga4_property_id, gsc_site_url,
-- google_oauth (json con tokens), redes sociales, etc.
CREATE TABLE IF NOT EXISTS `settings` (
  `skey` VARCHAR(80) PRIMARY KEY,
  `value` MEDIUMTEXT NULL,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------- Media (biblioteca de imágenes) ----------
CREATE TABLE IF NOT EXISTS `media` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `filename` VARCHAR(255) NOT NULL,
  `path` VARCHAR(400) NOT NULL,            -- /uploads/2026/07/foto.webp
  `alt` VARCHAR(255) NULL,
  `width` INT NULL, `height` INT NULL, `bytes` INT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------- Páginas (router + menús + SEO) ----------
CREATE TABLE IF NOT EXISTS `pages` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `slug` VARCHAR(200) NOT NULL,            -- '' = home
  `type` ENUM('home','simple','solution_index','location_index','blog_index','legal','faq','contact') NOT NULL DEFAULT 'simple',
  `title_es` VARCHAR(200) NOT NULL, `title_en` VARCHAR(200) NULL,
  `seo_title_es` VARCHAR(255) NULL, `seo_title_en` VARCHAR(255) NULL,
  `seo_desc_es` VARCHAR(320) NULL, `seo_desc_en` VARCHAR(320) NULL,
  `og_image` VARCHAR(400) NULL,
  `noindex` TINYINT(1) DEFAULT 0,
  `published` TINYINT(1) DEFAULT 1,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `uq_pages_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------- Bloques editables por sección (editor "campos por sección") ----------
-- Cada campo del sitio = una fila. skey ej: 'hero.title', 'about.card1.text'
CREATE TABLE IF NOT EXISTS `blocks` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `page_id` INT UNSIGNED NOT NULL,
  `section` VARCHAR(80) NOT NULL,          -- 'hero', 'nosotros', 'contacto'...
  `skey` VARCHAR(120) NOT NULL,            -- clave del campo dentro de la seccion
  `type` ENUM('text','richtext','image','button','link','eyebrow','list') NOT NULL DEFAULT 'text',
  `label` VARCHAR(160) NULL,               -- etiqueta legible para el panel
  `value_es` MEDIUMTEXT NULL, `value_en` MEDIUMTEXT NULL,
  `href` VARCHAR(400) NULL,                -- para button/link
  `sort` INT DEFAULT 0,
  KEY `ix_blocks_page` (`page_id`,`section`,`sort`),
  CONSTRAINT `fk_blocks_page` FOREIGN KEY (`page_id`) REFERENCES `pages`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------- Soluciones ----------
CREATE TABLE IF NOT EXISTS `solutions` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `slug` VARCHAR(160) NOT NULL,
  `title_es` VARCHAR(200) NOT NULL, `title_en` VARCHAR(200) NULL,
  `excerpt_es` TEXT NULL, `excerpt_en` TEXT NULL,
  `body_es` MEDIUMTEXT NULL, `body_en` MEDIUMTEXT NULL,
  `features_es` TEXT NULL, `features_en` TEXT NULL,     -- json/lista
  `hero_image` VARCHAR(400) NULL,
  `gallery` MEDIUMTEXT NULL,                            -- json de rutas
  `seo_title_es` VARCHAR(255) NULL, `seo_desc_es` VARCHAR(320) NULL,
  `seo_title_en` VARCHAR(255) NULL, `seo_desc_en` VARCHAR(320) NULL,
  `in_menu` TINYINT(1) DEFAULT 1,
  `sort` INT DEFAULT 0,
  `published` TINYINT(1) DEFAULT 1,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `uq_solutions_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------- Ubicaciones ----------
CREATE TABLE IF NOT EXISTS `locations` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `slug` VARCHAR(160) NOT NULL,
  `name` VARCHAR(160) NOT NULL,
  `city_es` VARCHAR(120) NOT NULL, `city_en` VARCHAR(120) NULL,
  `title_es` VARCHAR(200) NULL, `title_en` VARCHAR(200) NULL,
  `address_es` TEXT NULL, `address_en` TEXT NULL,
  `intro_es` MEDIUMTEXT NULL, `intro_en` MEDIUMTEXT NULL,
  `hero_image` VARCHAR(400) NULL,
  `gallery` MEDIUMTEXT NULL,                -- json de rutas
  `map_query` VARCHAR(400) NULL,
  `phone` VARCHAR(40) NULL,
  `price_privada` VARCHAR(20) NULL, `price_cowork` VARCHAR(20) NULL, `price_virtual` VARCHAR(20) NULL,
  `soon` TINYINT(1) DEFAULT 0, `opening_note_es` VARCHAR(160) NULL, `opening_note_en` VARCHAR(160) NULL,
  `nearby` MEDIUMTEXT NULL,                 -- json {categoria:[{lugar,tiempo}]}
  `seo_title_es` VARCHAR(255) NULL, `seo_desc_es` VARCHAR(320) NULL,
  `seo_title_en` VARCHAR(255) NULL, `seo_desc_en` VARCHAR(320) NULL,
  `in_menu` TINYINT(1) DEFAULT 1,
  `sort` INT DEFAULT 0,
  `published` TINYINT(1) DEFAULT 1,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `uq_locations_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------- Blog ----------
CREATE TABLE IF NOT EXISTS `posts` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `slug` VARCHAR(200) NOT NULL,
  `title_es` VARCHAR(255) NOT NULL, `title_en` VARCHAR(255) NULL,
  `excerpt_es` TEXT NULL, `excerpt_en` TEXT NULL,
  `body_es` LONGTEXT NULL, `body_en` LONGTEXT NULL,
  `cover_image` VARCHAR(400) NULL,
  `author` VARCHAR(120) NULL,
  `seo_title_es` VARCHAR(255) NULL, `seo_desc_es` VARCHAR(320) NULL,
  `status` ENUM('draft','publish') DEFAULT 'draft',
  `published_at` DATETIME NULL,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `uq_posts_slug` (`slug`),
  KEY `ix_posts_status` (`status`,`published_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------- Testimonios ----------
CREATE TABLE IF NOT EXISTS `testimonials` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(160) NOT NULL,
  `company` VARCHAR(160) NULL,
  `client_id` INT UNSIGNED NULL,           -- logo de empresa (clients)
  `quote_es` TEXT NOT NULL, `quote_en` TEXT NULL,
  `avatar` VARCHAR(400) NULL,
  `sort` INT DEFAULT 0,
  `published` TINYINT(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------- Clientes (logos del carrusel) ----------
CREATE TABLE IF NOT EXISTS `clients` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(160) NOT NULL,
  `logo` VARCHAR(400) NULL,
  `sort` INT DEFAULT 0,
  `published` TINYINT(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------- Menús (header/footer) ----------
CREATE TABLE IF NOT EXISTS `menu_items` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `menu` ENUM('header','footer') NOT NULL DEFAULT 'header',
  `label_es` VARCHAR(120) NOT NULL, `label_en` VARCHAR(120) NULL,
  `href` VARCHAR(400) NOT NULL,
  `parent_id` INT UNSIGNED NULL,
  `source` ENUM('custom','solution','location','page') DEFAULT 'custom',
  `source_id` INT UNSIGNED NULL,
  `sort` INT DEFAULT 0,
  `published` TINYINT(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------- Redirecciones 301 ----------
CREATE TABLE IF NOT EXISTS `redirects` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `from_path` VARCHAR(400) NOT NULL,
  `to_path` VARCHAR(400) NOT NULL,
  `code` SMALLINT DEFAULT 301,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `uq_from` (`from_path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------- Leads del formulario (respaldo en BD, además del correo) ----------
CREATE TABLE IF NOT EXISTS `leads` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(160) NOT NULL, `email` VARCHAR(200) NULL, `phone` VARCHAR(60) NULL,
  `message` TEXT NULL, `source` VARCHAR(160) NULL, `url` VARCHAR(400) NULL,
  `ip` VARCHAR(64) NULL, `status` ENUM('new','contacted','archived') DEFAULT 'new',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  KEY `ix_leads_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;

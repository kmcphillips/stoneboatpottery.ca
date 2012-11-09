CREATE TABLE `blocks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `body` text,
  `label` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `section_path` varchar(255) DEFAULT '',
  `accepts_image` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `permalink` varchar(255) DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_categories_on_permalink` (`permalink`),
  KEY `index_categories_on_active` (`active`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

CREATE TABLE `forms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `retail_price` float DEFAULT '0',
  `active` tinyint(1) DEFAULT '1',
  `subcategory_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `permalink` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_forms_on_active` (`active`),
  KEY `index_forms_on_subcategory_id` (`subcategory_id`),
  KEY `index_forms_on_permalink` (`permalink`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image_file_name` varchar(255) DEFAULT NULL,
  `image_content_type` varchar(255) DEFAULT NULL,
  `image_file_size` int(11) DEFAULT NULL,
  `primary` tinyint(1) DEFAULT '0',
  `imageable_id` int(11) DEFAULT NULL,
  `imageable_type` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_images_on_imageable_id` (`imageable_id`),
  KEY `index_images_on_imageable_type` (`imageable_type`),
  KEY `index_images_on_imageable_id_and_imageable_type` (`imageable_id`,`imageable_type`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=latin1;

CREATE TABLE `links` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `description` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `pieces` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `price` float DEFAULT '0',
  `for_sale` tinyint(1) DEFAULT '0',
  `active` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `permalink` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `sold` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_pieces_on_active` (`active`),
  KEY `index_pieces_on_type` (`type`),
  KEY `index_pieces_on_permalink` (`permalink`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

CREATE TABLE `posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `body` text,
  `permalink` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_posts_on_type` (`type`),
  KEY `index_posts_on_permalink` (`permalink`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `subcategories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `permalink` varchar(255) DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  `category_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_subcategories_on_permalink` (`permalink`),
  KEY `index_subcategories_on_active` (`active`),
  KEY `index_subcategories_on_category_id` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_users_on_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

INSERT INTO schema_migrations (version) VALUES ('20091010144135');

INSERT INTO schema_migrations (version) VALUES ('20091010144449');

INSERT INTO schema_migrations (version) VALUES ('20091010151552');

INSERT INTO schema_migrations (version) VALUES ('20091010153211');

INSERT INTO schema_migrations (version) VALUES ('20091011130107');

INSERT INTO schema_migrations (version) VALUES ('20091011132439');

INSERT INTO schema_migrations (version) VALUES ('20091011141532');

INSERT INTO schema_migrations (version) VALUES ('20091011143534');

INSERT INTO schema_migrations (version) VALUES ('20091011143634');

INSERT INTO schema_migrations (version) VALUES ('20091012041617');

INSERT INTO schema_migrations (version) VALUES ('20091013024157');

INSERT INTO schema_migrations (version) VALUES ('20091013024844');

INSERT INTO schema_migrations (version) VALUES ('20091015011043');

INSERT INTO schema_migrations (version) VALUES ('20091015021549');

INSERT INTO schema_migrations (version) VALUES ('20091017045553');

INSERT INTO schema_migrations (version) VALUES ('20091017142712');

INSERT INTO schema_migrations (version) VALUES ('20091031011131');

INSERT INTO schema_migrations (version) VALUES ('20091031133037');

INSERT INTO schema_migrations (version) VALUES ('20091108215211');

INSERT INTO schema_migrations (version) VALUES ('20100109171121');

INSERT INTO schema_migrations (version) VALUES ('20100206053317');

INSERT INTO schema_migrations (version) VALUES ('20100213052024');

INSERT INTO schema_migrations (version) VALUES ('20100213061139');

INSERT INTO schema_migrations (version) VALUES ('20100213140759');

INSERT INTO schema_migrations (version) VALUES ('20100213142139');

INSERT INTO schema_migrations (version) VALUES ('20100309064736');

INSERT INTO schema_migrations (version) VALUES ('20121109000539');
LOCK TABLES `Role` WRITE;
/*!40000 ALTER TABLE `Role` DISABLE KEYS */;

INSERT INTO `Role` (`id`, `name`, `isActive`)
VALUES
	(1,'Team Lead',b'1'),
	(2,'Manager',b'1'),
	(3,'Employee',b'1');

/*!40000 ALTER TABLE `Role` ENABLE KEYS */;
UNLOCK TABLES;
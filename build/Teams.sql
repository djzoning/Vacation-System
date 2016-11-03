LOCK TABLES `Team` WRITE;
/*!40000 ALTER TABLE `Team` DISABLE KEYS */;

INSERT INTO `Team` (`id`, `name`, `maxVacationers`, `isActive`, `leadId`)
VALUES
	(1,'IT Support',2,b'1',NULL),
	(2,'Marketing',2,b'1',NULL),
	(3,'Sales',2,b'1',NULL),
	(4,'CPUSA Sofia',1,b'1',NULL),
	(5,'Customer Service',2,b'1',NULL),
	(6,'Managers',1,b'1',NULL);

/*!40000 ALTER TABLE `Team` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `VacationType` WRITE;
/*!40000 ALTER TABLE `VacationType` DISABLE KEYS */;

INSERT INTO `VacationType` (`id`, `name`, `daysLimit`, `isActive`)
VALUES
	(1,'Paid',20,b'1'),
	(2,'Unpaid',30,b'1'),
	(3,'Sick Leave',NULL,b'1'),
	(4,'Special Days',NULL,b'1');

/*!40000 ALTER TABLE `VacationType` ENABLE KEYS */;
UNLOCK TABLES;

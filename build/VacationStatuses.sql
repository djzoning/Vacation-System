LOCK TABLES `VacationStatus` WRITE;
/*!40000 ALTER TABLE `VacationStatus` DISABLE KEYS */;

INSERT INTO `VacationStatus` (`id`, `name`, `category`, `isActive`)
VALUES
	(1, 'Pending', 'Pending', 1),
	(2, 'Awaiting Approval', 'Pending', 1),
	(3, 'Fill-in Approved', 'Pending', 1),
	(4, 'Fill-in Rejected', 'Rejected', 1),
	(5, 'Team Lead Approved', 'Approved', 1),
	(6, 'Team Lead Rejected', 'Rejected', 1),
	(7, 'Manager Rejected', 'Rejected', 1),
	(8, 'Manager Approved', 'Approved', 1);

/*!40000 ALTER TABLE `VacationStatus` ENABLE KEYS */;
UNLOCK TABLES;

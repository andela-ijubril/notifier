# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.15)
# Database: bloomz_test
# Generation Time: 2016-11-04 18:31:22 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table acknowledgement
# ------------------------------------------------------------

CREATE TABLE `acknowledgement` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `queue_id` int(11) DEFAULT NULL,
  `message_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table message
# ------------------------------------------------------------

CREATE TABLE `message` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `details` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `queue_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table queue
# ------------------------------------------------------------

CREATE TABLE `queue` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `no_of_msg_sent` int(11) DEFAULT NULL,
  `id_of_last_msg` int(11) DEFAULT NULL,
  `id_of_last_msg_acknowledged` int(11) DEFAULT NULL,
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table status
# ------------------------------------------------------------

CREATE TABLE `status` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `value` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;

INSERT INTO `user` (`id`, `name`, `username`, `password`)
VALUES
	(1,'Arden','Gutierrez','CDU02VFJ9PD'),
	(2,'Adena','Hogan','BBY40PJQ8LJ'),
	(3,'Dakota','Salazar','AIE51HLI6OL'),
	(4,'Murphy','Everett','IIY48PSU9FA'),
	(5,'Grace','Torres','QEL03EGS9YQ'),
	(6,'Clinton','Huffman','UJP06TQX6YP'),
	(7,'Mara','Stevens','YPV99BNY3SY'),
	(8,'Laurel','Berry','DVF72ACW9MO'),
	(9,'Walker','Browning','JMX33KQT4KG'),
	(10,'Zelda','Kelley','VUY52RQX2HN'),
	(11,'Zeph','Roberson','CCO95ADP8LU'),
	(12,'Tanner','Richmond','FYC59PKQ6NC'),
	(13,'Hermione','Gutierrez','DOC41SCZ7WD'),
	(14,'Tarik','Forbes','FDD48KXY9CH'),
	(15,'Noelle','Myers','CUN36XAN8KQ'),
	(16,'Veda','Hall','TRQ40IUP1ZW'),
	(17,'Karen','Brady','RGD13JIZ4VG'),
	(18,'Lyle','Head','LSR92HEZ5BA'),
	(19,'Noah','Rodriquez','VDP21PZI8SG'),
	(20,'Lydia','Copeland','NYR21PBU4VG'),
	(21,'Petra','Andrews','ZOI25RTM4EY'),
	(22,'Kim','Frederick','SRW38VBM4HD'),
	(23,'Sloane','Acevedo','WRQ84YSS8GM'),
	(24,'Mona','Carroll','HFG67ZAO4BY'),
	(25,'Derek','Campos','DWD85GIB0AW'),
	(26,'Hakeem','Wiley','PUM20IJC2EX'),
	(27,'Audrey','Fleming','UPN89WBP4WP'),
	(28,'Geoffrey','Zamora','HGJ64ABL1AQ'),
	(29,'Daniel','Cole','VUH67AUP3EV'),
	(30,'Irma','Tyson','ASW84ZNV7OR'),
	(31,'Wade','Galloway','AIB51SRU0BP'),
	(32,'Odessa','Mayer','NNL77QNF2CA'),
	(33,'Lysandra','Mckay','CAB21UYW8NN'),
	(34,'Nash','Pennington','WWO47UIB1IS'),
	(35,'Hayfa','May','KEE32VYK1DW'),
	(36,'Basia','Duke','XYE82SIG7VS'),
	(37,'Gareth','Terry','MRF08TYD7VJ'),
	(38,'Paki','Kelly','IOX53MHD5ZR'),
	(39,'Alea','Barnett','MAW49RZZ9YJ'),
	(40,'Kiayada','Bray','QDM80PJT2MC'),
	(41,'Myra','Murray','XJR80JSL4WU'),
	(42,'Madison','Saunders','ACF66ISW6QJ'),
	(43,'Chester','Albert','GFI56IOY1UI'),
	(44,'Jessamine','Beach','YFF93PWQ5TA'),
	(45,'Wallace','Briggs','PYS37BAX1YA'),
	(46,'Hollee','Foster','GZH26VOW3ZY'),
	(47,'Kay','Noel','KLC40BZS9HH'),
	(48,'Eleanor','Young','GCT83VSH0EF'),
	(49,'Irma','Landry','WHW55VGG9DG'),
	(50,'Callum','Holloway','WAY80GAC9OV'),
	(51,'Reece','Kane','EMB16MYK9YZ'),
	(52,'Patrick','Marquez','RAC57IKJ9ZM'),
	(53,'Randall','Robles','NTT11LSR6XA'),
	(54,'Calista','Ferguson','DON64FAZ3MZ'),
	(55,'Ivy','Dean','PKB12DXW3OJ'),
	(56,'Gage','Deleon','MNA55TLE5KL'),
	(57,'Katell','Rutledge','KAO54EYY4LH'),
	(58,'Nigel','Gibson','SJT44GBJ5WB'),
	(59,'Evelyn','Frederick','LNA08QVO7GA'),
	(60,'Lucas','Holcomb','BBG12GIC2VU'),
	(61,'April','Shaffer','VQJ52LGE1OP'),
	(62,'Athena','Sanchez','SCN17IZU7XB'),
	(63,'Hanae','Albert','MYX76NEQ9ND'),
	(64,'Lisandra','Hinton','VVU18SBH1FF'),
	(65,'Maryam','Grant','ZYG58RBO9LW'),
	(66,'Dominic','Johnson','UER68UIF3KR'),
	(67,'Blythe','Gonzales','YNV07OCV9XR'),
	(68,'Isadora','Gamble','JMN81QZK2AE'),
	(69,'Evan','Woods','EMY67VIP9LC'),
	(70,'Alexandra','Joyce','GKV19AEF7JB'),
	(71,'Harriet','Giles','RGF37EHR5EZ'),
	(72,'Carlos','Gross','VZG82BZK0JP'),
	(73,'Merrill','Moreno','EIN01RCJ2XY'),
	(74,'Meghan','Contreras','IKO95YVV9VL'),
	(75,'Scarlet','Sosa','JYY58LZY8FK'),
	(76,'Hilel','Ortiz','JGR59VNZ3PH'),
	(77,'Elaine','Levine','LKV39FQF5UY'),
	(78,'Donna','Cooper','GWE37MYU6AB'),
	(79,'Tate','Espinoza','IVK30FWV9LP'),
	(80,'Benedict','Watkins','BUO71ZIK9MY'),
	(81,'Hillary','Christensen','KJZ95HWS0OE'),
	(82,'Leah','Fuentes','QHG86UAD5WI'),
	(83,'Zeus','Tyson','BGM79VCQ6CS'),
	(84,'Jemima','Orr','UID86FNM5GK'),
	(85,'Jemima','Myers','YTN35AEZ3AW'),
	(86,'Calvin','Flowers','KAA55KXP2JR'),
	(87,'Rana','Copeland','DXU83COY9HK'),
	(88,'Yuri','Sanchez','DLX91TZQ5MM'),
	(89,'Dieter','Dickson','VFN12UHX6ED'),
	(90,'Teagan','Bradley','HGH63URK2ZS'),
	(91,'Emily','Dejesus','DWR98TPK9KW'),
	(92,'Tanner','Stark','SMB76SLA9GV'),
	(93,'Azalia','Jordan','ZES11LQV1SV'),
	(94,'Brian','Vaughan','HSY06XMI5TI'),
	(95,'Amos','Delgado','JDB54AWN9MK'),
	(96,'Blake','Casey','TVE38JVY5RT'),
	(97,'Delilah','Fulton','JUQ65HNG8TT'),
	(98,'Madonna','Cross','WLU28PHO9DH'),
	(99,'Minerva','Cross','SKD10GEA6KY'),
	(100,'Alfreda','Chase','XTF06WLM2FP'),
	(101,'jubril','jubril001','testedingpassword');

/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

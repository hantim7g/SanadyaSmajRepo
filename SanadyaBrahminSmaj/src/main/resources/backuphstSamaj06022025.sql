/*
SQLyog Community v13.3.1 (64 bit)
MySQL - 8.0.44 : Database - hst_samaj
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`hst_samaj` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `hst_samaj`;

/*Table structure for table `annual_calendar` */

DROP TABLE IF EXISTS `annual_calendar`;

CREATE TABLE `annual_calendar` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `active` bit(1) NOT NULL,
  `description` text NOT NULL,
  `event_date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `annual_calendar` */

insert  into `annual_calendar`(`id`,`active`,`description`,`event_date`) values 
(1,'','नववर्ष प्रारंभ — समाज के लिए शुभकामनाएँ, सेवा व सद्भाव का संकल्प।','2026-01-01'),
(2,'','गणतंत्र दिवस — राष्ट्रीय ध्वज वंदन एवं देशभक्ति कार्यक्रम।','2026-01-26'),
(3,'','बसंतोत्सव — सामाजिक मिलन, सांस्कृतिक कार्यक्रम एवं गीत-संगीत।','2026-02-05'),
(4,'','वार्षिक सदस्यता नवीनीकरण अभियान प्रारंभ।','2026-02-20'),
(5,'','महिला सशक्तिकरण संगोष्ठी — समाज में नारी सम्मान पर विचार।','2026-03-10'),
(6,'','समाज सेवा दिवस — स्वच्छता, वृक्षारोपण एवं सेवा कार्य।','2026-03-25'),
(7,'','नव संवत्सर एवं समाजिक नववर्ष समारोह।','2026-04-14'),
(8,'','युवा प्रेरणा शिविर — शिक्षा, संस्कार एवं करियर मार्गदर्शन।','2026-04-30'),
(9,'','वार्षिक साधारण सभा — कार्यवृत्त, आय-व्यय एवं भविष्य योजना।','2026-05-15'),
(10,'','विश्व पर्यावरण दिवस — वृक्षारोपण एवं पर्यावरण जागरूकता।','2026-06-05'),
(11,'','शिक्षा सहायता योजना प्रारंभ — जरूरतमंद विद्यार्थियों हेतु।','2026-06-20'),
(12,'','गुरु सम्मान समारोह — शिक्षकों एवं गुरुओं का सम्मान।','2026-07-12'),
(13,'','स्वतंत्रता दिवस — ध्वजारोहण एवं देशभक्ति सांस्कृतिक कार्यक्रम।','2026-08-15'),
(14,'','सामूहिक रक्षाबंधन एवं पारिवारिक मिलन समारोह।','2026-08-22'),
(15,'','स्वास्थ्य जागरूकता शिविर — निःशुल्क चिकित्सा परामर्श।','2026-09-10'),
(16,'','गांधी जयंती — स्वच्छता अभियान एवं सत्य-अहिंसा संदेश।','2026-10-02'),
(17,'','शरदोत्सव / विजयादशमी मिलन समारोह।','2026-10-18'),
(18,'','दीपावली स्नेह मिलन — समाज बंधुओं का सामूहिक मिलन।','2026-11-12'),
(19,'','वार्षिक प्रतिभा सम्मान — मेधावी छात्र-छात्राओं का सम्मान।','2026-12-10'),
(20,'','वर्षांत समीक्षा एवं आगामी वर्ष की कार्ययोजना।','2026-12-31');

/*Table structure for table `audit_log` */

DROP TABLE IF EXISTS `audit_log`;

CREATE TABLE `audit_log` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `action` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `details` varchar(2000) DEFAULT NULL,
  `entity_id` bigint DEFAULT NULL,
  `entity_name` varchar(255) DEFAULT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `audit_log` */

/*Table structure for table `audit_logs_rooms` */

DROP TABLE IF EXISTS `audit_logs_rooms`;

CREATE TABLE `audit_logs_rooms` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `action` varchar(255) DEFAULT NULL,
  `action_time` datetime(6) DEFAULT NULL,
  `entity` varchar(255) DEFAULT NULL,
  `entity_id` bigint DEFAULT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `audit_logs_rooms` */

/*Table structure for table `booking_guests` */

DROP TABLE IF EXISTS `booking_guests`;

CREATE TABLE `booking_guests` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `age` int DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `id_proof_number` varchar(255) DEFAULT NULL,
  `id_proof_type` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `booking_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKeuo33uocyjahxhr3gc0fut203` (`booking_id`),
  CONSTRAINT `FKeuo33uocyjahxhr3gc0fut203` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `booking_guests` */

/*Table structure for table `bookings` */

DROP TABLE IF EXISTS `bookings`;

CREATE TABLE `bookings` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `actual_check_in` datetime(6) DEFAULT NULL,
  `actual_check_out` datetime(6) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `adults` int DEFAULT NULL,
  `balance_amount` decimal(38,2) DEFAULT NULL,
  `booking_code` varchar(255) DEFAULT NULL,
  `booking_source` varchar(255) DEFAULT NULL,
  `check_in_date` date NOT NULL,
  `check_out_date` date NOT NULL,
  `children` int DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `discount_amount` decimal(38,2) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `emergency_contact_name` varchar(255) DEFAULT NULL,
  `emergency_contact_phone` varchar(255) DEFAULT NULL,
  `guest_name` varchar(255) DEFAULT NULL,
  `id_proof_file_url` varchar(255) DEFAULT NULL,
  `id_proof_number` varchar(255) DEFAULT NULL,
  `id_proof_type` varchar(255) DEFAULT NULL,
  `is_walk_in` bit(1) DEFAULT NULL,
  `login_user_mobile` varchar(255) DEFAULT NULL,
  `nationality` varchar(255) DEFAULT NULL,
  `paid_amount` decimal(38,2) DEFAULT NULL,
  `pay_at_hotel` bit(1) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `pin_code` varchar(255) DEFAULT NULL,
  `remarks` varchar(500) DEFAULT NULL,
  `room_price` decimal(38,2) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `tax_amount` decimal(38,2) DEFAULT NULL,
  `total_amount` decimal(38,2) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `room_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKrgoycol97o21kpjodw1qox4nc` (`room_id`),
  CONSTRAINT `FKrgoycol97o21kpjodw1qox4nc` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `bookings` */

insert  into `bookings`(`id`,`actual_check_in`,`actual_check_out`,`address`,`adults`,`balance_amount`,`booking_code`,`booking_source`,`check_in_date`,`check_out_date`,`children`,`city`,`created_at`,`discount_amount`,`email`,`emergency_contact_name`,`emergency_contact_phone`,`guest_name`,`id_proof_file_url`,`id_proof_number`,`id_proof_type`,`is_walk_in`,`login_user_mobile`,`nationality`,`paid_amount`,`pay_at_hotel`,`phone`,`pin_code`,`remarks`,`room_price`,`state`,`status`,`tax_amount`,`total_amount`,`updated_at`,`room_id`) values 
(1,'2026-02-04 06:00:32.036293','2026-02-04 06:00:33.805816','2-K-5',NULL,500.00,'SSB-2026-0001','WEBSITE','2026-02-02','2026-02-03',NULL,'KOTA','2026-02-02 20:50:57.386750',0.00,'hstmycell@gmail.com','himanshu sharma','8089101719','Harish Sharma','1770045657324_WhatsApp Image 2025-11-07 at 22.25.26.jpeg','293926382492','AADHAR','\0','8089101719','भारतीय',0.00,'','8089101719','324005','Nothing',500.00,'Rajasthan','COMPLETED',0.00,500.00,'2026-02-04 06:00:33.817483',1),
(2,'2026-02-04 06:00:35.902431','2026-02-04 06:00:36.837180','2-K-5',NULL,50000.00,'SSB-2026-0002','WEBSITE','2026-02-03','2026-02-04',NULL,'KOTA','2026-02-02 20:52:18.489539',0.00,'hstmycell@gmail.com','himanshu sharma','8089101719','Harish Sharma','1770045738463_WhatsApp Image 2025-11-07 at 22.25.26.jpeg','293926382492','AADHAR','\0','8089101719','भारतीय',0.00,'','8089101719','324005','NA',50000.00,'Rajasthan','COMPLETED',0.00,50000.00,'2026-02-04 06:00:36.841610',9),
(3,NULL,NULL,'2-K-5',NULL,500.00,'SSB-2026-0003','WEBSITE','2026-02-04','2026-02-05',NULL,'KOTA','2026-02-04 06:01:44.639606',0.00,'hstmycell@gmail.com','himanshu sharma','08089101719','Harish Sharma','1770165104589_WhatsApp Image 2025-11-07 at 22.25.26.jpeg','293926382492','AADHAR','\0','8089101719','भारतीय',0.00,'','08089101719','324005','test',500.00,'Rajasthan','CONFIRMED',0.00,500.00,'2026-02-04 06:01:44.639606',2);

/*Table structure for table `coupons` */

DROP TABLE IF EXISTS `coupons`;

CREATE TABLE `coupons` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `active` bit(1) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `discount_value` decimal(38,2) DEFAULT NULL,
  `percentage` bit(1) DEFAULT NULL,
  `valid_from` date DEFAULT NULL,
  `valid_to` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `coupons` */

/*Table structure for table `event` */

DROP TABLE IF EXISTS `event`;

CREATE TABLE `event` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `author` varchar(255) DEFAULT NULL,
  `content` text,
  `event_date` date DEFAULT NULL,
  `event_status` bit(1) NOT NULL,
  `event_url` varchar(255) DEFAULT NULL,
  `is_corosal` bit(1) NOT NULL,
  `main_image_url` varchar(255) DEFAULT NULL,
  `publish_date` date DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `event` */

insert  into `event`(`id`,`author`,`content`,`event_date`,`event_status`,`event_url`,`is_corosal`,`main_image_url`,`publish_date`,`title`) values 
(1,'अध्यक्ष','सनाढ्य ब्राह्मण समाज की यह आधिकारिक वेबसाइट समाज को एक डिजिटल मंच पर जोड़ने का एक महत्वपूर्ण प्रयास है।इस वेबसाइट के माध्यम से समाज के सदस्यों को आपसी संपर्क, जानकारी साझा करने, सामाजिक गतिविधियों, नियमावली, सदस्य निर्देशिका और समाज से जुड़ी महत्वपूर्ण सूचनाओं तक सरल एवं पारदर्शी पहुँच प्राप्त होगी।यह मंच हमारी संस्कृति, परंपरा और मूल्यों को सहेजते हुए, नई पीढ़ी को समाज से जोड़ने का कार्य करेगा।हमारा उद्देश्य समाज में एकता, सहयोग और जागरूकता को बढ़ावा देना तथा तकनीक के माध्यम से समाज को सशक्त बनाना है।यह वेबसाइट न केवल सूचना का माध्यम है, बल्कि सनाढ्य ब्राह्मण समाज की पहचान, गौरव और भविष्य का प्रतिबिंब भी है।','2026-02-08','','url','','/images/events/7bed7ca9-9beb-4600-b3f8-8886d1447ba7_corsal1.jpg','2026-02-01','सनाढ्य ब्राह्मण समाज की आधिकारिक वेबसाइट का शुभारंभ'),
(2,'अध्यक्ष','26 जनवरी गणतंत्र दिवस के अवसर पर सनाढ्य ब्राह्मण महिला मंडल, कोटा द्वारा समाज भवन में ध्वजारोहण एवं सांस्कृतिक कार्यक्रम का आयोजन किया गया। कार्यक्रम में समाज की महिलाओं, पुरुषों एवं बच्चों की सहभागिता रही। देशभक्ति गीत, सांस्कृतिक प्रस्तुतियाँ एवं संविधान के मूल्यों पर विचार साझा किए गए। आयोजन का उद्देश्य समाज में राष्ट्रीय चेतना, एकता एवं संस्कारों को प्रोत्साहित करना रहा।','2026-01-26','','url','','/images/events/b6d74baa-6865-45ac-9c27-3d5d2f651fa4_corsal2.jpg','2026-02-26','गणतंत्र दिवस '),
(3,'अध्यक्ष','सनाढ्य ब्राह्मण महासभा द्वारा आयोजित यह वैवाहिक सम्मेलन समाज के सभी परिवारों एवं योग्य अविवाहित युवक–युवतियों के लिए एक सुव्यवस्थित एवं विश्वसनीय मंच प्रदान करता है। इस सम्मेलन का मुख्य उद्देश्य समाज में वैवाहिक सेवा को सुदृढ़ करना तथा पारिवारिक समन्वय को बढ़ावा देना है।\r\n\r\nसम्मेलन के अंतर्गत इच्छुक परिवारों को महासभा की आधिकारिक वेबसाइट पर पंजीकरण कर युवक–युवतियों की प्रोफाइल जोड़ने एवं उपलब्ध प्रोफाइल ब्राउज़ करने (Browse Profiles) की सुविधा प्रदान की जाएगी, जिससे परिवार अपनी आवश्यकता एवं पसंद के अनुसार संपर्क स्थापित कर सकें।\r\n\r\nकार्यक्रम के प्रमुख बिंदु:\r\n\r\nयोग्य युवक–युवतियों की वैवाहिक प्रोफाइल जानकारी\r\n\r\nसमाज-स्तरीय वैवाहिक सेवा परामर्श\r\n\r\nपारंपरिक एवं सांस्कृतिक गतिविधियाँ\r\n\r\nसमाज के वरिष्ठजनों का मार्गदर्शन\r\n\r\nयह वैवाहिक सम्मेलन समाज में संस्कारयुक्त विवाह व्यवस्था, आपसी विश्वास एवं सामाजिक एकता को सशक्त बनाने की दिशा में एक महत्वपूर्ण पहल है।','2026-03-10','','url','','/images/events/2f1c3a9c-3157-48fe-8438-df3667d7b8ff_Screenshot 2026-02-01 223918.png','2026-02-01','सनाढ्य ब्राह्मण महासभा द्वारा आयोजित वैवाहिक सम्मेलन');

/*Table structure for table `event_image` */

DROP TABLE IF EXISTS `event_image`;

CREATE TABLE `event_image` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `alt_text` varchar(255) DEFAULT NULL,
  `caption` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `event_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK9oirj7cwmu7k91vr0m13hqh8b` (`event_id`),
  CONSTRAINT `FK9oirj7cwmu7k91vr0m13hqh8b` FOREIGN KEY (`event_id`) REFERENCES `event` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `event_image` */

/*Table structure for table `festivals` */

DROP TABLE IF EXISTS `festivals`;

CREATE TABLE `festivals` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `active` bit(1) NOT NULL,
  `description` text,
  `festival_date` date NOT NULL,
  `festival_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `festivals` */

insert  into `festivals`(`id`,`active`,`description`,`festival_date`,`festival_name`) values 
(1,'','पौष मास शुक्ल पूर्णिमा — स्नान, दान व धर्मकर्म का विशेष महत्व','2026-02-03','पौष पूर्णिमा'),
(2,'','पौष शुक्ल पक्ष — सूर्य का मकर राशि में प्रवेश, उत्तरायण आरंभ।','2026-01-14','मकर संक्रांति'),
(3,'','माघ शुक्ल पंचमी — माँ सरस्वती की पूजा, विद्या व ज्ञान का पर्व।','2026-01-23','वसंत पंचमी'),
(4,'','फाल्गुन कृष्ण चतुर्दशी — भगवान शिव की महान आराधना रात्रि।','2026-02-15','महाशिवरात्रि'),
(5,'','फाल्गुन शुक्ल पूर्णिमा — बुराई पर अच्छाई की विजय का प्रतीक।','2026-03-03','होलिका दहन'),
(6,'','फाल्गुन कृष्ण प्रतिपदा — रंगों, प्रेम व सौहार्द का पर्व।','2026-03-04','धुलंडी (होली)'),
(7,'','चैत्र कृष्ण प्रतिपदा — होली के अगले दिन से गणगौर व्रत आरंभ (राजस्थान विशेष)।','2026-03-05','गणगौर प्रारंभ'),
(8,'','चैत्र कृष्ण सप्तमी — माता शीतला की पूजा, राजस्थान में विशेष महत्व।','2026-03-11','शीतला सप्तमी'),
(9,'','चैत्र शुक्ल प्रतिपदा — माँ दुर्गा के नौ स्वरूपों की उपासना आरंभ।','2026-03-19','चैत्र नवरात्रि प्रारंभ'),
(10,'','चैत्र शुक्ल तृतीया — गणगौर का मुख्य पूजन दिवस (राजस्थान का प्रमुख पर्व)।','2026-03-21','गणगौर पूजन'),
(11,'','चैत्र शुक्ल नवमी — भगवान श्रीराम का जन्मोत्सव।','2026-03-27','राम नवमी'),
(12,'','चैत्र शुक्ल पूर्णिमा — भगवान हनुमान का जन्मोत्सव।','2026-04-02','हनुमान जयंती'),
(13,'','वैशाख शुक्ल तृतीया — अत्यंत शुभ एवं अक्षय फल देने वाला दिन।','2026-04-20','अक्षय तृतीया'),
(14,'','वैशाख शुक्ल पूर्णिमा — भगवान बुद्ध की जयंती।','2026-05-01','बुद्ध पूर्णिमा'),
(15,'','आषाढ़ शुक्ल द्वितीया — भगवान जगन्नाथ की भव्य रथ यात्रा।','2026-07-16','जगन्नाथ रथ यात्रा'),
(16,'','आषाढ़ शुक्ल पूर्णिमा — गुरुजनों के प्रति श्रद्धा व सम्मान।','2026-07-29','गुरु पूर्णिमा'),
(17,'','श्रावण शुक्ल तृतीया — शिव-पार्वती पुनर्मिलन, राजस्थान में विशेष पर्व।','2026-08-10','हरियाली तीज'),
(18,'','भाद्रपद कृष्ण तृतीया — कजली तीज, राजस्थान के कई क्षेत्रों में प्रचलित।','2026-08-25','कजली तीज'),
(19,'','श्रावण शुक्ल पूर्णिमा — भाई-बहन के प्रेम का पावन पर्व।','2026-08-28','रक्षाबंधन'),
(20,'','भाद्रपद कृष्ण अष्टमी — भगवान श्रीकृष्ण का जन्मोत्सव।','2026-09-04','श्रीकृष्ण जन्माष्टमी'),
(21,'','भाद्रपद शुक्ल चतुर्थी — विघ्नहर्ता श्री गणेश का जन्मोत्सव।','2026-09-14','गणेश चतुर्थी'),
(22,'','आश्विन शुक्ल प्रतिपदा — माँ दुर्गा की विशेष उपासना।','2026-10-11','शारदीय नवरात्रि प्रारंभ'),
(23,'','आश्विन शुक्ल दशमी — असत्य पर सत्य की विजय का पर्व।','2026-10-20','विजयादशमी (दशहरा)'),
(24,'','कार्तिक कृष्ण चतुर्थी — सुहागिन स्त्रियों का पति की दीर्घायु हेतु व्रत।','2026-10-26','करवा चौथ'),
(25,'','कार्तिक कृष्ण त्रयोदशी — धन्वंतरि जयंती, आरोग्य व समृद्धि का पर्व।','2026-11-06','धनतेरस'),
(26,'','कार्तिक अमावस्या — माँ लक्ष्मी की पूजा, प्रकाश का महापर्व।','2026-11-08','दीपावली'),
(27,'','कार्तिक शुक्ल प्रतिपदा — श्रीकृष्ण द्वारा गोवर्धन पर्वत धारण की स्मृति।','2026-11-10','गोवर्धन पूजा'),
(28,'','कार्तिक शुक्ल द्वितीया — भाई-बहन के प्रेम का पर्व।','2026-11-11','भैया दूज'),
(29,'','कार्तिक शुक्ल षष्ठी — सूर्य देव की उपासना का महापर्व।','2026-11-15','छठ पूजा'),
(30,'','मार्गशीर्ष शुक्ल पूर्णिमा — दान-पुण्य व भगवान दत्तात्रेय जयंती।','2026-12-23','मार्गशीर्ष पूर्णिमा / दत्तात्रेय जयंती');

/*Table structure for table `gotra_master` */

DROP TABLE IF EXISTS `gotra_master`;

CREATE TABLE `gotra_master` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `active` bit(1) NOT NULL,
  `gotra_name` varchar(255) DEFAULT NULL,
  `samaj` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `gotra_master` */

insert  into `gotra_master`(`id`,`active`,`gotra_name`,`samaj`) values 
(1,'','भारद्वाज','Sanadhya Brahmin'),
(2,'','मुद्गल','Sanadhya Brahmin'),
(3,'','शाण्डिल्य','Sanadhya Brahmin'),
(4,'','अंगिरस','Sanadhya Brahmin'),
(5,'','अगस्त्य','Sanadhya Brahmin'),
(6,'','सांस्कृत्य','Sanadhya Brahmin'),
(7,'','कौशिक','Sanadhya Brahmin'),
(8,'','कश्यप','Sanadhya Brahmin'),
(9,'','वसिष्ठ','Sanadhya Brahmin'),
(10,'','कौशाल्य','Sanadhya Brahmin'),
(11,'','वालखिल्य','Sanadhya Brahmin'),
(12,'','चान्द्रायण','Sanadhya Brahmin'),
(13,'','वाशल','Sanadhya Brahmin'),
(14,'','गर्ग','Sanadhya Brahmin'),
(15,'','पूरण','Sanadhya Brahmin'),
(16,'','कृष्णाजिन','Sanadhya Brahmin'),
(17,'','शांकायन','Sanadhya Brahmin'),
(18,'','गौतम','Sanadhya Brahmin'),
(19,'','पराशर','Sanadhya Brahmin'),
(20,'','भृगु','Sanadhya Brahmin'),
(21,'','सम्पव','Sanadhya Brahmin'),
(22,'','कात्यायन','Sanadhya Brahmin'),
(23,'','अत्रि','Sanadhya Brahmin'),
(24,'','उपमन्यु','Sanadhya Brahmin'),
(25,'','कपि','Sanadhya Brahmin'),
(26,'','विष्णुवृद्ध','Sanadhya Brahmin'),
(27,'','कौण्डिन्य','Sanadhya Brahmin'),
(28,'','नितुन्द','Sanadhya Brahmin'),
(29,'','कृष्णात्रेय','Sanadhya Brahmin'),
(30,'','दालभ्य','Sanadhya Brahmin'),
(31,'','गांगेय','Sanadhya Brahmin'),
(32,'','शुनक','Sanadhya Brahmin'),
(33,'','वात्स्य','Sanadhya Brahmin'),
(34,'','जातुकर्ण्य','Sanadhya Brahmin'),
(35,'','आभरद्वसु','Sanadhya Brahmin'),
(36,'','सांख्यायन','Sanadhya Brahmin'),
(37,'','मारीच','Sanadhya Brahmin'),
(38,'','इन्द्रप्रमति','Sanadhya Brahmin'),
(39,'','आर्कायण','Sanadhya Brahmin'),
(40,'','मयेभू','Sanadhya Brahmin'),
(41,'','अष्टक','Sanadhya Brahmin'),
(42,'','गालब','Sanadhya Brahmin'),
(43,'','विद','Sanadhya Brahmin'),
(44,'','धूम्र','Sanadhya Brahmin'),
(45,'','हरिकर्णि','Sanadhya Brahmin'),
(46,'','कुषिक','Sanadhya Brahmin'),
(47,'','शारद्वन्त','Sanadhya Brahmin'),
(48,'','देवरात','Sanadhya Brahmin'),
(49,'','चन्द्रानिथि','Sanadhya Brahmin'),
(50,'','च्यवन','Sanadhya Brahmin'),
(51,'','आयास्य','Sanadhya Brahmin'),
(52,'','इन्दुवार','Sanadhya Brahmin'),
(53,'','मौद्गल्य','Sanadhya Brahmin'),
(54,'','कपिल','Sanadhya Brahmin'),
(55,'','उदवास','Sanadhya Brahmin'),
(56,'','मांडब्य','Sanadhya Brahmin'),
(57,'','वैन्य','Sanadhya Brahmin'),
(58,'','अघमर्षण','Sanadhya Brahmin'),
(59,'','कुत्स','Sanadhya Brahmin'),
(60,'','कालव','Sanadhya Brahmin'),
(61,'','दर्भ','Sanadhya Brahmin'),
(62,'','यस्क','Sanadhya Brahmin'),
(63,'','याज्ञवल्क्य','Sanadhya Brahmin'),
(64,'','वैहलि','Sanadhya Brahmin'),
(65,'','इन्द्र','Sanadhya Brahmin'),
(66,'','वामदेव','Sanadhya Brahmin'),
(67,'','मित्रयुव','Sanadhya Brahmin'),
(68,'','सौनकायन','Sanadhya Brahmin'),
(69,'','लोमन्य','Sanadhya Brahmin'),
(70,'','देवल','Sanadhya Brahmin'),
(71,'','भागी','Sanadhya Brahmin'),
(72,'','मैत्रेण्य','Sanadhya Brahmin'),
(73,'','पुलस्त','Sanadhya Brahmin'),
(74,'','गौरस','Sanadhya Brahmin'),
(75,'','भद्रशील','Sanadhya Brahmin'),
(76,'','अप्तवान','Sanadhya Brahmin'),
(77,'','सप्तसार','Sanadhya Brahmin'),
(78,'','माधुच्छंदस','Sanadhya Brahmin'),
(79,'','लोहित','Sanadhya Brahmin'),
(80,'','जमदाग्नि','Sanadhya Brahmin'),
(81,'','वाल्मीकि','Sanadhya Brahmin'),
(82,'','अम्बसार','Sanadhya Brahmin'),
(83,'','नेध्रुव','Sanadhya Brahmin'),
(84,'','और्व','Sanadhya Brahmin'),
(85,'','गोभिल','Sanadhya Brahmin'),
(86,'','संस्कृति','Sanadhya Brahmin'),
(87,'','बोधायन','Sanadhya Brahmin'),
(88,'','सत्यकि','Sanadhya Brahmin'),
(89,'','मौन','Sanadhya Brahmin'),
(90,'','सावर्णि','Sanadhya Brahmin'),
(91,'','मित्रावरुणा','Sanadhya Brahmin'),
(92,'','बोधायन','Sanadhya Brahmin'),
(93,'','मित्रायु','Sanadhya Brahmin'),
(94,'','जावालि','Sanadhya Brahmin'),
(95,'','विश्वामित्र','Sanadhya Brahmin'),
(96,'','संकृति','Sanadhya Brahmin'),
(97,'','शंडिल','Sanadhya Brahmin'),
(98,'','कण्व','Sanadhya Brahmin'),
(99,'','धूम्र','Sanadhya Brahmin'),
(100,'','लोहिताक्ष','Sanadhya Brahmin'),
(101,'','कौन्स','Sanadhya Brahmin'),
(102,'','धनञ्जय','Sanadhya Brahmin'),
(103,'','आमिराइन','Sanadhya Brahmin'),
(104,'','वाभ्रव्य','Sanadhya Brahmin'),
(105,'','नितुन्दिल','Sanadhya Brahmin'),
(106,'','धौम्य','Sanadhya Brahmin'),
(107,'','धूम','Sanadhya Brahmin'),
(108,'','किलालि','Sanadhya Brahmin'),
(109,'','माव्य','Sanadhya Brahmin'),
(110,'','शारद्वन्त','Sanadhya Brahmin'),
(111,'','ब्रभ्राव्य','Sanadhya Brahmin'),
(112,'','नैध्रुव','Sanadhya Brahmin'),
(113,'','वीतहव्य','Sanadhya Brahmin'),
(114,'','इन्द्रप्रमद','Sanadhya Brahmin'),
(115,'','चान्द्रोदय','Sanadhya Brahmin'),
(116,'','पुलस्ति','Sanadhya Brahmin'),
(117,'','भागुरिस्यायन','Sanadhya Brahmin'),
(118,'','घृतकोशिक','Sanadhya Brahmin'),
(119,'','उदवेणु','Sanadhya Brahmin'),
(120,'','सावरिया','Sanadhya Brahmin'),
(121,'','सावरि','Sanadhya Brahmin'),
(122,'','सावर्णि','Sanadhya Brahmin'),
(123,'','सावर्णि','Sanadhya Brahmin'),
(124,'','सावर्णि','Sanadhya Brahmin'),
(125,'','सावर्णि','Sanadhya Brahmin');

/*Table structure for table `guidance_mst` */

DROP TABLE IF EXISTS `guidance_mst`;

CREATE TABLE `guidance_mst` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `active` bit(1) DEFAULT NULL,
  `content` longtext NOT NULL,
  `created_date` datetime(6) DEFAULT NULL,
  `designation` varchar(255) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `person_name` varchar(255) NOT NULL,
  `priority` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `guidance_mst` */

insert  into `guidance_mst`(`id`,`active`,`content`,`created_date`,`designation`,`image_url`,`person_name`,`priority`) values 
(1,'','\r\n            समाज की वास्तविक शक्ति उसकी एकता, संस्कार और शिक्षा में निहित होती है।सनाढ्य ब्राह्मण समाज ने सदैव ज्ञान, सेवा और नैतिक मूल्यों को सर्वोपरि रखा है।आज के समय में आवश्यक है कि हम अपनी सांस्कृतिक विरासत को सहेजते हुए, युवाओं को सकारात्मक दिशा प्रदान करें।समाज का प्रत्येक सदस्य यदि अपने कर्तव्यों के प्रति सजग रहे, तो समाज निश्चित रूप से प्रगति के पथ पर अग्रसर होगा।        \r\n            ',NULL,'लोकसभा अध्यक्ष / समाज के प्रेरणास्रोत','/images/guidance/1769997709649_birlaJi.jpg','श्री ओम बिरला जी (कोटा)',1),
(2,'','समाज तभी सशक्त बनता है जब उसके सदस्य आपसी सहयोग, सम्मान और समर्पण की भावना से जुड़े हों।\r\nसनाढ्य ब्राह्मण समाज की पहचान उसकी परंपराओं, संस्कारों और सामाजिक उत्तरदायित्व से है।\r\nनई पीढ़ी को चाहिए कि वह शिक्षा, चरित्र और सेवा को अपने जीवन का आधार बनाए।\r\nसंगठित और जागरूक समाज ही भविष्य की चुनौतियों का सामना कर सकता है।\r\n            \r\n            \r\n            ',NULL,'समाजसेवी / जनप्रतिनिधि – मार्गदर्शन संदेश','/images/guidance/1769997846644_sandipJi.jpg','श्री संदीप शर्मा जी (कोटा)',2);

/*Table structure for table `housekeeping_tasks` */

DROP TABLE IF EXISTS `housekeeping_tasks`;

CREATE TABLE `housekeeping_tasks` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `assigned_at` datetime(6) DEFAULT NULL,
  `completed_at` datetime(6) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `staff_name` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `room_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKbuj2qtxq2odlqhj9qivxxvawn` (`room_id`),
  CONSTRAINT `FKbuj2qtxq2odlqhj9qivxxvawn` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `housekeeping_tasks` */

/*Table structure for table `member_rules` */

DROP TABLE IF EXISTS `member_rules`;

CREATE TABLE `member_rules` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `active` bit(1) DEFAULT NULL,
  `created_date` datetime(6) DEFAULT NULL,
  `rule_description` varchar(2000) DEFAULT NULL,
  `rule_title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `member_rules` */

insert  into `member_rules`(`id`,`active`,`created_date`,`rule_description`,`rule_title`) values 
(1,'',NULL,'सदस्य निर्देशिका में वही व्यक्ति सम्मिलित किए जाएँगे जो सनाढ्य ब्राह्मण समाज से संबंधित हों और जिनका निवास अथवा पारिवारिक संबंध कोटा क्षेत्र से हो।','समाज से संबंध'),
(2,'',NULL,'प्रत्येक सदस्य की प्रविष्टि समाज द्वारा निर्धारित प्रक्रिया के अनुसार सत्यापन एवं अनुमोदन के पश्चात ही निर्देशिका में प्रकाशित की जाएगी।','सदस्यता की पुष्टि'),
(3,'',NULL,'सदस्य द्वारा प्रदान की गई सभी जानकारी (नाम, पता, संपर्क विवरण आदि) सही, पूर्ण एवं सत्य होनी चाहिए। किसी भी प्रकार की गलत या भ्रामक जानकारी पाए जाने पर प्रविष्टि निरस्त की जा सकती है।','सटीक एवं सत्य जानकारी'),
(4,'',NULL,'यदि किसी सदस्य को अपनी जानकारी में संशोधन या अद्यतन कराना हो, तो वह समाज द्वारा निर्धारित माध्यम से लिखित/ऑनलाइन अनुरोध प्रस्तुत कर सकता है।','प्रविष्टि में संशोधन');

/*Table structure for table `messages` */

DROP TABLE IF EXISTS `messages`;

CREATE TABLE `messages` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `author_name` varchar(200) DEFAULT NULL,
  `author_subtitle` varchar(250) DEFAULT NULL,
  `author_title` varchar(200) DEFAULT NULL,
  `city_or_area` varchar(120) DEFAULT NULL,
  `content` tinytext,
  `content_format` varchar(20) NOT NULL,
  `content_html` tinytext,
  `created_at` datetime(6) NOT NULL,
  `date_text` varchar(120) DEFAULT NULL,
  `deleted` bit(1) NOT NULL,
  `footer_note` varchar(1000) DEFAULT NULL,
  `leads` varchar(1000) DEFAULT NULL,
  `page_number` varchar(20) DEFAULT NULL,
  `photo_url` varchar(500) DEFAULT NULL,
  `quote` varchar(1000) DEFAULT NULL,
  `signature_designation` varchar(200) DEFAULT NULL,
  `signature_name` varchar(200) DEFAULT NULL,
  `title` varchar(200) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `messages` */

/*Table structure for table `notifications` */

DROP TABLE IF EXISTS `notifications`;

CREATE TABLE `notifications` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `booking_id` bigint DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `sent` bit(1) DEFAULT NULL,
  `sent_at` datetime(6) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `notifications` */

/*Table structure for table `office_bearer` */

DROP TABLE IF EXISTS `office_bearer`;

CREATE TABLE `office_bearer` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `active` bit(1) DEFAULT NULL,
  `designation` varchar(255) DEFAULT NULL,
  `display_order` int DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `office_bearer` */

/*Table structure for table `password_reset_requests` */

DROP TABLE IF EXISTS `password_reset_requests`;

CREATE TABLE `password_reset_requests` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `admin_remarks` varchar(255) DEFAULT NULL,
  `decision_date` datetime(6) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `new_password` varchar(255) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `request_date` datetime(6) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `password_reset_requests` */

/*Table structure for table `payment_history` */

DROP TABLE IF EXISTS `payment_history`;

CREATE TABLE `payment_history` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `amount` double NOT NULL,
  `crt_by` bigint DEFAULT NULL,
  `crt_dt` date DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `fee_from` date DEFAULT NULL,
  `fee_to` date DEFAULT NULL,
  `lst_up_by` bigint DEFAULT NULL,
  `lst_up_dt` date DEFAULT NULL,
  `payment_date` date NOT NULL,
  `payment_mode` varchar(255) NOT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `receipt_image_path` varchar(255) DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `transaction_id` varchar(255) NOT NULL,
  `validated` varchar(255) DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_skg6f4ak2wlws28l2asb7iwo8` (`transaction_id`),
  KEY `FKdpjqqi1cejff8ipc1q314fuxd` (`user_id`),
  CONSTRAINT `FKdpjqqi1cejff8ipc1q314fuxd` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `payment_history` */

/*Table structure for table `payment_master` */

DROP TABLE IF EXISTS `payment_master`;

CREATE TABLE `payment_master` (
  `payment_id` bigint NOT NULL AUTO_INCREMENT,
  `amount` decimal(38,2) NOT NULL,
  `created_by` bigint DEFAULT NULL,
  `created_date` datetime(6) DEFAULT NULL,
  `currency` varchar(255) DEFAULT NULL,
  `gateway_order_id` varchar(255) DEFAULT NULL,
  `gateway_payment_id` varchar(255) DEFAULT NULL,
  `gateway_response` json DEFAULT NULL,
  `gateway_signature` varchar(255) DEFAULT NULL,
  `last_payment_update` datetime(6) DEFAULT NULL,
  `payment_created_date` datetime(6) DEFAULT NULL,
  `payment_done_date` datetime(6) DEFAULT NULL,
  `payment_status` varchar(255) DEFAULT NULL,
  `payment_vendor` varchar(255) DEFAULT NULL,
  `process_reference_id` bigint NOT NULL,
  `process_reference_no` varchar(255) DEFAULT NULL,
  `process_type` varchar(255) NOT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `updated_by` bigint DEFAULT NULL,
  `updated_date` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`payment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `payment_master` */

/*Table structure for table `payments_rooms` */

DROP TABLE IF EXISTS `payments_rooms`;

CREATE TABLE `payments_rooms` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `amount` decimal(38,2) DEFAULT NULL,
  `method` varchar(255) DEFAULT NULL,
  `payment_crt_date` datetime(6) DEFAULT NULL,
  `payment_date` datetime(6) DEFAULT NULL,
  `payment_lst_up_date` datetime(6) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `transaction_id` varchar(255) DEFAULT NULL,
  `booking_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKrsb9w6lluje2sarhrey5fvoam` (`booking_id`),
  CONSTRAINT `FKrsb9w6lluje2sarhrey5fvoam` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `payments_rooms` */

/*Table structure for table `registration_sequence` */

DROP TABLE IF EXISTS `registration_sequence`;

CREATE TABLE `registration_sequence` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `last_number` bigint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `registration_sequence` */

insert  into `registration_sequence`(`id`,`last_number`) values 
(1,1);

/*Table structure for table `room_blocks` */

DROP TABLE IF EXISTS `room_blocks`;

CREATE TABLE `room_blocks` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `from_date` date DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `room_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKqg0sumks8nk5eqt4imuwaj8cr` (`room_id`),
  CONSTRAINT `FKqg0sumks8nk5eqt4imuwaj8cr` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `room_blocks` */

insert  into `room_blocks`(`id`,`from_date`,`reason`,`to_date`,`room_id`) values 
(9,'2026-02-05','MAINTENANCE','2026-02-06',2);

/*Table structure for table `room_images` */

DROP TABLE IF EXISTS `room_images`;

CREATE TABLE `room_images` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `image_url` varchar(255) DEFAULT NULL,
  `room_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKtky1jnwoh1hv50m263p2vlt0y` (`room_id`),
  CONSTRAINT `FKtky1jnwoh1hv50m263p2vlt0y` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `room_images` */

insert  into `room_images`(`id`,`image_url`,`room_id`) values 
(1,'rooms/bcf3426d-8970-4009-bc41-1056316e13bd_room.jpg',1),
(2,'rooms/bee83d98-548f-4a50-a70c-348ac89f56db_room.jpg',2),
(3,'rooms/bcf3426d-8970-4009-bc41-1056316e13bd_room.jpg',3),
(4,'rooms/bee83d98-548f-4a50-a70c-348ac89f56db_room.jpg',4),
(9,'rooms/3158e2b0-1b95-40c2-b6ea-8468acf026d6_hall.png',5),
(10,'rooms/3158e2b0-1b95-40c2-b6ea-8468acf026d6_hall.png',6),
(11,'rooms/bcf3426d-8970-4009-bc41-1056316e13bd_room.jpg',7),
(12,'rooms/bcf3426d-8970-4009-bc41-1056316e13bd_room.jpg',8),
(13,'rooms/366324b6-fad0-4156-a6c7-c74e86731ff5_hall.png',9);

/*Table structure for table `rooms` */

DROP TABLE IF EXISTS `rooms`;

CREATE TABLE `rooms` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `advance_booking_days` int NOT NULL,
  `available_from` date NOT NULL,
  `available_to` date NOT NULL,
  `base_price` decimal(12,2) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `floor` varchar(255) DEFAULT NULL,
  `is_active` bit(1) NOT NULL,
  `max_stay` int NOT NULL,
  `min_stay` int NOT NULL,
  `room_number` varchar(20) DEFAULT NULL,
  `room_type` varchar(255) DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `rooms` */

insert  into `rooms`(`id`,`advance_booking_days`,`available_from`,`available_to`,`base_price`,`created_at`,`floor`,`is_active`,`max_stay`,`min_stay`,`room_number`,`room_type`,`status`,`updated_at`) values 
(1,20,'2026-02-02','2026-12-31',500.00,'2026-02-02 07:44:15.273000','ग्राउंड फ्लोर','',5,1,'1','ONLY_ROOM','AVAILABLE','2026-02-02 07:44:15.278065'),
(2,20,'2026-02-02','2026-12-31',500.00,'2026-01-31 15:41:44.310566','ग्राउंड फ्लोर','',10,1,'2','ONLY_ROOM','AVAILABLE','2026-02-02 07:45:52.842834'),
(3,20,'2026-01-31','2026-12-31',500.00,'2026-01-31 15:43:02.896542','पहला फ्लोर','',10,1,'3','ONLY_ROOM','AVAILABLE','2026-01-31 15:43:02.896542'),
(4,20,'2026-01-31','2026-12-31',500.00,'2026-01-31 15:43:59.519533','पहला फ्लोर','',10,1,'4','ONLY_ROOM','AVAILABLE','2026-01-31 15:43:59.519533'),
(5,20,'2026-02-02','2026-12-31',5000.00,'2026-01-31 16:12:01.716616','ग्राउंड फ्लोर','',10,1,'5','HALL','AVAILABLE','2026-02-02 07:48:06.140332'),
(6,20,'2026-01-31','2026-12-31',5000.00,'2026-01-31 16:12:58.072026','पहला फ्लोर','',5,1,'6','HALL','AVAILABLE','2026-02-01 08:40:01.504530'),
(7,20,'2026-01-31','2026-12-31',10000.00,'2026-01-31 16:14:01.942992','ग्राउंड फ्लोर','',5,1,'7','COMPLETE_FLOOR','AVAILABLE','2026-01-31 16:14:01.942992'),
(8,20,'2026-01-31','2026-12-22',10000.00,'2026-01-31 16:15:20.299770','पहला फ्लोर','',5,1,'8','COMPLETE_FLOOR','AVAILABLE','2026-01-31 16:15:20.303264'),
(9,60,'2026-02-02','2026-12-31',50000.00,'2026-02-02 08:09:58.641354','सामुदायिक भवन','',5,1,'9','COMPLETE_BUILDING','AVAILABLE','2026-02-02 08:09:58.641354');

/*Table structure for table `staff` */

DROP TABLE IF EXISTS `staff`;

CREATE TABLE `staff` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `active` bit(1) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `staff` */

/*Table structure for table `testimonials` */

DROP TABLE IF EXISTS `testimonials`;

CREATE TABLE `testimonials` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `approved_by` varchar(255) DEFAULT NULL,
  `approved_date` datetime(6) DEFAULT NULL,
  `created_date` datetime(6) DEFAULT NULL,
  `designation` varchar(100) DEFAULT NULL,
  `display_order` int NOT NULL,
  `is_active` bit(1) NOT NULL,
  `message` varchar(1000) NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `updated_date` datetime(6) DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKcmnyplrhi40w8tky9okgrd476` (`user_id`),
  CONSTRAINT `FKcmnyplrhi40w8tky9okgrd476` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `testimonials` */

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `registration_no` varchar(255) DEFAULT NULL,
  `aadhar_number` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `agree_to_terms` bit(1) NOT NULL,
  `annual_fee_status` varchar(255) DEFAULT NULL,
  `approve_reject_by` varchar(255) DEFAULT NULL,
  `approved` varchar(255) DEFAULT NULL,
  `approved_reject_date` date DEFAULT NULL,
  `blood_group` varchar(255) DEFAULT NULL,
  `contribution` varchar(1000) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `education` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `father_name` varchar(255) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `gotra` varchar(255) DEFAULT NULL,
  `home_district` varchar(255) DEFAULT NULL,
  `last_annual_fee_amount` double DEFAULT NULL,
  `last_annual_fee_paid` date DEFAULT NULL,
  `marital_status` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) NOT NULL,
  `occupation` varchar(255) DEFAULT NULL,
  `organization_affiliation` varchar(255) DEFAULT NULL,
  `other_fee_validated` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `profile_image_path` varchar(255) DEFAULT NULL,
  `role` varchar(255) NOT NULL,
  `smaj_role` varchar(255) DEFAULT 'सदस्य',
  `smaj_role_priority` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_63cf888pmqtt5tipcne79xsbm` (`mobile`),
  UNIQUE KEY `UK_rx5fkg19exgehb87x6nt8stfx` (`registration_no`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `users` */

insert  into `users`(`id`,`registration_no`,`aadhar_number`,`address`,`agree_to_terms`,`annual_fee_status`,`approve_reject_by`,`approved`,`approved_reject_date`,`blood_group`,`contribution`,`created_date`,`date_of_birth`,`education`,`email`,`father_name`,`full_name`,`gender`,`gotra`,`home_district`,`last_annual_fee_amount`,`last_annual_fee_paid`,`marital_status`,`mobile`,`occupation`,`organization_affiliation`,`other_fee_validated`,`password`,`profile_image_path`,`role`,`smaj_role`,`smaj_role_priority`) values 
(1,'REG0001','293926382492','2-K-5','','प्रतीक्षारत',NULL,'स्वीकृत','2026-02-01','O+','Website','2026-02-01','1994-10-19','B.tech','hstmycell@gmail.com','Harish Sharma','Himanshu Sharma','पुरुष','Trigunayat','KOTA',NULL,NULL,'विवाहित','8089101719','Software Engineer','Raghav seva samiti','प्रतीक्षारत','$2a$10$z7WVTjjLMevcR9UwL06lmObaTPcTetk7p/TcDtZ3Q7l/KyjdkJhHu','/images/profile_images/user_1_1769962123708.jpeg','ADMIN','सदस्य',7);

/*Table structure for table `vivha_user` */

DROP TABLE IF EXISTS `vivha_user`;

CREATE TABLE `vivha_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `active` bit(1) NOT NULL,
  `approved` bit(1) NOT NULL,
  `birth_time` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `custom_gotra` varchar(255) DEFAULT NULL,
  `dadi_custom_gotra` varchar(255) DEFAULT NULL,
  `dadi_gotra` varchar(255) DEFAULT NULL,
  `dadi_name` varchar(255) DEFAULT NULL,
  `district` varchar(255) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `expectations` varchar(2000) DEFAULT NULL,
  `expected_education` varchar(255) DEFAULT NULL,
  `expected_income` varchar(255) DEFAULT NULL,
  `father_name` varchar(255) DEFAULT NULL,
  `father_occupation` varchar(255) DEFAULT NULL,
  `featured` bit(1) NOT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `gotra` varchar(255) DEFAULT NULL,
  `height` varchar(255) DEFAULT NULL,
  `house_address` varchar(255) DEFAULT NULL,
  `income` varchar(255) DEFAULT NULL,
  `login_mobile` varchar(255) DEFAULT NULL,
  `manglik` varchar(255) DEFAULT NULL,
  `marital_status` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `mother_custom_gotra` varchar(255) DEFAULT NULL,
  `mother_gotra` varchar(255) DEFAULT NULL,
  `mother_name` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `nani_custom_gotra` varchar(255) DEFAULT NULL,
  `nani_gotra` varchar(255) DEFAULT NULL,
  `nani_name` varchar(255) DEFAULT NULL,
  `occupation` varchar(255) DEFAULT NULL,
  `permanent_address` varchar(255) DEFAULT NULL,
  `pincode` varchar(255) DEFAULT NULL,
  `profile_image_path` varchar(255) DEFAULT NULL,
  `qualification` varchar(255) DEFAULT NULL,
  `rashi` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `weight` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `vivha_user` */

insert  into `vivha_user`(`id`,`active`,`approved`,`birth_time`,`city`,`custom_gotra`,`dadi_custom_gotra`,`dadi_gotra`,`dadi_name`,`district`,`dob`,`email`,`expectations`,`expected_education`,`expected_income`,`father_name`,`father_occupation`,`featured`,`gender`,`gotra`,`height`,`house_address`,`income`,`login_mobile`,`manglik`,`marital_status`,`mobile`,`mother_custom_gotra`,`mother_gotra`,`mother_name`,`name`,`nani_custom_gotra`,`nani_gotra`,`nani_name`,`occupation`,`permanent_address`,`pincode`,`profile_image_path`,`qualification`,`rashi`,`state`,`weight`) values 
(1,'','','13:46','KOTA','','','कुशिक','मोहनबाई','Kota','1994-10-19','hstmycell@gmail.com','','B.tech','2000000','Harish Sharma','Hapy','\0','पुरुष','त्रिगुणायत','','2-K-5','8000000','8089101719','नहीं','अविवाहित','8089101719','Parasar joshi','Parasar joshi','हेमलता शर्मा','हिमांशु शर्मा','','कश्यप','Mss','Software Engineer',NULL,'324005','/images/7f38ee68-3650-4bfd-bf6c-fa4ce5aa1371_WhatsApp Image 2025-11-07 at 22.25.26.jpeg','B.tech','Kark','Rajasthan','72 KG');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

/*
MySQL Data Transfer
Source Host: localhost
Source Database: smartsec_main
Target Host: localhost
Target Database: smartsec_main
Date: 11/9/2012 8:34:19 PM
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for client
-- ----------------------------
DROP TABLE IF EXISTS `client`;
CREATE TABLE `client` (
  `client_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `client_company_name` varchar(255) DEFAULT NULL,
  `client_contact_name` varchar(255) DEFAULT NULL,
  `client_address` text,
  `client_email` varchar(255) DEFAULT NULL,
  `client_phone1` varchar(255) DEFAULT NULL,
  `client_note` text,
  `client_reg_date` datetime DEFAULT NULL,
  `client_reg_by` bigint(20) unsigned DEFAULT NULL,
  `client_active` enum('0','1') DEFAULT '1',
  `client_user_ids` text,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for email
-- ----------------------------
DROP TABLE IF EXISTS `email`;
CREATE TABLE `email` (
  `email_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `email_from` text,
  `email_to` text,
  `email_cc` text,
  `email_bcc` text,
  `email_subject` text,
  `email_body` text,
  `email_datetime` datetime DEFAULT NULL,
  `email_component` enum('costsheet','purchaseorder') DEFAULT NULL,
  PRIMARY KEY (`email_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for history
-- ----------------------------
DROP TABLE IF EXISTS `history`;
CREATE TABLE `history` (
  `history_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `history_component` enum('user','costsheet','purchaseorder') DEFAULT NULL,
  `history_datetime` datetime DEFAULT NULL,
  `history_textlog` text,
  `history_user_id` bigint(20) unsigned DEFAULT NULL,
  `history_client_id` bigint(20) unsigned DEFAULT NULL,
  `history_costsheet_id` bigint(20) unsigned DEFAULT NULL,
  `history_po_id` bigint(20) unsigned DEFAULT NULL,
  `history_active` enum('0','1') DEFAULT '1',
  PRIMARY KEY (`history_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for module
-- ----------------------------
DROP TABLE IF EXISTS `module`;
CREATE TABLE `module` (
  `module_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `module_system_name` varchar(255) DEFAULT NULL,
  `module_full_name` varchar(255) DEFAULT NULL,
  `module_desc` text COMMENT 'description of the module',
  `module_user_type_ids` text COMMENT 'comma separated values',
  `module_parent_id` bigint(20) unsigned DEFAULT NULL COMMENT 'If the module is a sub-module of another parent module parent modules module_id should be stored in this field',
  `module_active` enum('1','0') DEFAULT '1',
  PRIMARY KEY (`module_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `p_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `p_module_id` bigint(255) DEFAULT NULL,
  `p_module_system_name` varchar(255) DEFAULT NULL,
  `p_action` varchar(255) DEFAULT NULL,
  `p_user_type_ids` varchar(1000) DEFAULT '1' COMMENT 'comma separated list of user_type_ids',
  `p_description` text,
  `p_active` enum('0','1') DEFAULT '1',
  PRIMARY KEY (`p_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for security_assignment
-- ----------------------------
DROP TABLE IF EXISTS `security_assignment`;
CREATE TABLE `security_assignment` (
  `sa_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sa_uid` varchar(255) DEFAULT NULL,
  `sa_date` date DEFAULT NULL,
  `sa_start_time` datetime DEFAULT NULL,
  `sa_end_time` datetime DEFAULT NULL,
  `sa_guard_user_id` bigint(20) DEFAULT NULL,
  `sa_requested_by_user_id` bigint(20) DEFAULT NULL,
  `sa_client_id` bigint(20) unsigned DEFAULT NULL,
  `sa_rate_id` bigint(20) DEFAULT NULL,
  `sa_rate` float unsigned DEFAULT NULL,
  `sa_site_id` bigint(20) DEFAULT NULL COMMENT 'this if for future use',
  `sa_status` enum('Invoice Sent','Invoice Pending') DEFAULT 'Invoice Pending',
  `sa_invoice_no` varchar(255) DEFAULT NULL,
  `sa_insert_time` datetime DEFAULT NULL,
  `sa_insert_user_id` bigint(20) DEFAULT NULL,
  `sa_comment` text,
  `sa_active` enum('1','0') DEFAULT '1',
  PRIMARY KEY (`sa_id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for security_assignment_notification
-- ----------------------------
DROP TABLE IF EXISTS `security_assignment_notification`;
CREATE TABLE `security_assignment_notification` (
  `san_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `san_sa_id` bigint(20) unsigned DEFAULT NULL,
  `san_sa_uid` varchar(255) DEFAULT NULL,
  `san_notified` enum('Yes','No') DEFAULT 'No',
  `san_active` enum('0','1') DEFAULT '1',
  PRIMARY KEY (`san_id`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for security_rate
-- ----------------------------
DROP TABLE IF EXISTS `security_rate`;
CREATE TABLE `security_rate` (
  `sr_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sr_name` text,
  `sr_value` float DEFAULT NULL,
  `sr_timespan` enum('per hour','per day','per month') DEFAULT 'per hour',
  `sr_active` enum('0','1') DEFAULT '1',
  PRIMARY KEY (`sr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for security_site
-- ----------------------------
DROP TABLE IF EXISTS `security_site`;
CREATE TABLE `security_site` (
  `ss_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ss_name` varchar(255) DEFAULT NULL,
  `ss_address` text,
  `ss_active` enum('0','1') DEFAULT '1',
  PRIMARY KEY (`ss_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(20) DEFAULT NULL,
  `user_fullname` varchar(255) DEFAULT NULL,
  `user_email` varchar(100) DEFAULT NULL,
  `user_phone` varchar(255) DEFAULT NULL,
  `user_password` varchar(20) DEFAULT NULL,
  `user_active` enum('0','1') DEFAULT '1',
  `user_type_id` smallint(6) DEFAULT '1',
  `user_other_info` text NOT NULL,
  `user_client_id` bigint(20) unsigned DEFAULT NULL,
  `user_reg_datetime` datetime DEFAULT NULL,
  `user_reg_by` bigint(20) unsigned DEFAULT NULL,
  `user_logged` enum('0','1') DEFAULT '0',
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=50 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for user_type
-- ----------------------------
DROP TABLE IF EXISTS `user_type`;
CREATE TABLE `user_type` (
  `user_type_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_type_name` text,
  `user_type_level` int(11) DEFAULT '1',
  `user_type_datetime` datetime DEFAULT NULL,
  `user_type_by` bigint(20) unsigned DEFAULT NULL,
  `user_type_active` enum('1','0') DEFAULT '1',
  PRIMARY KEY (`user_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `client` VALUES ('4', 'Lorel Ipsum(test)', 'Mr. Lorel', 'TRICOT MONDILA INC\r\nMain Warehouse \r\n7101 Ave.du Parc, Suite 507\r\nMontreal, Quebec', 'test.email@gmail.com', '', '', '2012-06-06 01:05:51', '1', '1', '');
INSERT INTO `client` VALUES ('5', 'MPS', 'George', '', 'test@test.au', '', '', '2012-07-08 17:34:04', '1', '1', '17,19,32,28,27,21,29,31,25,20,26,24,16,33,1,30,23,18,22');
INSERT INTO `client` VALUES ('6', 'East Site Protection', 'Phil Bondi', '', 'test@test.com', '', '', '2012-07-08 17:35:01', '1', '1', '17,19,32,28,27,21,29,31,25,20,26,24,16,33,1,30,23,18,22');
INSERT INTO `client` VALUES ('7', 'Teal House', 'Phil', '', 'test@abc.com.au', '', '', '2012-07-08 17:36:27', '1', '1', '17,19,32,28,27,21,29,31,25,20,26,24,16,33,1,30,23,18,22');
INSERT INTO `client` VALUES ('8', 'CRMI', 'Trevor', '', 'test@hiprosec.com', '', 'Trevor, Ben, Ewan', '2012-07-08 17:37:19', '1', '1', '17,19,32,28,27,21,29,31,25,20,26,24,16,33,1,30,23,18,22');
INSERT INTO `client` VALUES ('9', 'ESP Security', 'Ben', '', 'test.email@gmail.com', '', '', '2012-07-08 17:37:49', '1', '1', '17,19,32,28,27,21,29,31,25,20,26,24,16,33,1,30,23,18,22');
INSERT INTO `email` VALUES ('1', 'info.cost_quote@textilehorizon.com', 'info@activationltd.com', 'info@activationltd.com', '', 'Costsheet Approved -CoSt Lorel Ipsum: Client-Lorel Ipsum', '<span style=\'font-family:Courier New, Courier, monospace; font-size:12px\'>Costsheet Information <br>========================== <br>Costsheet Approver: 				superadmin<br>Costsheet Approval status:			Approved<br>Costsheet Approval requested by:	superadmin<br>Costsheet title: 					CoSt Lorel Ipsum<br>Costsheet Client: 					Lorel Ipsum<br>Costsheet Client: 					Mr. Lorel<br>Costsheet prepared by: 			superadmin<br>==========================<br>Click the url below to go to approve page<br><a href=\'http://localhost/activation/dreammerchant/layouts/site/costsheet_add.php?costsheet_id=30&param=view&client_id=4\'> \r\n					http://localhost/activation/dreammerchant/layouts/site/costsheet_add.php?costsheet_id=30&param=view&client_id=4\r\n					</a><br>==========================<br></span>', '2012-06-07 15:45:55', null);
INSERT INTO `email` VALUES ('2', 'info.cost_quote@textilehorizon.com', 'info@activationltd.com', 'info@activationltd.com', '', 'Costsheet approval Requested -asd fasd fasdf: Client-Lorel Ipsum', '<span style=\'font-family:Courier New, Courier, monospace; font-size:12px\'>Costsheet Information <br>========================== <br>Costsheet Approver: 				superadmin<br>Costsheet Approval status:			Requested_approval<br>Costsheet Approval requested by:	superadmin<br>Costsheet title: 					asd fasd fasdf<br>Costsheet Client: 					Lorel Ipsum<br>Costsheet Client: 					Mr. Lorel<br>Costsheet prepared by: 			superadmin<br>==========================<br>Click the url below to go to approve page<br><a href=\'http://localhost/activation/dreammerchant/layouts/site/costsheet_add.php?costsheet_id=31&param=view&client_id=4\'> \r\n					http://localhost/activation/dreammerchant/layouts/site/costsheet_add.php?costsheet_id=31&param=view&client_id=4\r\n					</a><br>==========================<br></span>', '2012-06-20 17:00:02', null);
INSERT INTO `email` VALUES ('3', 'info.cost_quote@textilehorizon.com', 'info@activationltd.com', 'info@activationltd.com', '', 'Costsheet approval Requested -Test R XXXXX123: Client-Lorel Ipsum', '<span style=\'font-family:Courier New, Courier, monospace; font-size:12px\'>Costsheet Information <br>========================== <br>Costsheet Approver: 				superadmin<br>Costsheet Approval status:			Requested_approval<br>Costsheet Approval requested by:	superadmin<br>Costsheet title: 					Test R XXXXX123<br>Costsheet Client: 					Lorel Ipsum<br>Costsheet Client: 					Mr. Lorel<br>Costsheet prepared by: 			superadmin<br>==========================<br>Click the url below to go to approve page<br><a href=\'http://localhost/activation/dreammerchant/layouts/site/costsheet_add.php?costsheet_id=32&param=view&client_id=4\'> \r\n					http://localhost/activation/dreammerchant/layouts/site/costsheet_add.php?costsheet_id=32&param=view&client_id=4\r\n					</a><br>==========================<br></span>', '2012-06-22 14:37:30', null);
INSERT INTO `history` VALUES ('1', 'costsheet', '2012-06-07 15:45:55', 'Costsheet Approved', '0', '0', '30', '0', '1');
INSERT INTO `history` VALUES ('2', 'costsheet', '2012-06-20 17:00:02', 'Costsheet approval requested', '0', '0', '31', '0', '1');
INSERT INTO `history` VALUES ('3', 'costsheet', '2012-06-22 14:37:30', 'Costsheet approval requested', '0', '0', '32', '0', '1');
INSERT INTO `module` VALUES ('1', 'costsheet', 'Costsheet', 'Cost sheet management', null, '4', '1');
INSERT INTO `module` VALUES ('2', 'purchaseorder', 'Purchase Order', 'purchase order management', null, '4', '1');
INSERT INTO `module` VALUES ('3', 'user', 'User', 'user management', null, '0', '1');
INSERT INTO `module` VALUES ('4', 'client', 'Client', 'client management', null, '0', '1');
INSERT INTO `permission` VALUES ('10', '3', 'user', 'add', '1,4', null, '1');
INSERT INTO `permission` VALUES ('11', '3', 'user', 'edit', '1,4', null, '1');
INSERT INTO `permission` VALUES ('12', '3', 'user', 'delete', '1,4', null, '1');
INSERT INTO `permission` VALUES ('13', '3', 'user', 'view', '1,4', null, '1');
INSERT INTO `permission` VALUES ('14', '3', 'user', 'archive', '1,4', null, '1');
INSERT INTO `permission` VALUES ('16', '4', 'client', 'add', '1', null, '0');
INSERT INTO `permission` VALUES ('17', '4', 'client', 'edit', '1', null, '0');
INSERT INTO `permission` VALUES ('18', '4', 'client', 'delete', '1', null, '0');
INSERT INTO `permission` VALUES ('19', '4', 'client', 'archive', '1', null, '0');
INSERT INTO `permission` VALUES ('20', '4', 'client', 'view', '1', null, '0');
INSERT INTO `permission` VALUES ('21', '5', 'user_type', 'add', '1,4', null, '1');
INSERT INTO `permission` VALUES ('22', '5', 'user_type', 'edit', '1,4', null, '1');
INSERT INTO `permission` VALUES ('23', '5', 'user_type', 'delete', '1,4', null, '1');
INSERT INTO `permission` VALUES ('24', '5', 'user_type', 'view', '1,4', null, '1');
INSERT INTO `permission` VALUES ('25', '5', 'user_type', 'archive', '1,4', null, '1');
INSERT INTO `permission` VALUES ('32', '6', 'security_assignment', 'add', '1,4', null, '1');
INSERT INTO `permission` VALUES ('33', '6', 'security_assignment', 'edit', '1,4', null, '1');
INSERT INTO `permission` VALUES ('34', '6', 'security_assignment', 'delete', '1,4', null, '1');
INSERT INTO `permission` VALUES ('35', '6', 'security_assignment', 'view', '1,3,4', null, '1');
INSERT INTO `permission` VALUES ('36', '6', 'security_assignment', 'archive', '1,4', null, '1');
INSERT INTO `security_assignment` VALUES ('1', 'UIQ3ou5Kf3uuLlanFNeG_1343552669', null, '2012-07-01 00:00:00', '2012-07-29 11:00:00', '16', '32', '4', null, '1', '11', 'Invoice Pending', null, '2012-07-29 04:04:29', '1', null, '0');
INSERT INTO `security_assignment` VALUES ('2', 'UIQ3ou5Kf3uuLlanFNeG_1343552669', null, '2012-07-01 00:00:00', '2012-07-29 11:00:00', '16', '32', '4', null, '1', '11', 'Invoice Pending', null, '2012-07-29 04:04:44', '1', null, '0');
INSERT INTO `security_assignment` VALUES ('3', 'UIQ3ou5Kf3uuLlanFNeG_1343552669', null, '2012-07-01 00:00:00', '2012-07-29 11:00:00', '16', '32', '4', null, '1', '11', 'Invoice Pending', null, '2012-07-29 04:04:58', '1', null, '0');
INSERT INTO `security_assignment` VALUES ('4', 'eRIztSgQeUbQXgPaOy9i_1343595213', null, '2012-07-30 00:00:00', '2012-07-30 03:00:00', '16', '32', '7', null, '12', '10', 'Invoice Pending', null, '2012-07-29 15:53:33', '1', null, '0');
INSERT INTO `security_assignment` VALUES ('5', '0NvHI79gEDqxaHNjTv54_1343647538', null, '2012-07-30 22:00:00', '2012-07-31 06:00:00', '35', '34', '7', null, '25', '10', 'Invoice Pending', null, '2012-07-30 06:25:38', '1', null, '0');
INSERT INTO `security_assignment` VALUES ('6', 'tC181DNvTGCTlCKdaMRV_1343647974', null, '2012-07-31 14:00:00', '2012-07-31 22:00:00', '36', '34', '7', null, '25', '10', 'Invoice Pending', null, '2012-07-30 06:32:54', '1', null, '0');
INSERT INTO `security_assignment` VALUES ('7', 'llsYW2C2XdqNjT6nGUsN_1344171321', null, '2012-08-05 22:00:00', '2012-08-06 06:00:00', '35', '34', '7', null, '25', '10', 'Invoice Pending', null, '2012-08-05 07:55:21', '1', null, '0');
INSERT INTO `security_assignment` VALUES ('8', 'fyBJqFPvjlJbzqAfRSTj_1344171780', null, '2012-08-06 14:00:00', '2012-08-05 22:00:00', '36', '34', '7', null, '25', '10', 'Invoice Pending', null, '2012-08-05 08:03:00', '1', null, '1');
INSERT INTO `security_assignment` VALUES ('9', 'fyBJqFPvjlJbzqAfRSTj_1344171780', null, '2012-08-06 14:00:00', '2012-08-05 22:00:00', '35', '34', '7', null, '25', '10', 'Invoice Pending', null, '2012-08-05 08:13:16', '1', null, '1');
INSERT INTO `security_assignment` VALUES ('10', 'llsYW2C2XdqNjT6nGUsN_1344171321', null, '2012-08-05 14:00:00', '2012-08-06 22:00:00', '36', '34', '7', null, '25', '10', 'Invoice Pending', null, '2012-08-05 08:14:11', '1', null, '0');
INSERT INTO `security_assignment` VALUES ('11', 'llsYW2C2XdqNjT6nGUsN_1344171321', null, '2012-08-06 14:00:00', '2012-08-06 22:00:00', '36', '34', '7', null, '25', '10', 'Invoice Pending', null, '2012-08-05 08:15:15', '1', null, '0');
INSERT INTO `security_assignment` VALUES ('12', 'fyBJqFPvjlJbzqAfRSTj_1344171780', null, '2012-08-06 22:00:00', '2012-08-07 06:00:00', '35', '34', '7', null, '25', '10', 'Invoice Pending', null, '2012-08-05 08:17:59', '1', null, '1');
INSERT INTO `security_assignment` VALUES ('13', 'llsYW2C2XdqNjT6nGUsN_1344171321', null, '2012-08-06 22:00:00', '2012-08-06 06:00:00', '36', '34', '7', null, '25', '10', 'Invoice Pending', null, '2012-08-05 08:18:54', '1', null, '0');
INSERT INTO `security_assignment` VALUES ('14', 'llsYW2C2XdqNjT6nGUsN_1344171321', null, '2012-08-06 14:00:00', '2012-08-08 22:00:00', '36', '34', '7', null, '25', '10', 'Invoice Pending', null, '2012-08-05 08:20:25', '1', null, '0');
INSERT INTO `security_assignment` VALUES ('15', 'llsYW2C2XdqNjT6nGUsN_1344171321', null, '2012-08-06 14:00:00', '2012-08-07 22:00:00', '36', '34', '7', null, '25', '10', 'Invoice Pending', null, '2012-08-05 08:22:47', '1', null, '0');
INSERT INTO `security_assignment` VALUES ('16', 'AjPDpusKJBAsiWHa4fV2_1344229619', null, '2012-08-07 22:00:00', '2012-08-08 06:00:00', '35', '34', '7', null, '25', '10', 'Invoice Pending', null, '2012-08-06 00:06:59', '1', null, '1');
INSERT INTO `security_assignment` VALUES ('17', 'AjPDpusKJBAsiWHa4fV2_1344229619', null, '2012-08-07 22:00:00', '2012-08-08 06:00:00', '35', '34', '7', null, '25', '10', 'Invoice Pending', null, '2012-08-06 00:08:28', '1', null, '1');
INSERT INTO `security_assignment` VALUES ('18', 'LcxLJxrTFonAKrpHIFqS_1344229859', null, '2012-08-08 14:00:00', '2012-08-08 22:00:00', '36', '34', '7', null, '25', '10', 'Invoice Pending', null, '2012-08-06 00:10:59', '1', null, '1');
INSERT INTO `security_assignment` VALUES ('19', 'LcxLJxrTFonAKrpHIFqS_1344229859', null, '2012-08-07 14:00:00', '2012-08-07 22:00:00', '36', '34', '7', null, '25', '10', 'Invoice Pending', null, '2012-08-06 00:17:23', '1', null, '1');
INSERT INTO `security_assignment` VALUES ('20', 'HdYWdswd9lL7QfWDNfNq_1344230521', null, '2012-08-08 14:00:00', '2012-08-08 22:00:00', '36', '34', '7', null, '25', '9', 'Invoice Pending', null, '2012-08-06 00:22:01', '1', null, '1');
INSERT INTO `security_assignment` VALUES ('21', 'Nx4dudnKOTY6EdGGXjnc_1344230585', null, '2012-08-08 22:00:00', '2012-08-09 06:00:00', '35', '34', '7', null, '25', '9', 'Invoice Pending', null, '2012-08-06 00:23:05', '1', null, '1');
INSERT INTO `security_assignment` VALUES ('22', 'Qxw2rPudstzSAXTgryBC_1344236760', null, '2012-07-30 07:00:00', '2012-07-30 19:00:00', '26', '38', '8', null, '25', '13', 'Invoice Pending', null, '2012-08-06 02:06:00', '1', null, '1');
INSERT INTO `security_assignment` VALUES ('23', 'dA2EK1RBNE1D5nEfBXK9_1344237075', null, '2012-07-31 22:00:00', '2012-08-01 06:00:00', '19', '38', '8', null, '25', '15', 'Invoice Pending', null, '2012-08-06 02:11:15', '1', null, '1');
INSERT INTO `security_assignment` VALUES ('24', 'jFaAsrfDRoT3fm7FBIb9_1344237195', null, '2012-08-01 22:00:00', '2012-08-02 06:00:00', '19', '38', '8', null, '25', '15', 'Invoice Pending', null, '2012-08-06 02:13:15', '1', null, '1');
INSERT INTO `security_assignment` VALUES ('25', 'o2hrx4d50j9evdeNt6hE_1344237349', null, '2012-08-02 22:00:00', '2012-07-03 06:00:00', '31', '38', '8', null, '25', '15', 'Invoice Pending', null, '2012-08-06 02:15:49', '1', null, '1');
INSERT INTO `security_assignment` VALUES ('26', 'siSMbAnmVQT0rtfqVfIk_1344237440', null, '2012-08-03 22:00:00', '2012-09-04 06:00:00', '31', '38', '8', null, '25', '15', 'Invoice Pending', null, '2012-08-06 02:17:20', '1', null, '0');
INSERT INTO `security_assignment` VALUES ('27', 'xuUtp5gxi6GWr3tR8VZd_1344237507', null, '2012-08-01 07:00:00', '2012-08-01 19:00:00', '26', '38', '8', null, '25', '14', 'Invoice Pending', null, '2012-08-06 02:18:27', '1', null, '0');
INSERT INTO `security_assignment` VALUES ('28', 'o2hrx4d50j9evdeNt6hE_1344237349', null, '2012-08-02 22:00:00', '2012-08-03 06:00:00', '31', '38', '8', null, '25', '15', 'Invoice Pending', null, '2012-08-06 02:20:45', '1', null, '1');
INSERT INTO `security_assignment` VALUES ('29', 'bkLC2sGm7SHMALmHFHoG_1344238296', null, '2012-08-03 22:00:00', '2012-08-04 00:00:00', '26', '38', '8', null, '25', '14', 'Invoice Pending', null, '2012-08-06 02:31:36', '1', null, '1');
INSERT INTO `security_assignment` VALUES ('30', 'QrF2vWLfyYxFimPwqiWU_1344238370', null, '2012-08-04 00:00:00', '2012-08-04 06:00:00', '26', '38', '8', null, '27', '14', 'Invoice Pending', null, '2012-08-06 02:32:50', '1', null, '1');
INSERT INTO `security_assignment` VALUES ('31', '60fEMz6xLl9x2rJfg9xP_1344238731', null, '2012-07-02 07:00:00', '2012-08-02 19:00:00', '26', '38', '8', null, '25', '14', 'Invoice Pending', null, '2012-08-06 02:38:51', '1', null, '1');
INSERT INTO `security_assignment` VALUES ('32', 'WOQLqCdrX93gmbx1sMaf_1344238842', null, '2012-08-04 07:00:00', '2012-07-04 19:00:00', '26', '38', '8', null, '27', '14', 'Invoice Pending', null, '2012-08-06 02:40:42', '1', null, '1');
INSERT INTO `security_assignment` VALUES ('33', '3mtEXfYTLTCDVyj3xCj7_1344238905', null, '2012-07-05 07:00:00', '2012-07-05 19:00:00', '26', '38', '8', null, '27', '14', 'Invoice Pending', null, '2012-08-06 02:41:45', '1', null, '1');
INSERT INTO `security_assignment` VALUES ('34', 'WOQLqCdrX93gmbx1sMaf_1344238842', null, '2012-08-04 07:00:00', '2012-08-04 19:00:00', '26', '38', '8', null, '27', '14', 'Invoice Pending', null, '2012-08-06 02:43:24', '1', null, '1');
INSERT INTO `security_assignment` VALUES ('35', '60fEMz6xLl9x2rJfg9xP_1344238731', null, '2012-08-02 07:00:00', '2012-08-02 19:00:00', '26', '38', '8', null, '25', '14', 'Invoice Pending', null, '2012-08-06 02:44:18', '1', null, '1');
INSERT INTO `security_assignment` VALUES ('36', '3mtEXfYTLTCDVyj3xCj7_1344238905', null, '2012-08-05 07:00:00', '2012-08-05 19:00:00', '26', '38', '8', null, '27', '14', 'Invoice Pending', null, '2012-08-06 02:48:56', '1', null, '1');
INSERT INTO `security_assignment` VALUES ('37', 'm1I33Da67YLmeqq7M3jj_1344239456', null, '2012-08-01 07:00:00', '2012-08-01 19:00:00', '26', '38', '8', null, '25', '14', 'Invoice Pending', null, '2012-08-06 02:50:56', '1', null, '1');
INSERT INTO `security_assignment` VALUES ('38', 'ut3hzRC3RJJJGuWF61qW_1345114826', null, '2012-08-08 22:00:00', '2012-08-09 00:00:00', '31', '39', '8', null, '25', '15', 'Invoice Pending', null, '2012-08-16 06:00:27', '1', null, '1');
INSERT INTO `security_assignment` VALUES ('39', 'cs2rr8rxfcL12ZzZSduw_1345114882', null, '2012-08-09 00:00:00', '2012-08-09 06:00:00', '31', '39', '8', null, '25', '15', 'Invoice Pending', null, '2012-08-16 06:01:22', '1', null, '1');
INSERT INTO `security_assignment` VALUES ('40', 'Uu4rPentJ5OzTcEn88fz_1345114939', null, '2012-08-09 22:00:00', '2012-08-10 00:00:00', '31', '39', '8', null, '25', '15', 'Invoice Pending', null, '2012-08-16 06:02:19', '1', null, '1');
INSERT INTO `security_assignment` VALUES ('41', '2FP0NONsuyT22X4JlEUa_1345114996', null, '2012-08-10 00:00:00', '2012-08-10 06:00:00', '31', '39', '8', null, '27', '15', 'Invoice Pending', null, '2012-08-16 06:03:16', '1', null, '1');
INSERT INTO `security_assignment` VALUES ('42', 'fyBJqFPvjlJbzqAfRSTj_1344171780', null, '2012-08-29 22:00:00', '2012-08-30 06:00:00', '35', '34', '7', null, '25', '10', 'Invoice Pending', null, '2012-08-29 13:05:25', '1', null, '1');
INSERT INTO `security_assignment` VALUES ('43', 'fyBJqFPvjlJbzqAfRSTj_1344171780', null, '2012-08-29 22:00:00', '2012-08-30 06:00:00', '35', '34', '7', null, '25', '10', 'Invoice Pending', null, '2012-10-15 05:35:29', '1', 'test comment goes here', '1');
INSERT INTO `security_assignment` VALUES ('44', 'fyBJqFPvjlJbzqAfRSTj_1344171780', null, '2012-08-29 22:00:00', '2012-08-30 06:00:00', '35', '34', '7', null, '25', '10', 'Invoice Pending', null, '2012-10-15 18:28:19', '1', 'test comment goes here', '1');
INSERT INTO `security_assignment` VALUES ('45', 'NOELf6qkxalNqL3ldXVe_1350304302', null, '2012-10-15 00:00:00', '2012-10-16 00:00:00', '27', '32', '7', null, '1', '18', 'Invoice Pending', null, '2012-10-15 18:31:42', '1', '', '1');
INSERT INTO `security_assignment` VALUES ('46', 'NOELf6qkxalNqL3ldXVe_1350304302', null, '2012-10-15 00:00:00', '2012-10-16 00:00:00', '27', '32', '7', null, '1', '18', 'Invoice Pending', null, '2012-10-15 18:32:01', '1', '', '1');
INSERT INTO `security_assignment` VALUES ('47', 'OJfrxyTyPUNwLrZefyXo_1350304437', null, '2012-10-15 00:00:00', '2012-10-16 00:00:00', '47', '32', '4', null, '12', '10', 'Invoice Pending', null, '2012-10-15 18:33:57', '1', '', '1');
INSERT INTO `security_assignment` VALUES ('48', 'dEX3QskeC0vtB23hV9Q0_1350304799', null, '2012-10-16 00:00:00', '2012-10-16 00:00:00', '20', '33', '4', null, '25', '3', 'Invoice Pending', null, '2012-10-15 18:39:59', '1', 'test comment', '1');
INSERT INTO `security_assignment` VALUES ('49', 'mPQhfxTF4l6M36FyaPpN_1351405933', null, '2012-10-02 00:00:00', '2012-10-03 00:00:00', '47', '39', '6', null, '12', '18', 'Invoice Pending', null, '2012-10-28 12:32:13', '1', '', '1');
INSERT INTO `security_assignment` VALUES ('50', 'NOELf6qkxalNqL3ldXVe_1350304302', null, '2012-10-15 00:00:00', '2012-10-16 00:00:00', '27', '32', '7', null, '1', '18', 'Invoice Pending', null, '2012-10-28 12:32:26', '1', '', '1');
INSERT INTO `security_assignment` VALUES ('51', 'OJfrxyTyPUNwLrZefyXo_1350304437', null, '2012-10-15 00:00:00', '2012-10-16 00:00:00', '47', '32', '4', null, '12', '10', 'Invoice Pending', null, '2012-10-28 12:39:30', '1', '', '1');
INSERT INTO `security_assignment` VALUES ('52', 'OJfrxyTyPUNwLrZefyXo_1350304437', null, '2012-10-15 00:00:00', '2012-10-16 00:00:00', '47', '32', '4', null, '12', '10', 'Invoice Pending', null, '2012-10-28 12:41:15', '1', '', '1');
INSERT INTO `security_assignment` VALUES ('53', 'OJfrxyTyPUNwLrZefyXo_1350304437', null, '2012-10-15 00:00:00', '2012-10-16 00:00:00', '47', '32', '4', null, '12', '10', 'Invoice Pending', null, '2012-10-28 12:41:36', '1', '', '1');
INSERT INTO `security_assignment` VALUES ('54', 'eAx2QsYj1WWbbvKR7CRN_1351407427', null, '2012-10-15 00:00:00', '2012-10-16 00:00:00', '47', '32', '4', null, '12', '10', 'Invoice Pending', null, '2012-10-28 12:57:07', '1', '', '1');
INSERT INTO `security_assignment` VALUES ('55', 'mPQhfxTF4l6M36FyaPpN_1351405933', null, '2012-10-02 00:00:00', '2012-10-03 00:00:00', '47', '39', '6', null, '12', '18', 'Invoice Pending', null, '2012-10-28 13:11:36', '1', '', '1');
INSERT INTO `security_assignment` VALUES ('56', 'dEX3QskeC0vtB23hV9Q0_1350304799', null, '2012-10-16 00:00:00', '2012-10-16 00:00:00', '20', '33', '4', null, '25', '3', 'Invoice Pending', null, '2012-10-28 13:23:05', '1', 'test comment', '1');
INSERT INTO `security_assignment` VALUES ('57', 'NOELf6qkxalNqL3ldXVe_1350304302', null, '2012-11-06 00:00:00', '2012-11-06 06:00:00', '27', '32', '7', null, '1', '18', 'Invoice Pending', null, '2012-11-06 02:06:37', '1', '', '1');
INSERT INTO `security_assignment` VALUES ('58', 'OJfrxyTyPUNwLrZefyXo_1350304437', null, '2012-11-07 00:00:00', '2012-11-07 07:00:00', '47', '32', '4', null, '12', '10', 'Invoice Pending', null, '2012-11-06 02:07:01', '1', '', '1');
INSERT INTO `security_assignment` VALUES ('59', 'yg7vB7fy1zmE1blwEHHc_1352146036', null, '2012-11-08 00:00:00', '2012-11-08 15:00:00', '47', '32', '4', null, '12', '10', 'Invoice Pending', null, '2012-11-06 02:07:16', '1', '', '1');
INSERT INTO `security_assignment` VALUES ('60', 'uGLkwJyVSawdyF99ZJGW_1352146052', null, '2012-11-09 00:00:00', '2012-11-09 15:00:00', '47', '32', '4', null, '12', '10', 'Invoice Pending', null, '2012-11-06 02:07:32', '1', '', '1');
INSERT INTO `security_assignment_notification` VALUES ('15', '61', 'sBkMbcYXX8cUX7c95ymj_1343543014', 'No', '0');
INSERT INTO `security_assignment_notification` VALUES ('16', '62', 'sBkMbcYXX8cUX7c95ymj_1343543014', 'No', '0');
INSERT INTO `security_assignment_notification` VALUES ('17', '63', 'sBkMbcYXX8cUX7c95ymj_1343543014', 'Yes', '1');
INSERT INTO `security_assignment_notification` VALUES ('18', '1', 'UIQ3ou5Kf3uuLlanFNeG_1343552669', 'No', '0');
INSERT INTO `security_assignment_notification` VALUES ('19', '2', 'UIQ3ou5Kf3uuLlanFNeG_1343552669', 'No', '0');
INSERT INTO `security_assignment_notification` VALUES ('20', '3', 'UIQ3ou5Kf3uuLlanFNeG_1343552669', 'Yes', '1');
INSERT INTO `security_assignment_notification` VALUES ('21', '4', 'eRIztSgQeUbQXgPaOy9i_1343595213', 'Yes', '1');
INSERT INTO `security_assignment_notification` VALUES ('22', '5', '0NvHI79gEDqxaHNjTv54_1343647538', 'Yes', '1');
INSERT INTO `security_assignment_notification` VALUES ('23', '6', 'tC181DNvTGCTlCKdaMRV_1343647974', 'Yes', '1');
INSERT INTO `security_assignment_notification` VALUES ('24', '7', 'llsYW2C2XdqNjT6nGUsN_1344171321', 'Yes', '0');
INSERT INTO `security_assignment_notification` VALUES ('25', '8', 'fyBJqFPvjlJbzqAfRSTj_1344171780', 'No', '0');
INSERT INTO `security_assignment_notification` VALUES ('26', '9', 'fyBJqFPvjlJbzqAfRSTj_1344171780', 'No', '0');
INSERT INTO `security_assignment_notification` VALUES ('27', '10', 'llsYW2C2XdqNjT6nGUsN_1344171321', 'No', '0');
INSERT INTO `security_assignment_notification` VALUES ('28', '11', 'llsYW2C2XdqNjT6nGUsN_1344171321', 'No', '0');
INSERT INTO `security_assignment_notification` VALUES ('29', '12', 'fyBJqFPvjlJbzqAfRSTj_1344171780', 'Yes', '0');
INSERT INTO `security_assignment_notification` VALUES ('30', '13', 'llsYW2C2XdqNjT6nGUsN_1344171321', 'No', '0');
INSERT INTO `security_assignment_notification` VALUES ('31', '14', 'llsYW2C2XdqNjT6nGUsN_1344171321', 'Yes', '0');
INSERT INTO `security_assignment_notification` VALUES ('32', '15', 'llsYW2C2XdqNjT6nGUsN_1344171321', 'Yes', '1');
INSERT INTO `security_assignment_notification` VALUES ('33', '16', 'AjPDpusKJBAsiWHa4fV2_1344229619', 'No', '0');
INSERT INTO `security_assignment_notification` VALUES ('34', '17', 'AjPDpusKJBAsiWHa4fV2_1344229619', 'Yes', '1');
INSERT INTO `security_assignment_notification` VALUES ('35', '18', 'LcxLJxrTFonAKrpHIFqS_1344229859', 'No', '0');
INSERT INTO `security_assignment_notification` VALUES ('36', '19', 'LcxLJxrTFonAKrpHIFqS_1344229859', 'Yes', '1');
INSERT INTO `security_assignment_notification` VALUES ('37', '20', 'HdYWdswd9lL7QfWDNfNq_1344230521', 'Yes', '1');
INSERT INTO `security_assignment_notification` VALUES ('38', '21', 'Nx4dudnKOTY6EdGGXjnc_1344230585', 'Yes', '1');
INSERT INTO `security_assignment_notification` VALUES ('39', '22', 'Qxw2rPudstzSAXTgryBC_1344236760', 'Yes', '1');
INSERT INTO `security_assignment_notification` VALUES ('40', '23', 'dA2EK1RBNE1D5nEfBXK9_1344237075', 'Yes', '1');
INSERT INTO `security_assignment_notification` VALUES ('41', '24', 'jFaAsrfDRoT3fm7FBIb9_1344237195', 'Yes', '1');
INSERT INTO `security_assignment_notification` VALUES ('42', '25', 'o2hrx4d50j9evdeNt6hE_1344237349', 'No', '0');
INSERT INTO `security_assignment_notification` VALUES ('43', '26', 'siSMbAnmVQT0rtfqVfIk_1344237440', 'Yes', '1');
INSERT INTO `security_assignment_notification` VALUES ('44', '27', 'xuUtp5gxi6GWr3tR8VZd_1344237507', 'Yes', '1');
INSERT INTO `security_assignment_notification` VALUES ('45', '28', 'o2hrx4d50j9evdeNt6hE_1344237349', 'Yes', '1');
INSERT INTO `security_assignment_notification` VALUES ('46', '29', 'bkLC2sGm7SHMALmHFHoG_1344238296', 'Yes', '1');
INSERT INTO `security_assignment_notification` VALUES ('47', '30', 'QrF2vWLfyYxFimPwqiWU_1344238370', 'Yes', '1');
INSERT INTO `security_assignment_notification` VALUES ('48', '31', '60fEMz6xLl9x2rJfg9xP_1344238731', 'Yes', '0');
INSERT INTO `security_assignment_notification` VALUES ('49', '32', 'WOQLqCdrX93gmbx1sMaf_1344238842', 'Yes', '0');
INSERT INTO `security_assignment_notification` VALUES ('50', '33', '3mtEXfYTLTCDVyj3xCj7_1344238905', 'Yes', '0');
INSERT INTO `security_assignment_notification` VALUES ('51', '34', 'WOQLqCdrX93gmbx1sMaf_1344238842', 'Yes', '1');
INSERT INTO `security_assignment_notification` VALUES ('52', '35', '60fEMz6xLl9x2rJfg9xP_1344238731', 'Yes', '1');
INSERT INTO `security_assignment_notification` VALUES ('53', '36', '3mtEXfYTLTCDVyj3xCj7_1344238905', 'Yes', '1');
INSERT INTO `security_assignment_notification` VALUES ('54', '37', 'm1I33Da67YLmeqq7M3jj_1344239456', 'Yes', '1');
INSERT INTO `security_assignment_notification` VALUES ('55', '38', 'ut3hzRC3RJJJGuWF61qW_1345114826', 'Yes', '1');
INSERT INTO `security_assignment_notification` VALUES ('56', '39', 'cs2rr8rxfcL12ZzZSduw_1345114882', 'Yes', '1');
INSERT INTO `security_assignment_notification` VALUES ('57', '40', 'Uu4rPentJ5OzTcEn88fz_1345114939', 'Yes', '1');
INSERT INTO `security_assignment_notification` VALUES ('58', '41', '2FP0NONsuyT22X4JlEUa_1345114996', 'Yes', '1');
INSERT INTO `security_assignment_notification` VALUES ('59', '42', 'fyBJqFPvjlJbzqAfRSTj_1344171780', 'Yes', '0');
INSERT INTO `security_assignment_notification` VALUES ('60', '43', 'fyBJqFPvjlJbzqAfRSTj_1344171780', 'No', '0');
INSERT INTO `security_assignment_notification` VALUES ('61', '44', 'fyBJqFPvjlJbzqAfRSTj_1344171780', 'Yes', '1');
INSERT INTO `security_assignment_notification` VALUES ('62', '45', 'NOELf6qkxalNqL3ldXVe_1350304302', 'No', '0');
INSERT INTO `security_assignment_notification` VALUES ('63', '46', 'NOELf6qkxalNqL3ldXVe_1350304302', 'No', '0');
INSERT INTO `security_assignment_notification` VALUES ('64', '47', 'OJfrxyTyPUNwLrZefyXo_1350304437', 'No', '0');
INSERT INTO `security_assignment_notification` VALUES ('65', '48', 'dEX3QskeC0vtB23hV9Q0_1350304799', 'No', '0');
INSERT INTO `security_assignment_notification` VALUES ('66', '49', 'mPQhfxTF4l6M36FyaPpN_1351405933', 'No', '0');
INSERT INTO `security_assignment_notification` VALUES ('67', '50', 'NOELf6qkxalNqL3ldXVe_1350304302', 'Yes', '0');
INSERT INTO `security_assignment_notification` VALUES ('68', '51', 'OJfrxyTyPUNwLrZefyXo_1350304437', 'No', '0');
INSERT INTO `security_assignment_notification` VALUES ('69', '52', 'OJfrxyTyPUNwLrZefyXo_1350304437', 'No', '0');
INSERT INTO `security_assignment_notification` VALUES ('70', '53', 'OJfrxyTyPUNwLrZefyXo_1350304437', 'Yes', '0');
INSERT INTO `security_assignment_notification` VALUES ('71', '54', 'eAx2QsYj1WWbbvKR7CRN_1351407427', 'Yes', '1');
INSERT INTO `security_assignment_notification` VALUES ('72', '55', 'mPQhfxTF4l6M36FyaPpN_1351405933', 'Yes', '1');
INSERT INTO `security_assignment_notification` VALUES ('73', '56', 'dEX3QskeC0vtB23hV9Q0_1350304799', 'Yes', '1');
INSERT INTO `security_assignment_notification` VALUES ('74', '57', 'NOELf6qkxalNqL3ldXVe_1350304302', 'Yes', '1');
INSERT INTO `security_assignment_notification` VALUES ('75', '58', 'OJfrxyTyPUNwLrZefyXo_1350304437', 'Yes', '1');
INSERT INTO `security_assignment_notification` VALUES ('76', '59', 'yg7vB7fy1zmE1blwEHHc_1352146036', 'Yes', '1');
INSERT INTO `security_assignment_notification` VALUES ('77', '60', 'uGLkwJyVSawdyF99ZJGW_1352146052', 'Yes', '1');
INSERT INTO `security_site` VALUES ('1', 'Picton', '', '1');
INSERT INTO `security_site` VALUES ('2', 'Citywest', null, '1');
INSERT INTO `security_site` VALUES ('3', 'PMG', null, '1');
INSERT INTO `security_site` VALUES ('4', 'Verizon', null, '1');
INSERT INTO `security_site` VALUES ('5', 'Kambala', null, '1');
INSERT INTO `security_site` VALUES ('6', 'St.Vincents', null, '1');
INSERT INTO `security_site` VALUES ('7', 'MCS_Canel', null, '1');
INSERT INTO `security_site` VALUES ('8', 'MCS_Banksmedow', null, '1');
INSERT INTO `security_site` VALUES ('9', 'PLC', null, '1');
INSERT INTO `security_site` VALUES ('10', 'Ascham', null, '1');
INSERT INTO `security_site` VALUES ('11', 'Champ Security', null, '1');
INSERT INTO `security_site` VALUES ('12', 'Ryde', 'Ryde', '1');
INSERT INTO `security_site` VALUES ('13', 'HOLT ST', 'HOLT ST', '1');
INSERT INTO `security_site` VALUES ('14', 'GEORGE ST', 'GEORGE ST', '1');
INSERT INTO `security_site` VALUES ('15', 'CHULLORA', 'CHULLORA', '1');
INSERT INTO `security_site` VALUES ('16', 'Foxports', 'Foxports', '1');
INSERT INTO `security_site` VALUES ('17', 'MCS_Talbot', 'MCS_Talbot', '1');
INSERT INTO `security_site` VALUES ('18', 'Bingara', 'Bingara', '1');
INSERT INTO `user` VALUES ('1', 'superadmin', 'superadmin', 'info@activationltd.com', '+61', 'activation', '1', '1', 'test', null, null, null, '1');
INSERT INTO `user` VALUES ('16', 'raihan', 'Raihan Sikder', 'raihan@activationltd.com', '+8801746638483', 'activation', '1', '3', '', null, '2012-06-06 00:46:29', '1', '0');
INSERT INTO `user` VALUES ('17', 'arefin', 'Shamsul Arefin', 'shamsularefin2005@yahoo.com', '+61468329026', 'smartsecurity', '1', '3', '', null, '2012-06-30 13:06:55', '1', '1');
INSERT INTO `user` VALUES ('18', 'vladk', 'Vlad Krouglov', 'vlad.krouglov@gmail.com', '+61468329026', 'smartsecurity', '1', '3', '', null, '2012-06-30 13:11:09', '1', '0');
INSERT INTO `user` VALUES ('19', 'bangura', 'Hassan Bangura', 'hassanbangura64@yahoo.com.au', '+61468329026', 'smartsecurity', '1', '3', '', null, '2012-06-30 13:12:53', '1', '0');
INSERT INTO `user` VALUES ('20', 'mallah', 'Hussain Mallah', 'hussain.mallah1@gmail.com', '+61468329026', 'smartsecurity', '1', '3', '', null, '2012-06-30 13:14:09', '1', '0');
INSERT INTO `user` VALUES ('21', 'lanas', 'Lana Serdyuk', 'krossantoss@hotmail.com', '+61425304932', 'smartsecurity', '1', '3', '', null, '2012-06-30 13:15:42', '1', '0');
INSERT INTO `user` VALUES ('22', 'waqar', 'Waqar', 'testemail@test.com', '+61468329026', 'smartsecurity', '1', '3', '', null, '2012-06-30 13:17:15', '1', '0');
INSERT INTO `user` VALUES ('23', 'tesshaz', 'Tes Shaz', 'tesshaz@gmail.com', '+61425304932', 'tesadmin', '1', '3', '', null, '2012-06-30 13:19:25', '1', '1');
INSERT INTO `user` VALUES ('24', 'raheel', 'Raheel Baig', 'raheelbaig1980@hotmail.com', '+61410717007', 'smartsecurity', '1', '3', '', null, '2012-06-30 13:20:28', '1', '0');
INSERT INTO `user` VALUES ('25', 'lovely', 'LOVELY MUZAMIL', 'lovely_muzamil@yahoo.com', '+61406142732', 'smartsecurity', '1', '3', '', null, '2012-06-30 13:21:22', '1', '0');
INSERT INTO `user` VALUES ('26', 'mashr', 'Mashuqur Rahman', 'mashuqur.rahman@yahoo.com.au', '+0433438668', 'smartsecurity', '1', '3', '', null, '2012-06-30 13:22:34', '1', '0');
INSERT INTO `user` VALUES ('27', 'kinaani', 'Ahmad Kinaani', 'ahmadkinaani@yahoo.com.au', '+61434432686', 'smartsecurity', '1', '3', '', null, '2012-06-30 13:23:24', '1', '0');
INSERT INTO `user` VALUES ('28', 'iqbal', 'Safwan Sattar', 'rohan1962@live.com.au', '+61432558413', 'smartsecurity', '1', '3', '', null, '2012-06-30 13:24:25', '1', '0');
INSERT INTO `user` VALUES ('29', 'limon', 'Md mahmudul Hasan', 'mhlimon01@gmail.com', '+61430216070', 'smartsecurity', '1', '3', '', null, '2012-06-30 13:25:07', '1', '0');
INSERT INTO `user` VALUES ('30', 'symon', 'Symon', 'symon.au@gmail.com', '+61433472035', 'smartsecurity', '1', '3', '', null, '2012-06-30 13:25:46', '1', '0');
INSERT INTO `user` VALUES ('31', 'lotus', 'Lotus Raju', 'rajunath_0066@yahoo.com', '+61424799288', 'smartsecurity', '1', '3', '', null, '2012-06-30 13:28:33', '1', '0');
INSERT INTO `user` VALUES ('32', 'benESP', 'Ben', 'ben@testemail.com', '+61', 'smartsecurity', '1', '2', '', null, '2012-06-30 13:42:56', '1', '0');
INSERT INTO `user` VALUES ('33', 'ScottESP', 'Scott', 'scott@testemail.com', '+61', 'smartsecurity', '1', '2', '', null, '2012-06-30 13:44:12', '1', '0');
INSERT INTO `user` VALUES ('34', 'PhilAscham', 'Phil', 'tesshaz1@gmail.com', 'Irin', 'anik1234', '1', '2', 'Irin', null, '2012-07-30 06:14:45', '1', '0');
INSERT INTO `user` VALUES ('35', 'DebiSaha', 'Debi Saha', 'tesshaz2@gmail.com', '61425304932', 'anik1234', '1', '3', '+61425304932', null, '2012-07-30 06:23:44', '1', '0');
INSERT INTO `user` VALUES ('36', 'SalmanAzmi', 'SalmanAzmi', 'tesshaz4@gmail.com', '610000', 'anik1234', '1', '3', 'the', null, '2012-07-30 06:30:44', '1', '0');
INSERT INTO `user` VALUES ('37', 'ria123', 'ria saha', 'tesriya@gmail.com', '61425304932', 'ria12345', '1', '3', 'ria brother 01212121, ria home 2122121', null, '2012-08-06 00:04:02', '1', '0');
INSERT INTO `user` VALUES ('38', 'riya123', 'CRMI', 'tesops@gmail.com', '+91 9836780780', 'riya12345', '1', '2', '+91 9126060690', null, '2012-08-06 01:35:55', '1', '0');
INSERT INTO `user` VALUES ('39', 'CRMICHULLORA', 'CRMI CHULLORA', 'tesshaz444@gmail.com', '61425304932', 'sabad123', '1', '2', 'DSSD', null, '2012-08-06 02:05:12', '1', '0');
INSERT INTO `user` VALUES ('40', 'CrmiHoltSt', 'CrmiHoltSt', 'tesshazrrr4@gmail.com', '61425304932', 'sabad123', '1', '2', '', null, '2012-08-06 02:06:27', '1', '0');
INSERT INTO `user` VALUES ('41', 'Prateek123', 'Prateek kumar', 'apurbaananda@gmail.com', '+91 9126060690', 'prateek123', '1', '3', 'Guard Purpose', null, '2012-08-08 01:02:50', '1', '0');
INSERT INTO `user` VALUES ('42', 'Luke123', 'Luke Robinson', 'shivam.vir25@gmail.com', '8100976165', 'luke12345', '1', '3', 'guard purpose', null, '2012-08-08 01:07:18', '1', '0');
INSERT INTO `user` VALUES ('43', 'Erol123', 'Erol Ozden', 'shivam.vir@ymail.com', '9874915960', 'erol12345', '1', '3', 'guard purpose', null, '2012-08-08 01:21:20', '1', '0');
INSERT INTO `user` VALUES ('44', 'Muzammil123', 'Muzammil Hussain', 'riya.dola@gmail.com', '+91 8296272931', 'muzammil123', '1', '3', 'guard purpose', null, '2012-08-08 01:23:57', '1', '0');
INSERT INTO `user` VALUES ('45', 'Angela123', 'Angela Andromedas', 'tulighosal@gmail.com', '9593346914', 'angela123', '1', '3', 'Guard purpose', null, '2012-08-08 01:25:45', '1', '0');
INSERT INTO `user` VALUES ('46', 'omer1234', 'Riya', 'apurba@travelersclubbd.com', '8981273418', 'omer12345', '1', '3', 'apurba@travelersclubbd.com', null, '2012-08-16 06:10:02', '1', '0');
INSERT INTO `user` VALUES ('47', 'atomar', 'Ahmed Talal Omar', 'ahmedtalalomar@yahoo.com.au', '123', 'atomar123', '1', '3', '', null, '2012-10-15 06:25:24', '1', '0');
INSERT INTO `user` VALUES ('48', 'arslan', 'Arslan Khan', 'arslan_15april@yahoo.com', '1234', 'arslan123', '1', '3', '', null, '2012-10-15 06:26:55', '1', '0');
INSERT INTO `user` VALUES ('49', 'tbdguard', '[TBD]', 'no-reply@smartsecurity.activationltd.com', '123456', '12345678', '1', '3', '', null, '2012-10-15 06:28:41', '1', '0');
INSERT INTO `user_type` VALUES ('1', 'Super admin', '1', '2012-06-04 18:11:40', '0', '1');
INSERT INTO `user_type` VALUES ('2', 'Contact/Requester', '1', '2012-07-11 14:57:59', '1', '1');
INSERT INTO `user_type` VALUES ('3', 'Guard', '1', '2012-06-30 15:30:46', '1', '1');
INSERT INTO `user_type` VALUES ('4', 'Admin', '1', '2012-06-30 17:16:35', '1', '1');

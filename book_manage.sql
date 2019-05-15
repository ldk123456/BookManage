/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80015
 Source Host           : localhost:3306
 Source Schema         : book_manage

 Target Server Type    : MySQL
 Target Server Version : 80015
 File Encoding         : 65001

 Date: 15/05/2019 10:45:52
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `book_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '名字',
  `card` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '编号',
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '上传者',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '上传时间',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '类型',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '存储路径',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `book_ibfk_1`(`type`(4)) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES (1, '法律法规1', '9787111213825', 'Admin1', '2019-05-11', '法律法规', 'D:\\IdeaProjects\\javaweb\\BookManage\\out\\artifacts\\BookManage\\WEB-INF\\upload\\law1.txt');
INSERT INTO `book` VALUES (2, '书籍1', '9787121269394', 'Admin1', '2019-05-11', '书籍', 'D:\\IdeaProjects\\javaweb\\BookManage\\out\\artifacts\\BookManage\\WEB-INF\\upload\\book1.txt');
INSERT INTO `book` VALUES (3, '书籍2', '9787111213825', 'Admin1', '2019-05-11', '书籍', 'D:\\IdeaProjects\\javaweb\\BookManage\\out\\artifacts\\BookManage\\WEB-INF\\upload\\book2.txt');
INSERT INTO `book` VALUES (4, '行业文档1', '9787121269394', 'Admin1', '2019-05-11', '行业文档', 'D:\\IdeaProjects\\javaweb\\BookManage\\out\\artifacts\\BookManage\\WEB-INF\\upload\\doc1.txt');
INSERT INTO `book` VALUES (5, '行业文档2', '9787121269394', 'Admin1', '2019-05-11', '行业文档', 'D:\\IdeaProjects\\javaweb\\BookManage\\out\\artifacts\\BookManage\\WEB-INF\\upload\\doc2.txt');
INSERT INTO `book` VALUES (6, '行业文档3', '9787121269394', 'Admin1', '2019-05-11', '行业文档', 'D:\\IdeaProjects\\javaweb\\BookManage\\out\\artifacts\\BookManage\\WEB-INF\\upload\\doc3.txt');
INSERT INTO `book` VALUES (7, '法律法规2', '9787121269394', 'Admin1', '2019-05-11', '法律法规', 'D:\\IdeaProjects\\javaweb\\BookManage\\out\\artifacts\\BookManage\\WEB-INF\\upload\\law2.txt');
INSERT INTO `book` VALUES (8, '法律法规3', '9787121269394', 'Admin1', '2019-05-11', '法律法规', 'D:\\IdeaProjects\\javaweb\\BookManage\\out\\artifacts\\BookManage\\WEB-INF\\upload\\law3.txt');
INSERT INTO `book` VALUES (9, '法律法规4', '9787121269394', 'Admin1', '2019-05-11', '法律法规', 'D:\\IdeaProjects\\javaweb\\BookManage\\out\\artifacts\\BookManage\\WEB-INF\\upload\\law4.txt');
INSERT INTO `book` VALUES (10, '法律法规5', '9787111213825', 'Admin1', '2019-05-11', '法律法规', 'D:\\IdeaProjects\\javaweb\\BookManage\\out\\artifacts\\BookManage\\WEB-INF\\upload\\law5.txt');

-- ----------------------------
-- Table structure for type
-- ----------------------------
DROP TABLE IF EXISTS `type`;
CREATE TABLE `type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of type
-- ----------------------------
INSERT INTO `type` VALUES (1, '书籍');
INSERT INTO `type` VALUES (2, '行业文档');
INSERT INTO `type` VALUES (3, '法律法规');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(225) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `admin_name` varchar(225) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `user_name` varchar(225) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `password` varchar(225) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `phone` varchar(225) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `admin_name`(`admin_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '管理员', '0001', 'Admin1', 'admin1', '123456789');
INSERT INTO `user` VALUES (2, '普通用户', '0002', '用户1', '123456', '123456789');
INSERT INTO `user` VALUES (7, '普通用户', '0003', '用户3', '123456', '18392564569');
INSERT INTO `user` VALUES (9, '管理员', '0005', 'Admin2', 'admin2', '18392023214');
INSERT INTO `user` VALUES (10, '普通用户', '0004', '用户2', '123456', '18392587123');

SET FOREIGN_KEY_CHECKS = 1;

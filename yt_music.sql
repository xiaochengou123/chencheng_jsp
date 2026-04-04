/*
 Navicat Premium Dump SQL

 Source Server         : localhost_Conn
 Source Server Type    : MySQL
 Source Server Version : 80042 (8.0.42)
 Source Host           : localhost:3306
 Source Schema         : yt_music

 Target Server Type    : MySQL
 Target Server Version : 80042 (8.0.42)
 File Encoding         : 65001

 Date: 04/04/2026 18:05:13
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for aianswer
-- ----------------------------
DROP TABLE IF EXISTS `aianswer`;
CREATE TABLE `aianswer`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'AI回答ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '内容',
  `user_id` int NOT NULL COMMENT '用户ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `aianswer_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of aianswer
-- ----------------------------

-- ----------------------------
-- Table structure for issue
-- ----------------------------
DROP TABLE IF EXISTS `issue`;
CREATE TABLE `issue`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '发行记录ID',
  `singer_id` int NOT NULL COMMENT '歌手ID',
  `song_id` int NOT NULL COMMENT '歌曲ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `singer_id`(`singer_id` ASC) USING BTREE,
  INDEX `song_id`(`song_id` ASC) USING BTREE,
  CONSTRAINT `issue_ibfk_1` FOREIGN KEY (`singer_id`) REFERENCES `singer` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `issue_ibfk_2` FOREIGN KEY (`song_id`) REFERENCES `song` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 79 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of issue
-- ----------------------------
INSERT INTO `issue` VALUES (53, 1, 1);
INSERT INTO `issue` VALUES (54, 1, 2);
INSERT INTO `issue` VALUES (55, 2, 3);
INSERT INTO `issue` VALUES (56, 2, 4);
INSERT INTO `issue` VALUES (57, 3, 5);
INSERT INTO `issue` VALUES (58, 4, 6);
INSERT INTO `issue` VALUES (59, 5, 7);
INSERT INTO `issue` VALUES (60, 5, 8);
INSERT INTO `issue` VALUES (61, 6, 9);
INSERT INTO `issue` VALUES (62, 6, 10);
INSERT INTO `issue` VALUES (63, 7, 11);
INSERT INTO `issue` VALUES (64, 8, 12);
INSERT INTO `issue` VALUES (65, 8, 13);
INSERT INTO `issue` VALUES (66, 9, 14);
INSERT INTO `issue` VALUES (67, 9, 15);
INSERT INTO `issue` VALUES (68, 10, 16);
INSERT INTO `issue` VALUES (69, 10, 17);
INSERT INTO `issue` VALUES (70, 11, 18);
INSERT INTO `issue` VALUES (71, 11, 19);
INSERT INTO `issue` VALUES (72, 12, 20);
INSERT INTO `issue` VALUES (73, 13, 21);
INSERT INTO `issue` VALUES (74, 13, 22);
INSERT INTO `issue` VALUES (75, 14, 23);
INSERT INTO `issue` VALUES (76, 14, 24);
INSERT INTO `issue` VALUES (77, 15, 25);
INSERT INTO `issue` VALUES (78, 15, 26);

-- ----------------------------
-- Table structure for mylike
-- ----------------------------
DROP TABLE IF EXISTS `mylike`;
CREATE TABLE `mylike`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '喜欢记录ID',
  `user_id` int NOT NULL COMMENT '用户ID',
  `type` int NULL DEFAULT NULL COMMENT '类型(1:歌曲, 2:歌单)',
  `target_id` int NOT NULL COMMENT '目标ID(歌曲或歌单ID)',
  `createtime` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `mylike_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mylike
-- ----------------------------

-- ----------------------------
-- Table structure for singer
-- ----------------------------
DROP TABLE IF EXISTS `singer`;
CREATE TABLE `singer`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '歌手ID',
  `singerName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '歌手名称',
  `type` int NULL DEFAULT NULL COMMENT '类型(1:男歌手,2:女歌手,3:组合/乐队)',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `nationality` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '国籍',
  `resume` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '简历',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像',
  `createtime` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updatetime` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of singer
-- ----------------------------
INSERT INTO `singer` VALUES (1, '周杰伦', 1, '1979-01-18', '中国', '华语流行乐男歌手、音乐人、演员，代表作《七里香》《青花瓷》等', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/945c3c06-77fd-41b0-b84c-64e807cc6922.jpg', '2026-01-12 09:18:32', '2026-01-12 18:13:06');
INSERT INTO `singer` VALUES (2, '邓紫棋', 2, '1991-08-16', '中国', '华语流行乐女歌手、词曲作者，代表作《泡沫》《光年之外》等', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/2594c1ea-91e0-4542-9aec-8a5f710c951f.jpg', '2026-01-12 09:18:32', '2026-01-12 18:13:08');
INSERT INTO `singer` VALUES (3, 'S.H.E', 3, NULL, '中国', '华语女子演唱组合，由任家萱、田馥甄、陈嘉桦组成，代表作《Super Star》', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/672b45f9-3f63-40fd-8d6d-0d31426dddf8.jpg', '2026-01-12 09:18:32', '2026-01-12 18:13:10');
INSERT INTO `singer` VALUES (4, 'TFBOYS', 3, NULL, '中国', '华语男子演唱组合，由王俊凯、王源、易烊千玺组成，代表作《青春修炼手册》', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/a30e4954-f899-4711-9519-c0a67ececb3e.jpg', '2026-01-12 09:18:32', '2026-01-12 18:13:12');
INSERT INTO `singer` VALUES (5, '孙姿燕', 2, '1978-07-23', '新加坡', '华语流行乐女歌手，代表作《天黑黑》《开始懂了》等', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/ff5f20fd-bb75-407d-8c04-bc9b08bf53fc.jpg', '2026-01-12 09:18:32', '2026-01-12 09:18:32');
INSERT INTO `singer` VALUES (6, '陈奕迅', 1, '1974-07-27', '中国', '华语流行乐男歌手、演员，代表作《K歌之王》《浮夸》等', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/f0349c78-8a43-4003-831a-d734f60de805.jpg', '2026-01-12 09:18:32', '2026-01-12 18:13:15');
INSERT INTO `singer` VALUES (7, '五月天', 3, NULL, '中国', '华语摇滚乐队，由阿信、怪兽、玛莎、石头、冠佑组成，代表作《倔强》', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/cd7a2b10-0e39-48a5-b722-4ff8bf6b25ac.jpg', '2026-01-12 09:18:32', '2026-01-12 18:13:17');
INSERT INTO `singer` VALUES (8, '苏打绿', 3, NULL, '中国', '华语摇滚乐队，由吴青峰等组成，代表作《小情歌》《我好想你》等', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/9115285d-5d27-484f-b6e3-f9187074e7ff.jpg', '2026-01-12 09:18:32', '2026-01-12 18:13:19');
INSERT INTO `singer` VALUES (9, '薛之谦', 1, '1983-07-17', '中国', '华语流行乐男歌手，词曲作者，音乐制作人，代表作：认真的雪，演员，绅士', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/995c16ce-6b5e-428f-9ea6-25977df90832.jpg', '2026-01-12 09:18:32', '2026-01-12 18:13:21');
INSERT INTO `singer` VALUES (10, '林俊杰', 1, '1981-03-27', '新加坡', '华语流行乐男歌手、音乐人、影视演员、潮牌主理人，代表作：江南，修炼爱情，曹操', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/ee341412-b016-45c2-b3f7-6c135385f98a.jpg', '2026-01-12 09:18:32', '2026-01-12 09:18:32');
INSERT INTO `singer` VALUES (11, '张杰', 1, '1982-12-20', '中国', '中国流行男歌手、音乐制作人，代表作：他不懂，天下，逆战，少年中国说，明天过后……', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/57df71a4-f685-45ee-b75b-d208f42fc5d6.jpg', '2026-01-12 09:18:32', '2026-01-12 18:13:23');
INSERT INTO `singer` VALUES (12, '尚雯婕', 2, '1982-12-22', '中国', '华语流行乐女歌手、词曲作者，代表作：鹿befree，越爱越明白，小星星，最终信仰，阿修罗，候鸟，当你想起我，23秒32年，信以为真，一大片天空，待我长发及腰，木兰诗，Love warrior战，被偷走的爱', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/9318b9c1-3824-4310-8c7e-209599f9b810.jpg', '2026-01-12 09:18:32', '2026-01-12 18:13:25');
INSERT INTO `singer` VALUES (13, '汪苏泷', 1, '1989-09-17', '中国', '中国内地唱作男歌手、音乐人，代表作：不分手的恋爱，万有引力，一笑倾城，巴赫旧约，小星星，雾都孤儿，全世界陪我失眠，有点甜，风度，桃花扇，后会无期，银河，晴，三国杀，苦笑，大娱乐家，耿，剑魂，年轮，就让这大雨全都落下', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/9a6350ab-10b9-426a-a6b4-594eb3112a6a.jpg', '2026-01-12 09:18:32', '2026-01-12 18:13:30');
INSERT INTO `singer` VALUES (14, '周深', 1, '1992-09-29', '中国', '中国内地男歌手、音乐制作人、青年歌唱家，代表作：大鱼，灯火里的中国，小美满，花开忘忧，人是_,若梦，借过一下，Rubia,我的答案，有我，光亮，亲爱的旅人啊，化身孤岛的鲸，和光同尘，梅香如故，望，少管我，云裳羽衣曲，浮光，璀璨冒险人', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/1d037384-a017-470f-86dc-e86d104691b6.jpg', '2026-01-12 09:18:32', '2026-01-12 18:13:32');
INSERT INTO `singer` VALUES (15, '凤凰传奇', 3, NULL, '中国', '中国内地流行乐演唱组合，由杨魏玲花、曾毅组成。代表作：最炫民族风，月亮之上，自由飞翔，荷塘月色，奢香夫人，郎的诱惑，全是爱，我从草原来，大声唱，天蓝蓝，山河图，等爱的玫瑰，最好的时代，自由自在，开门大吉，绿旋风，中国味道，我们的歌谣，拜新年，吉祥如意', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/3950d859-d66c-479c-a3cf-84c78bacc453.jpg', '2026-01-12 09:18:32', '2026-01-12 18:13:34');

-- ----------------------------
-- Table structure for song
-- ----------------------------
DROP TABLE IF EXISTS `song`;
CREATE TABLE `song`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '歌曲ID',
  `songName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '歌名',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '时长(秒)',
  `album` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '专辑',
  `releaseDate` date NULL DEFAULT NULL COMMENT '发行日期',
  `songCover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '歌曲封面',
  `songFile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '歌曲文件路径',
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of song
-- ----------------------------
INSERT INTO `song` VALUES (1, '七里香', '4:59', '七里香', '2004-08-03', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/image/png%E5%9B%BE%E7%89%87/%E4%B8%83%E9%87%8C%E9%A6%99.png', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/atuo/%E6%AD%8C%E6%9B%B2/%E4%B8%83%E9%87%8C%E9%A6%99%20%282%29.mp3', '流行');
INSERT INTO `song` VALUES (2, '青花瓷', '3:59', '我很忙', '2007-11-02', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/image/png%E5%9B%BE%E7%89%87/%E9%9D%92%E8%8A%B1%E7%93%B7.png', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/atuo/%E6%AD%8C%E6%9B%B2/%E9%9D%92%E8%8A%B1%E7%93%B7.mp3', '中国风');
INSERT INTO `song` VALUES (3, '泡沫', '4:18', 'Xposed', '2012-07-05', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/image/png%E5%9B%BE%E7%89%87/%E6%B3%A1%E6%B2%AB.png', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/atuo/%E6%AD%8C%E6%9B%B2/%E6%B3%A1%E6%B2%AB_%E9%82%93%E7%B4%AB%E6%A3%8B.mp3', '流行');
INSERT INTO `song` VALUES (4, '光年之外', '3:55', '单曲', '2016-12-30', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/image/png%E5%9B%BE%E7%89%87/%E5%85%89%E5%B9%B4%E4%B9%8B%E5%A4%96.png', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/atuo/%E6%AD%8C%E6%9B%B2/%E5%85%89%E5%B9%B4%E4%B9%8B%E5%A4%96.mp3', '流行');
INSERT INTO `song` VALUES (5, 'Super Star', '3:16', 'Super Star', '2003-08-22', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/image/png%E5%9B%BE%E7%89%87/Super%20Star.png', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/atuo/%E6%AD%8C%E6%9B%B2/Super%20Star.mp3', '流行');
INSERT INTO `song` VALUES (6, '青春修炼手册', '4:23', '青春修炼手册', '2014-07-24', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/image/png%E5%9B%BE%E7%89%87/%E9%9D%92%E6%98%A5%E4%BF%AE%E7%82%BC%E6%89%8B%E5%86%8C%27.png', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/atuo/%E6%AD%8C%E6%9B%B2/%E9%9D%92%E6%98%A5%E4%BF%AE%E7%82%BC%E6%89%8B%E5%86%8C.mp3', '流行');
INSERT INTO `song` VALUES (7, '天黑黑', '3:56', '孙燕姿同名专辑', '2000-06-09', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/image/png%E5%9B%BE%E7%89%87/%E5%A4%A9%E9%BB%91%E9%BB%91.png', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/atuo/%E6%AD%8C%E6%9B%B2/%E5%A4%A9%E9%BB%91%E9%BB%91.mp3', '流行');
INSERT INTO `song` VALUES (8, '开始懂了', '4:31', '我要的幸福', '2000-12-07', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/image/png%E5%9B%BE%E7%89%87/%E5%BC%80%E5%A7%8B%E6%87%82%E4%BA%86.png', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/atuo/%E6%AD%8C%E6%9B%B2/%E5%BC%80%E5%A7%8B%E6%87%82%E4%BA%86.mp3', '流行');
INSERT INTO `song` VALUES (9, 'K歌之王', '3:42', 'The Easy Ride', '2002-07-24', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/image/png%E5%9B%BE%E7%89%87/K%E6%AD%8C%E4%B9%8B%E7%8E%8B.png', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/atuo/%E6%AD%8C%E6%9B%B2/K%E6%AD%8C%E4%B9%8B%E7%8E%8B.mp3', '流行');
INSERT INTO `song` VALUES (10, '浮夸', '4:43', 'U87', '2005-06-07', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/image/png%E5%9B%BE%E7%89%87/%E6%B5%AE%E5%A4%B8.png', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/atuo/%E6%AD%8C%E6%9B%B2/%E6%B5%AE%E5%A4%B8.mp3', '流行');
INSERT INTO `song` VALUES (11, '倔强', '4:21', '神的孩子都在跳舞', '2004-11-05', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/image/png%E5%9B%BE%E7%89%87/%E5%80%94%E5%BC%BA.png', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/atuo/%E6%AD%8C%E6%9B%B2/%E5%80%94%E5%BC%BA.mp3', '摇滚');
INSERT INTO `song` VALUES (12, '小情歌', '4:33', '小宇宙', '2006-10-20', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/image/png%E5%9B%BE%E7%89%87/%E5%B0%8F%E6%83%85%E6%AD%8C.png', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/atuo/%E6%AD%8C%E6%9B%B2/%E5%B0%8F%E6%83%85%E6%AD%8C.mp3', '独立摇滚');
INSERT INTO `song` VALUES (13, '我好想你', '5:29', '秋：故事', '2013-09-18', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/image/png%E5%9B%BE%E7%89%87/%E6%88%91%E5%A5%BD%E6%83%B3%E4%BD%A0.png', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/atuo/%E6%AD%8C%E6%9B%B2/%E6%88%91%E5%A5%BD%E6%83%B3%E4%BD%A0.mp3', '流行');
INSERT INTO `song` VALUES (14, '演员', '4:21', '绅士', '2015-05-20', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/image/png%E5%9B%BE%E7%89%87/%E6%BC%94%E5%91%98.png', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/atuo/%E6%AD%8C%E6%9B%B2/%E6%BC%94%E5%91%98.mp3', '流行');
INSERT INTO `song` VALUES (15, '绅士', '4:50', '绅士', '2015-05-20', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/image/png%E5%9B%BE%E7%89%87/%E7%BB%85%E5%A3%AB.png', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/atuo/%E6%AD%8C%E6%9B%B2/%E7%BB%85%E5%A3%AB.mp3', '流行');
INSERT INTO `song` VALUES (16, '江南', '4:27', '第二天堂', '2004-06-04', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/image/png%E5%9B%BE%E7%89%87/%E6%B1%9F%E5%8D%97.png', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/atuo/%E6%AD%8C%E6%9B%B2/%E6%B1%9F%E5%8D%97.mp3', '流行');
INSERT INTO `song` VALUES (17, '修炼爱情', '4:47', '因你而在', '2013-03-13', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/image/png%E5%9B%BE%E7%89%87/%E4%BF%AE%E7%82%BC%E7%88%B1%E6%83%85.png', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/atuo/%E6%AD%8C%E6%9B%B2/%E4%BF%AE%E7%82%BC%E7%88%B1%E6%83%85.mp3', '流行');
INSERT INTO `song` VALUES (18, '他不懂', '3:51', 'One Chance', '2012-08-01', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/image/png%E5%9B%BE%E7%89%87/%E4%BB%96%E4%B8%8D%E6%87%82.png', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/atuo/%E6%AD%8C%E6%9B%B2/%E4%BB%96%E4%B8%8D%E6%87%82.mp3', '流行');
INSERT INTO `song` VALUES (19, '逆战', '3:44', '单曲', '2012-04-09', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/image/png%E5%9B%BE%E7%89%87/%E9%80%86%E6%88%98.png', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/atuo/%E6%AD%8C%E6%9B%B2/%E9%80%86%E6%88%98.mp3', '流行');
INSERT INTO `song` VALUES (20, '鹿 Be Free', '3:43', 'Black & White', '2013-10-21', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/image/png%E5%9B%BE%E7%89%87/%E9%B9%BF%20Be%20Free.png', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/atuo/%E6%AD%8C%E6%9B%B2/%E9%B9%BF%20Be%20Free.mp3', '电子流行');
INSERT INTO `song` VALUES (21, '一笑倾城', '3:51', '登陆计划', '2016-08-15', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/image/png%E5%9B%BE%E7%89%87/%E4%B8%80%E7%AC%91%E5%80%BE%E5%9F%8E.png', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/atuo/%E6%AD%8C%E6%9B%B2/%E4%B8%80%E7%AC%91%E5%80%BE%E5%9F%8E.mp3', '流行');
INSERT INTO `song` VALUES (22, '有点甜', '3:55', '万有引力', '2012-07-16', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/image/png%E5%9B%BE%E7%89%87/%E6%9C%89%E7%82%B9%E7%94%9C.png', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/atuo/%E6%AD%8C%E6%9B%B2/%E6%9C%89%E7%82%B9%E7%94%9C.mp3', '流行');
INSERT INTO `song` VALUES (23, '大鱼', '5:13', '大鱼', '2016-05-20', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/image/png%E5%9B%BE%E7%89%87/%E5%A4%A7%E9%B1%BC.png', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/atuo/%E6%AD%8C%E6%9B%B2/%E5%A4%A7%E9%B1%BC.mp3', '影视原声');
INSERT INTO `song` VALUES (24, '小美满', '3:34', '小美满', '2024-02-06', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/image/png%E5%9B%BE%E7%89%87/%E5%B0%8F%E7%BE%8E%E6%BB%A1.png', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/atuo/%E6%AD%8C%E6%9B%B2/%E5%B0%8F%E7%BE%8E%E6%BB%A1.mp3', '流行');
INSERT INTO `song` VALUES (25, '最炫民族风', '4:44', '最炫民族风', '2009-05-27', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/image/png%E5%9B%BE%E7%89%87/%E6%9C%80%E7%82%AB%E6%B0%91%E6%97%8F%E9%A3%8E.png', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/atuo/%E6%AD%8C%E6%9B%B2/%E6%9C%80%E7%82%AB%E6%B0%91%E6%97%8F%E9%A3%8E.mp3', '民族流行');
INSERT INTO `song` VALUES (26, '月亮之上', '3:55', '月亮之上', '2005-04-01', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/image/png%E5%9B%BE%E7%89%87/%E6%9C%88%E4%BA%AE%E4%B9%8B%E4%B8%8A.png', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/atuo/%E6%AD%8C%E6%9B%B2/%E6%9C%88%E4%BA%AE%E4%B9%8B%E4%B8%8A.mp3', '民族流行');

-- ----------------------------
-- Table structure for songlist
-- ----------------------------
DROP TABLE IF EXISTS `songlist`;
CREATE TABLE `songlist`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '歌曲列表ID',
  `user_id` int NOT NULL COMMENT '用户ID',
  `song_id` int NOT NULL COMMENT '歌曲ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  INDEX `song_id`(`song_id` ASC) USING BTREE,
  CONSTRAINT `songlist_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `songlist_ibfk_2` FOREIGN KEY (`song_id`) REFERENCES `song` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of songlist
-- ----------------------------

-- ----------------------------
-- Table structure for songsheet
-- ----------------------------
DROP TABLE IF EXISTS `songsheet`;
CREATE TABLE `songsheet`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '歌单ID',
  `song_sheet_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '歌单名称',
  `song_sheet_resume` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '歌单简介',
  `song_sheet_avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '歌单封面',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of songsheet
-- ----------------------------
INSERT INTO `songsheet` VALUES (1, '抖音热歌 | 火爆全网超好听', '火爆全网 听感满分！', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/img/%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE%202026-01-04%20190201.png');
INSERT INTO `songsheet` VALUES (2, '抖音热歌：火爆全网 听感满分！', '国语热歌精选', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/img/%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE%202026-01-04%20190220.png');
INSERT INTO `songsheet` VALUES (3, '电量1%也要听！每一首都好听出圈', '伤感神曲合集', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/img/%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE%202026-01-04%20190234.png');
INSERT INTO `songsheet` VALUES (4, '抖音热歌丨潮流旋律感觉至上', '流行风格精选', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/img/%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE%202026-01-04%20190252.png');
INSERT INTO `songsheet` VALUES (5, '车载DJ热歌：轻松一路Fun肆嗨！', 'DJ舞曲提神必备', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/img/%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE%202026-01-04%20190301.png');
INSERT INTO `songsheet` VALUES (6, '抖音热播单曲收录（持续更新）', '热门单曲持续更新', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/img/%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE%202026-01-04%20190310.png');
INSERT INTO `songsheet` VALUES (7, '抖音伤感 : 你是我熬不过的苦', '深夜emo伤感情歌', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/img/%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE%202026-01-04%20190324.png');
INSERT INTO `songsheet` VALUES (8, '车内劲爆舞曲·快意疾驰引擎共鸣', '高速驾驶必备BGM', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/img/%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE%202026-01-04%20190333.png');
INSERT INTO `songsheet` VALUES (9, '劲嗨炸街舞曲！竞速驰骋混响轰炸', '街头炸场DJ神曲', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/img/%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE%202026-01-04%20190344.png');
INSERT INTO `songsheet` VALUES (10, 'DJ歌曲｜音响一开，烦恼不来', '释放压力的DJ节奏', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/img/%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE%202026-01-04%20190350.png');
INSERT INTO `songsheet` VALUES (11, '车载DJ丨提神醒脑，困意全无', '长途驾驶提神专用', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/img/%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE%202026-01-04%20190400.png');
INSERT INTO `songsheet` VALUES (12, '假日车载DJ，一路欢歌回家', '节日返程欢乐歌单', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/img/%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE%202026-01-04%20190426.png');
INSERT INTO `songsheet` VALUES (13, '一秒就落泪！深夜emo天花板情歌', '催泪情歌天花板', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/img/%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE%202026-01-04%20190434.png');
INSERT INTO `songsheet` VALUES (14, '一听就落泪！哪首是emo天花板', '经典伤感情歌合集', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/img/%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE%202026-01-04%20190500.png');
INSERT INTO `songsheet` VALUES (15, '伤感DJ系：遗忘是最好的解脱', '伤感+DJ融合曲风', 'https://music-09.oss-cn-beijing.aliyuncs.com/mian/img/%E5%BE%AE%E4%BF%A1%E5%9B%BE%E7%89%87_20260104165257_149_5.png');

-- ----------------------------
-- Table structure for songsheetsong
-- ----------------------------
DROP TABLE IF EXISTS `songsheetsong`;
CREATE TABLE `songsheetsong`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '歌单歌曲ID',
  `song_id` int NOT NULL COMMENT '歌曲ID',
  `song_sheet_id` int NOT NULL COMMENT '歌单ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `song_id`(`song_id` ASC) USING BTREE,
  INDEX `song_sheet_id`(`song_sheet_id` ASC) USING BTREE,
  CONSTRAINT `songsheetsong_ibfk_1` FOREIGN KEY (`song_id`) REFERENCES `song` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `songsheetsong_ibfk_2` FOREIGN KEY (`song_sheet_id`) REFERENCES `songsheet` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of songsheetsong
-- ----------------------------
INSERT INTO `songsheetsong` VALUES (1, 3, 1);
INSERT INTO `songsheetsong` VALUES (2, 24, 1);
INSERT INTO `songsheetsong` VALUES (3, 4, 2);
INSERT INTO `songsheetsong` VALUES (4, 22, 2);
INSERT INTO `songsheetsong` VALUES (5, 14, 3);
INSERT INTO `songsheetsong` VALUES (6, 13, 3);
INSERT INTO `songsheetsong` VALUES (7, 1, 4);
INSERT INTO `songsheetsong` VALUES (8, 16, 4);
INSERT INTO `songsheetsong` VALUES (9, 25, 5);
INSERT INTO `songsheetsong` VALUES (10, 26, 5);
INSERT INTO `songsheetsong` VALUES (11, 21, 6);
INSERT INTO `songsheetsong` VALUES (12, 19, 6);
INSERT INTO `songsheetsong` VALUES (13, 8, 7);
INSERT INTO `songsheetsong` VALUES (14, 15, 7);
INSERT INTO `songsheetsong` VALUES (15, 19, 8);
INSERT INTO `songsheetsong` VALUES (16, 11, 8);
INSERT INTO `songsheetsong` VALUES (17, 20, 9);
INSERT INTO `songsheetsong` VALUES (18, 5, 9);
INSERT INTO `songsheetsong` VALUES (19, 25, 10);
INSERT INTO `songsheetsong` VALUES (20, 6, 10);
INSERT INTO `songsheetsong` VALUES (21, 18, 11);
INSERT INTO `songsheetsong` VALUES (22, 10, 11);
INSERT INTO `songsheetsong` VALUES (23, 7, 12);
INSERT INTO `songsheetsong` VALUES (24, 23, 12);
INSERT INTO `songsheetsong` VALUES (25, 14, 13);
INSERT INTO `songsheetsong` VALUES (26, 17, 13);
INSERT INTO `songsheetsong` VALUES (27, 12, 14);
INSERT INTO `songsheetsong` VALUES (28, 8, 14);
INSERT INTO `songsheetsong` VALUES (29, 15, 15);
INSERT INTO `songsheetsong` VALUES (30, 9, 15);

-- ----------------------------
-- Table structure for songsheettype
-- ----------------------------
DROP TABLE IF EXISTS `songsheettype`;
CREATE TABLE `songsheettype`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '歌单类型ID',
  `song_sheet_id` int NOT NULL COMMENT '歌单ID',
  `type` int NULL DEFAULT NULL COMMENT '类别',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `song_sheet_id`(`song_sheet_id` ASC) USING BTREE,
  CONSTRAINT `songsheettype_ibfk_1` FOREIGN KEY (`song_sheet_id`) REFERENCES `songsheet` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of songsheettype
-- ----------------------------
INSERT INTO `songsheettype` VALUES (1, 1, 1);
INSERT INTO `songsheettype` VALUES (2, 2, 1);
INSERT INTO `songsheettype` VALUES (3, 3, 2);
INSERT INTO `songsheettype` VALUES (4, 4, 1);
INSERT INTO `songsheettype` VALUES (5, 5, 3);
INSERT INTO `songsheettype` VALUES (6, 6, 1);
INSERT INTO `songsheettype` VALUES (7, 7, 2);
INSERT INTO `songsheettype` VALUES (8, 8, 3);
INSERT INTO `songsheettype` VALUES (9, 9, 3);
INSERT INTO `songsheettype` VALUES (10, 10, 3);
INSERT INTO `songsheettype` VALUES (11, 11, 3);
INSERT INTO `songsheettype` VALUES (12, 12, 3);
INSERT INTO `songsheettype` VALUES (13, 13, 2);
INSERT INTO `songsheettype` VALUES (14, 14, 2);
INSERT INTO `songsheettype` VALUES (15, 15, 2);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户密码',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '昵称',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '邮箱',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像',
  `resume` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '简历',
  `createtime` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updatetime` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `Key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '加密的字母',
  `Position` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '加密的位置',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'root', '0E1A1003C2CA36EF18113192806E6744', '一听', 'yt_123456789@qq.com', '1', '这个人很懒', '2026-01-12 17:56:57', '2026-04-03 17:48:27', 'p', '0');

SET FOREIGN_KEY_CHECKS = 1;

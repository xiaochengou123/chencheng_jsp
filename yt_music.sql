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

 Date: 15/01/2026 10:31:29
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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

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
INSERT INTO `mylike` VALUES (1, 1, 1, 1, '2026-01-12 18:00:24');
INSERT INTO `mylike` VALUES (3, 1, 2, 2, '2026-01-13 10:32:27');
INSERT INTO `mylike` VALUES (4, 1, 1, 2, '2026-01-14 08:48:13');
INSERT INTO `mylike` VALUES (5, 1, 2, 1, '2026-01-14 08:50:12');
INSERT INTO `mylike` VALUES (6, 23, 1, 1, '2026-01-15 09:33:16');
INSERT INTO `mylike` VALUES (7, 25, 1, 3, '2026-01-15 09:39:56');
INSERT INTO `mylike` VALUES (8, 25, 2, 1, '2026-01-15 09:39:58');
INSERT INTO `mylike` VALUES (9, 25, 1, 1, '2026-01-15 09:40:44');

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
INSERT INTO `song` VALUES (1, '七里香', '4:59', '七里香', '2004-08-03', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/be6ac1ed-c852-4400-87e6-5bdd12f5724d.png', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/audio/2026_1/audio.worthsee.com/%E5%91%A8%E6%9D%B0%E4%BC%A6%20-%20%E4%B8%83%E9%87%8C%E9%A6%99_kgg-dec.mp3', '流行');
INSERT INTO `song` VALUES (2, '青花瓷', '3:59', '我很忙', '2007-11-02', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/12d167d1-0208-4e0d-83a9-53a0a89c2a09.png', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/audio/2026_1/audio.worthsee.com/%E5%91%A8%E6%9D%B0%E4%BC%A6%20-%20%E9%9D%92%E8%8A%B1%E7%93%B7_kgg-dec.mp3', '中国风');
INSERT INTO `song` VALUES (3, '泡沫', '4:18', 'Xposed', '2012-07-05', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/1ff17d02-63c9-4246-9138-7029f7504c3a.png', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/audio/2026_1/audio.worthsee.com/G.E.M.%20%E9%82%93%E7%B4%AB%E6%A3%8B%20-%20%E6%B3%A1%E6%B2%AB.mp3', '流行');
INSERT INTO `song` VALUES (4, '光年之外', '3:55', '单曲', '2016-12-30', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/cda0fece-a15e-4f7c-ac31-9c1e55d3b497.png', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/audio/2026_1/audio.worthsee.com/G.E.M.%20%E9%82%93%E7%B4%AB%E6%A3%8B%20-%20%E5%85%89%E5%B9%B4%E4%B9%8B%E5%A4%96.mp3', '流行');
INSERT INTO `song` VALUES (5, 'Super Star', '3:16', 'Super Star', '2003-08-22', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/e6665bf3-856d-461a-928b-b99bfd797f96.png', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/audio/2026_1/audio.worthsee.com/S.H.E%20-%20Super%20Star_kgg-dec.mp3', '流行');
INSERT INTO `song` VALUES (6, '青春修炼手册', '4:23', '青春修炼手册', '2014-07-24', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/3e43ed6a-6160-4a75-b44e-ffb8397e4287.png', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/audio/2026_1/audio.worthsee.com/TFBOYS%20-%20%E9%9D%92%E6%98%A5%E4%BF%AE%E7%82%BC%E6%89%8B%E5%86%8C_kgg-dec.mp3', '流行');
INSERT INTO `song` VALUES (7, '天黑黑', '3:56', '孙燕姿同名专辑', '2000-06-09', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/dc66ff92-a0d7-4c47-ae07-e92deadf7640.png', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/audio/2026_1/audio.worthsee.com/%E5%AD%99%E7%87%95%E5%A7%BF%20-%20%E5%A4%A9%E9%BB%91%E9%BB%91_kgg-dec.mp3', '流行');
INSERT INTO `song` VALUES (8, '开始懂了', '4:31', '我要的幸福', '2000-12-07', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/69d1c52c-4f0c-45ef-900f-2b22419a731a.png', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/audio/2026_1/audio.worthsee.com/%E5%AD%99%E7%87%95%E5%A7%BF%20-%20%E5%BC%80%E5%A7%8B%E6%87%82%E4%BA%86_kgg-dec.mp3', '流行');
INSERT INTO `song` VALUES (9, 'K歌之王', '3:42', 'The Easy Ride', '2002-07-24', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/63c58842-f652-41db-aa47-b5059a755742.png', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/audio/2026_1/audio.worthsee.com/%E9%99%88%E5%A5%95%E8%BF%85%20-%20K%E6%AD%8C%E4%B9%8B%E7%8E%8B%20%28%E6%99%AE%E9%80%9A%E8%AF%9D%E7%89%88%29_kgg-dec.mp3', '流行');
INSERT INTO `song` VALUES (10, '浮夸', '4:43', 'U87', '2005-06-07', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/77257c05-b1b9-4771-ab35-6a3511e7249d.png', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/audio/2026_1/audio.worthsee.com/%E9%99%88%E5%A5%95%E8%BF%85%20-%20%E6%B5%AE%E5%A4%B8_kgg-dec.mp3', '流行');
INSERT INTO `song` VALUES (11, '倔强', '4:21', '神的孩子都在跳舞', '2004-11-05', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/d7b09a9d-5b8a-41e8-bdba-5cc8e242eef7.png', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/audio/2026_1/audio.worthsee.com/%E4%BA%94%E6%9C%88%E5%A4%A9%20-%20%E5%80%94%E5%BC%BA_kgg-dec.mp3', '摇滚');
INSERT INTO `song` VALUES (12, '小情歌', '4:33', '小宇宙', '2006-10-20', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/f3c560d4-1a76-4487-9131-9863b9ab5e95.png', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/audio/2026_1/audio.worthsee.com/%E8%8B%8F%E6%89%93%E7%BB%BF%20-%20%E5%B0%8F%E6%83%85%E6%AD%8C.mp3', '独立摇滚');
INSERT INTO `song` VALUES (13, '我好想你', '5:29', '秋：故事', '2013-09-18', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/8d1b4391-67f8-4054-9870-fcb5e2f75435.png', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/audio/2026_1/audio.worthsee.com/%E8%8B%8F%E6%89%93%E7%BB%BF%20-%20%E6%88%91%E5%A5%BD%E6%83%B3%E4%BD%A0%20%28%E8%8B%8F%E6%89%93%E7%BB%BF%E7%89%88%29.mp3', '流行');
INSERT INTO `song` VALUES (14, '演员', '4:21', '绅士', '2015-05-20', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/fcd6e0bf-612f-4395-983d-08e0ad3d40df.png', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/audio/2026_1/audio.worthsee.com/%E8%96%9B%E4%B9%8B%E8%B0%A6%20-%20%E6%BC%94%E5%91%98.mp3', '流行');
INSERT INTO `song` VALUES (15, '绅士', '4:50', '绅士', '2015-05-20', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/d7dc86d6-636e-4673-b684-7e311b5627fb.png', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/audio/2026_1/audio.worthsee.com/%E8%96%9B%E4%B9%8B%E8%B0%A6%20-%20%E7%BB%85%E5%A3%AB_kgg-dec.mp3', '流行');
INSERT INTO `song` VALUES (16, '江南', '4:27', '第二天堂', '2004-06-04', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/5b0ff358-5953-4c0c-9059-e7a0cff2a694.png', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/audio/2026_1/audio.worthsee.com/%E6%9E%97%E4%BF%8A%E6%9D%B0%20-%20%E6%B1%9F%E5%8D%97_kgg-dec.mp3', '流行');
INSERT INTO `song` VALUES (17, '修炼爱情', '4:47', '因你而在', '2013-03-13', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/fde57563-b5e5-4099-b2c3-02220bdcd552.png', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/audio/2026_1/audio.worthsee.com/%E6%9E%97%E4%BF%8A%E6%9D%B0%20-%20%E4%BF%AE%E7%82%BC%E7%88%B1%E6%83%85_kgg-dec.mp3', '流行');
INSERT INTO `song` VALUES (18, '他不懂', '3:51', 'One Chance', '2012-08-01', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/4b9bc77f-f94b-4756-9afd-14371772badb.png', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/audio/2026_1/audio.worthsee.com/%E5%BC%A0%E6%9D%B0%20-%20%E4%BB%96%E4%B8%8D%E6%87%82.mp3', '流行');
INSERT INTO `song` VALUES (19, '逆战', '3:44', '单曲', '2012-04-09', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/18dfb0e8-e1b8-44a7-8596-945ff6351fc4.png', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/audio/2026/%E6%AD%8C%E6%9B%B2/%E9%80%86%E6%88%98.mp3', '流行');
INSERT INTO `song` VALUES (20, '鹿 Be Free', '3:43', 'Black & White', '2013-10-21', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/f78a4080-5290-44dc-9c62-0f148a0afa31.png', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/audio/2026_1/audio.worthsee.com/%E5%B0%9A%E9%9B%AF%E5%A9%95%20-%20%E9%B9%BF%20be%20free.mp3', '电子流行');
INSERT INTO `song` VALUES (21, '一笑倾城', '3:51', '登陆计划', '2016-08-15', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/84d113dd-c0ce-45d0-a582-35100ec70537.png', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/audio/2026_1/audio.worthsee.com/%E6%B1%AA%E8%8B%8F%E6%B3%B7%20-%20%E4%B8%80%E7%AC%91%E5%80%BE%E5%9F%8E_kgg-dec.mp3', '流行');
INSERT INTO `song` VALUES (22, '有点甜', '3:55', '万有引力', '2012-07-16', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/46006e1d-bcfc-464c-b629-5f3d9441bdba.png', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/audio/2026/%E6%AD%8C%E6%9B%B2/%E6%9C%89%E7%82%B9%E7%94%9C.mp3', '流行');
INSERT INTO `song` VALUES (23, '大鱼', '5:13', '大鱼', '2016-05-20', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/d3470552-3196-48d5-90bc-5ca8d9c7a58c.png', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/audio/2026_1/audio.worthsee.com/%E5%91%A8%E6%B7%B1%20-%20%E5%A4%A7%E9%B1%BC_kgg-dec.mp3', '影视原声');
INSERT INTO `song` VALUES (24, '小美满', '3:34', '小美满', '2024-02-06', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/7fb3d977-8c34-41ac-9299-a1615d3a81b1.png', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/audio/2026_1/audio.worthsee.com/%E5%91%A8%E6%B7%B1%20-%20%E5%B0%8F%E7%BE%8E%E6%BB%A1.mp3', '流行');
INSERT INTO `song` VALUES (25, '最炫民族风', '4:44', '最炫民族风', '2009-05-27', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/fc9b9163-f0da-4edb-bb3d-2ead874fd38b.png', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/audio/2026_1/audio.worthsee.com/%E5%87%A4%E5%87%B0%E4%BC%A0%E5%A5%87%20-%20%E6%9C%80%E7%82%AB%E6%B0%91%E6%97%8F%E9%A3%8E%281%29_kgg-dec.mp3', '民族流行');
INSERT INTO `song` VALUES (26, '月亮之上', '3:55', '月亮之上', '2005-04-01', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/d3e4f978-e4eb-4029-90b0-3d29427afaf7.png', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/audio/2026_1/audio.worthsee.com/%E5%87%A4%E5%87%B0%E4%BC%A0%E5%A5%87%20-%20%E6%9C%88%E4%BA%AE%E4%B9%8B%E4%B8%8A_kgg-dec.mp3', '民族流行');

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
INSERT INTO `songsheet` VALUES (1, '抖音热歌 | 火爆全网超好听', '火爆全网 听感满分！', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/bce34b7c-5b40-4466-861a-4cf22c6e6ee1.png');
INSERT INTO `songsheet` VALUES (2, '抖音热歌：火爆全网 听感满分！', '国语热歌精选', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/1cbbc043-e335-44f5-9bf6-f178287709ff.png');
INSERT INTO `songsheet` VALUES (3, '电量1%也要听！每一首都好听出圈', '伤感神曲合集', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/1370f50a-5ee9-43c6-8092-3c44ca549bd6.png');
INSERT INTO `songsheet` VALUES (4, '抖音热歌丨潮流旋律感觉至上', '流行风格精选', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/3044f984-4547-4210-8028-d88393d9ae82.png');
INSERT INTO `songsheet` VALUES (5, '车载DJ热歌：轻松一路Fun肆嗨！', 'DJ舞曲提神必备', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/f61a9d41-5fb3-4d14-b9bf-5d7440962ee3.png');
INSERT INTO `songsheet` VALUES (6, '抖音热播单曲收录（持续更新）', '热门单曲持续更新', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/a9ce3180-3f2a-43a0-9985-4ea792cda9cc.png');
INSERT INTO `songsheet` VALUES (7, '抖音伤感 : 你是我熬不过的苦', '深夜emo伤感情歌', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/f09af8ac-9fb5-4636-b8f4-f942da187a4b.png');
INSERT INTO `songsheet` VALUES (8, '车内劲爆舞曲·快意疾驰引擎共鸣', '高速驾驶必备BGM', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/6a4fa6ed-d76f-4cbb-b7ea-918fc48669f2.png');
INSERT INTO `songsheet` VALUES (9, '劲嗨炸街舞曲！竞速驰骋混响轰炸', '街头炸场DJ神曲', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/93a0534b-f10d-4138-b88b-776edf4858d4.png');
INSERT INTO `songsheet` VALUES (10, 'DJ歌曲｜音响一开，烦恼不来', '释放压力的DJ节奏', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/53087b5e-5b13-4b34-9f25-41b0c278c033.png');
INSERT INTO `songsheet` VALUES (11, '车载DJ丨提神醒脑，困意全无', '长途驾驶提神专用', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/8261f79a-c4f8-4f03-b753-419d2801ebf5.png');
INSERT INTO `songsheet` VALUES (12, '假日车载DJ，一路欢歌回家', '节日返程欢乐歌单', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/d209f26f-742b-46e0-80d0-a60db2dacf6b.png');
INSERT INTO `songsheet` VALUES (13, '一秒就落泪！深夜emo天花板情歌', '催泪情歌天花板', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/cbe400b9-375c-4a15-9acf-e6c060a3b8f9.png');
INSERT INTO `songsheet` VALUES (14, '一听就落泪！哪首是emo天花板', '经典伤感情歌合集', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/73a27cfb-c87b-4f38-8f24-add0231f3d47.png');
INSERT INTO `songsheet` VALUES (15, '伤感DJ系：遗忘是最好的解脱', '伤感+DJ融合曲风', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/a9454690-9aad-4dc5-98fb-0f7de0c0fa6a.png');

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
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'OOO', '923a846b4d104cc81db80871e84f6a5f', 'WWW', '205614780@qq.com', '1', '这个人很懒', '2026-01-12 17:56:57', '2026-01-12 17:56:57', 's', '0');
INSERT INTO `user` VALUES (2, 'EEE', '4bdf8859c3ebc307c1aacf56f99e1311', 'EEE', '3588172935@qq.com', '1', '这个人很懒', '2026-01-12 19:13:37', '2026-01-12 19:13:37', 'h', '2');
INSERT INTO `user` VALUES (4, 'WWW', '0bb7ec0bb37661e844bb046abe202466', 'WWW', '3588172935@qq.com', '1', '这个人很懒', '2026-01-12 19:23:38', '2026-01-12 19:23:38', 'r', '2');
INSERT INTO `user` VALUES (6, 'III', '85780f4128e3c4d03cfab25e53dd1502', '一听', '205614780@qq.com', '1', '这个人很懒', '2026-01-13 14:15:17', '2026-01-13 22:16:06', 'a', '4');
INSERT INTO `user` VALUES (7, 'TEST1', 'd4743b6ab72f17efad97f445f4bbbe55', '111', '205614780@qq.com', '1', '这个人很懒', '2026-01-13 14:21:43', '2026-01-13 22:16:11', 'j', '0');
INSERT INTO `user` VALUES (8, 'TEXT2', '1288ef21276888012f8d756df9e735ed', 'SSS', '205614780@qq.com', '1', '这个人很懒', '2026-01-13 14:24:18', '2026-01-13 14:24:18', 'n', '2');
INSERT INTO `user` VALUES (9, 'TTT', '7734b47686848f62268fd07b1f106734', '一听', '3588172935@qq.com', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/im…/2026/01/1370f50a-5ee9-43c6-8092-3c44ca549bd6.png', '这个人很懒', '2026-01-13 22:25:29', '2026-01-13 22:25:29', 'u', '1');
INSERT INTO `user` VALUES (10, 'TTTT', '48066d3f5c727d2c3384562bb8ec18db', '一听', '3588172935@qq.com', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/im…/2026/01/1370f50a-5ee9-43c6-8092-3c44ca549bd6.png', '这个人很懒', '2026-01-13 22:31:46', '2026-01-13 22:31:46', 'w', '4');
INSERT INTO `user` VALUES (14, 'TTTTT', 'b57bef5a2bc275610dc2a453f007f389', '一听', '3588172935@qq.com', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/im…/2026/01/1370f50a-5ee9-43c6-8092-3c44ca549bd6.png', '这个人很懒', '2026-01-13 22:37:02', '2026-01-13 22:37:02', 'p', '4');
INSERT INTO `user` VALUES (15, 'test9', '750c6cbb338427a3829395c896b95f3f', '急急急', '3588172935@qq.com', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/im…/2026/01/1370f50a-5ee9-43c6-8092-3c44ca549bd6.png', '这个人很懒', '2026-01-13 22:40:03', '2026-01-13 22:40:03', 'o', '0');
INSERT INTO `user` VALUES (16, 'T11', '5e5d61a837b291fc0905ff8a86e0ddcb', '急急急', '3588172935@qq.com', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/1370f50a-5ee9-43c6-8092-3c44ca549bd6.png', '这个人很懒', '2026-01-13 22:42:29', '2026-01-13 22:48:41', 'w', '2');
INSERT INTO `user` VALUES (23, 'T12', '6e6306c58840a67891f20eccbc2417b5', 'WWW', '205614780@qq.com', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/1370f50a-5ee9-43c6-8092-3c44ca549bd6.png', '这个人很懒', '2026-01-15 09:32:51', '2026-01-15 09:32:51', 'k', '0');
INSERT INTO `user` VALUES (25, 'test3', 'b0d562da6a885ee5a6ea2af16934ba6a', 'wwww', '3588172935@qq.com', 'https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/1370f50a-5ee9-43c6-8092-3c44ca549bd6.png', '这个人很懒', '2026-01-15 09:39:21', '2026-01-15 09:39:21', 'w', '0');

SET FOREIGN_KEY_CHECKS = 1;

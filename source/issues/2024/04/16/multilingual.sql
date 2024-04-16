/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80032
 Source Host           : localhost:3306
 Source Schema         : multilingual

 Target Server Type    : MySQL
 Target Server Version : 80032
 File Encoding         : 65001

 Date: 16/04/2024 10:47:31
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tb_multilingual_term
-- ----------------------------
DROP TABLE IF EXISTS `tb_multilingual_term`;
CREATE TABLE `tb_multilingual_term`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `domain_id` int NOT NULL COMMENT '词条域ID',
  `term` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '词条名称',
  `term_key` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '词条key',
  `language` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '0' COMMENT 'zh-CN中文简体 en-US英文',
  `gmt_created` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `IDX_DOMAIN_ID`(`domain_id`) USING BTREE,
  INDEX `IDX_LANGUAGE`(`language`) USING BTREE,
  INDEX `IDX_TERM_KEY`(`term_key`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 144 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_multilingual_term
-- ----------------------------
INSERT INTO `tb_multilingual_term` VALUES (1, 1, 'Basic examinations', '基础检查', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (2, 1, 'Gynecological examination', '妇科检查', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (3, 1, 'Biochemical tests', '生化类检查', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (4, 1, 'Imaging tests', '影像类检查', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (5, 1, 'Electrocardiogram', '心电图', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (6, 1, 'Others', '其他', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (7, 2, 'Cardiovascular Tests', '心脑血管类检查', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (8, 2, 'Tumor Marker Tests', '肿瘤标志物检查', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (9, 2, 'Radiological Examinations', '放射类检查', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (10, 2, 'Female disease examination', '女性疾病检查', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (11, 2, 'Examination of gastric and digestive tract diseases', '胃部、消化道疾病检查', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (12, 2, 'Thyroid function tests', '甲状腺功能检查', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (13, 2, 'Other tests', '其他类型检查', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (14, 3, 'General Check-ups', '一般检查', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (15, 3, 'Surgical Check-ups', '外科检查', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (16, 3, 'Internal Medicine Check-ups', '内科检查', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (17, 3, 'Eye and ENT Check-ups', '五官科检查', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (18, 3, 'Gynecological examination', '妇科检查', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (19, 3, 'Urine Routine', '尿常规', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (20, 3, 'Liver Function Tests', '肝功十一项', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (21, 3, 'Kidney Profile', '肾功三项', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (22, 3, 'Blood Sugar Related Tests', '血糖相关检查', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (23, 3, 'The Fecal Occult Blood Test (FOBT)', '消化道检查', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (24, 3, 'Lipid Profile（Cholesterol, Triglycerides, HDL Cholesterol, LDL Cholesterol）', '血脂四项', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (25, 3, 'Carotid ultrasound', '颈动脉彩超', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (26, 3, 'Abdominal Examination', '腹部检查', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (27, 3, 'Chest X-Ray (PA)', '胸部正位', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (28, 3, 'Cervical spine (lateral view)', '颈椎侧位', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (29, 3, 'Prostate Examination', '前列腺检查', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (30, 3, 'Examination of Uterus and Adnexa', '子宫、附件检查', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (31, 3, 'Mammography', '乳腺检查', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (32, 3, 'Electrocardiogram', '心电图', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (33, 3, 'Breakfast', '早餐', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (34, 3, 'Individual Inspection Report', '个检报告', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (35, 3, 'Homocysteine', '同型半胱氨酸', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (36, 3, 'Hyper-sensitive C-reactive protein (HS-CRP)', '超敏C反应蛋白(HS-CRP）', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (37, 3, 'Transcranial doppler (TCD) ultrasound', '经颅多普勒', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (38, 3, 'Cardiovascular Genes', '心脑血管基因', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (39, 3, 'Ultrasound of the heart', '心脏彩超', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (40, 3, 'Carcinoembryonic antigen （CEA) quantification', '癌胚抗原定量', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (41, 3, 'Cancer antigen 125 (CA125)', '癌抗原125(CA125）', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (42, 3, 'Cancer antigen 15-3 (CA15-3)', '癌抗原15-3 (CA15-3）', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (43, 3, 'Prostate tumor marker combinations', '前列腺肿瘤标记物组合', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (44, 3, 'Tumor Genes', '肿瘤基因', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (45, 3, 'EB virus test', 'EB病毒检查', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (46, 3, 'Lumbar spine (lateral view) & (AP/PA view)', '腰椎正侧位', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (47, 3, 'Bone Density', '骨密度', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (48, 3, 'Low-dose spiral CT of the chest', '胸部低剂量螺旋CT', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (49, 3, 'Human papilloma virus typing (HPV typing)', '人乳头瘤病毒分型（HPV分型）', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (50, 3, 'Hormone blood tests \nProgesterone,Estradiol,luteinizing hormone,Follicle Stimulating Hormone,Testosterone', '性激素5项', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (51, 3, 'BRCA1、BRCA2', 'BRCA基因', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (52, 3, 'Pepsinogen II (I and II)', '胃蛋白酶原二项(Ⅰ及Ⅱ)', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (53, 3, 'Check the status of H. pylori infection, which is closely associated with the development of gastric inflammation,peptic ulcers, and gastric cancer.', '幽门螺旋杆菌呼气试验', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (54, 3, 'Thyroid function tests', '甲功五项', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (55, 3, 'Blood Type', '血型', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (56, 3, 'Hepatitis B Blood Tests(HBsAg, HBsAb, HBeAg, HBeAb and HBcAb)', '乙肝五项定量测定', 'en-US', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term` VALUES (57, 3, 'Internal Medicine Check-ups', '内科', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (58, 3, 'Surgical Check-ups', '外科', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (59, 3, 'Vision Screening and Eye Exams', '眼科', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (60, 3, 'Gynaecological Examination (gynaecologist exam + TCT)', '妇科检查（妇科+宫颈TCT）', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (61, 3, 'Complete Blood Count (CBC)', '血常规‎', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (62, 3, 'Liver Function Tests(ALT+AST+DBil+ TBil)', '肝功四项', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (63, 3, 'Fasting Blood Glucose (FBG)', '空腹血糖(FBG）', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (64, 3, 'AFB', '甲胎蛋白', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (65, 3, 'CEA', '癌胚抗原', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (66, 3, '(CA15-3)', '癌抗原15-3', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (67, 3, '(CA125)', '癌抗原125', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (68, 3, '(T-PSA）', '总前列腺特异性抗原', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (69, 3, 'Abdominal Ultrasound(liver, gallbladder, pancreas, spleen, both kidneys)', '腹部彩超（肝、胆、胰、脾、双肾）', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (70, 3, 'Thyroid Ultrasound', '甲状腺彩超', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (71, 3, 'Prostate Ultrasound', '前列腺彩超', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (72, 3, 'Color Doppler Ultrasound', '乳腺彩超', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (73, 3, 'Ultrasound of Uterus and Adnexa', '子宫、附件彩超', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (74, 3, 'Chest X-Ray (PA)', '胸部正位胸部正位', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (75, 4, 'Personalized Package - Male', '个性化套餐-男', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (76, 4, 'Personalized Package - Female (without gynecology）', '个性化套餐-女（无妇科）', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (77, 4, 'Personalized package - female (with gynecology)', '个性化套餐-女（含妇科)', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (78, 4, 'Youth Standard Package - Male', '青年标准套餐-男', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (79, 4, 'Youth Standard Package - Female (without gynecological examination)', '青年标准套餐-女（无妇科检查)', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (80, 4, 'Youth Standard Package - Female (with gynecological examination)', '青年标准套餐-女（含妇科检查)', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (81, 6, 'People with no history of specific diseases', '无特殊疾病史人群', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (82, 6, 'Basic health check-up', '标签2：基础体检', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (83, 5, 'Cardiovascular (blood) Tests', '心脑血管（血液）', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (84, 5, 'Cardiovascular (imaging tests )', '心脑血管（影像）', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (85, 5, 'Cardiovascular Genetic Screening', '心脑血管基因检查', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (86, 5, 'Cardiacmorphology Examination', '心脏形态检查', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (87, 5, 'Tumor Marker Test (female)', '肿瘤标记物检查（女）', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (88, 5, 'Tumor Marker Test (male)', '肿瘤标记物检查（男）', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (89, 5, 'Genetic Testing for Tumor', '肿瘤基因检查', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (90, 5, 'Nasopharyngeal Cancer', '鼻咽癌', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (91, 5, 'Radiological Examinations', '放射类检查', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (92, 5, 'Bone Density Screening', '骨密度检查', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (93, 5, 'Chest CT Examination', '胸部CT检查', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (94, 5, 'HPV Screening For Women', '女性HPV病毒检查', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (95, 5, 'Female Endocrine', '女性内分泌', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (96, 5, 'BRCA Genetic Testing', 'BRCA基因检测', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (97, 5, 'Stomach Tumor Markers', '胃部肿瘤标志物', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (98, 5, 'H.pylori screening', '幽门螺旋杆菌检查', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (99, 5, 'Thyroid Examination', '甲状腺检查', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (100, 5, 'ABO typing', 'ABO血型', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (101, 5, 'Hepatitis B Virus Test', '乙肝病毒检查', 'en-US', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term` VALUES (102, 7, 'ikang Zhuoyue Beijing Zhongguancun Founder Building branch', '爱康卓悦北京中关村方正大厦分院', 'en-US', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term` VALUES (103, 7, 'ikang Guobin Beijing Asian Games Village Huizhong Beili Branch VIP Department', '爱康国宾北京亚运村慧忠北里分院VIP部', 'en-US', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term` VALUES (104, 7, 'ikang Guobin Beijing Xishimen Branch VIP Department', '爱康国宾北京西直门分院VIP部', 'en-US', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term` VALUES (105, 7, 'ikang Guobin Shanghai Pudong Babaiban Branch VIP Department', '爱康国宾上海浦东八佰伴分院VIP部', 'en-US', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term` VALUES (106, 7, 'ikang Guobin Shanghai Lujiazui Branch VIP Department', '爱康国宾上海陆家嘴分院VIP部', 'en-US', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term` VALUES (107, 7, 'ikang Guobin Shanghai Wujiaochang Wanda Plaza Branch VIP Department', '爱康国宾上海五角场万达广场分院VIP部', 'en-US', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term` VALUES (108, 7, 'ikang Guobin Shenzhen Futian Branch VIP Department', '爱康国宾深圳福田分院VIP部', 'en-US', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term` VALUES (109, 7, 'ikang Guobin Shenzhen Kexing Branch VIP Department', '爱康国宾深圳科兴分院VIP部', 'en-US', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term` VALUES (110, 7, 'ikang Zhuoyue Shenzhen Chegongmiao Hanggang Fuchun Building branch', '爱康卓悦深圳车公庙杭钢富春大厦分院', 'en-US', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term` VALUES (111, 7, 'ikang Zhuoyue Shenzhen Kuaiyanbao branch', '爱康卓悦深圳快验保分院', 'en-US', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term` VALUES (112, 7, 'iKang Guangzhou Huacheng Avenue Nantian Square Medical Examination Branch 3/F VIP Department', '爱康国宾广州花城大道南天广场分院三层VIP部', 'en-US', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term` VALUES (113, 7, 'ikang Zhuoyue Guangzhou Pazhou Poly Zhongyue branch', '爱康卓悦广州琶洲保利中悦分院', 'en-US', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term` VALUES (114, 7, 'iKang Guangzhou Huanshi East Branch 2/F VIP Department', '爱康国宾广州环市东分院二层VIP部', 'en-US', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term` VALUES (115, 7, 'ikang Guobin Hangzhou Qianjiang Century City Guangfu Center Branch VIP Department', '爱康国宾杭州钱江世纪城广孚中心分院VIP部', 'en-US', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term` VALUES (116, 7, 'ikang Guobin Hangzhou Wenhui Branch VIP Department', '爱康国宾杭州文晖分院VIP部', 'en-US', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term` VALUES (117, 7, 'ikang Zhuoyue Hangzhou Future Science and Technology City Branch', '爱康卓悦杭州未来科技城分院', 'en-US', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term` VALUES (118, 8, '4308498', '4308498', 'en-US', '2023-05-25 21:23:44', '2023-05-25 21:23:46');
INSERT INTO `tb_multilingual_term` VALUES (119, 8, '-99999', '-99999', 'en-US', '2023-11-01 16:20:27', '2023-11-01 16:23:57');
INSERT INTO `tb_multilingual_term` VALUES (120, 9, '摩飞折叠暖菜板MR8300', 'SHOP-637DEA40376A9', 'en-US', '2023-11-20 14:49:58', '2023-11-20 14:49:58');
INSERT INTO `tb_multilingual_term` VALUES (121, 9, '九阳332', 'SHOP-637DE7F0C9579', 'en-US', '2023-11-20 14:49:58', '2023-11-20 14:49:58');
INSERT INTO `tb_multilingual_term` VALUES (122, 9, 'sohome-泰迪珍藏暖手杯', 'SHOP-637DE643BB296', 'en-US', '2023-11-20 14:49:58', '2023-11-20 14:49:58');
INSERT INTO `tb_multilingual_term` VALUES (123, 9, '蔻露薇五月玫瑰香氛蒸汽发膜帽（40MLx3）', 'SHOP-637DE5AADF50A', 'en-US', '2023-11-20 14:49:58', '2023-11-20 14:49:58');
INSERT INTO `tb_multilingual_term` VALUES (124, 9, '鲜知瑞雪苹果青新脆苹果8枚礼盒装 大果85mm', 'SHOP-637DE53BA09F6', 'en-US', '2023-11-20 14:49:58', '2023-11-20 14:49:58');
INSERT INTO `tb_multilingual_term` VALUES (125, 9, '竹节杯350ml', 'SHOP-637DE420057A0', 'en-US', '2023-11-20 14:49:58', '2023-11-20 14:49:58');
INSERT INTO `tb_multilingual_term` VALUES (126, 10, '摩飞折叠暖菜板MR8300', 'SHOP-637DEA40376A9', 'en-US', '2023-11-20 17:27:20', '2023-11-20 17:27:20');
INSERT INTO `tb_multilingual_term` VALUES (127, 10, '九阳332', 'SHOP-637DE7F0C9579', 'en-US', '2023-11-20 17:27:20', '2023-11-20 17:27:20');
INSERT INTO `tb_multilingual_term` VALUES (128, 10, 'sohome-泰迪珍藏暖手杯', 'SHOP-637DE643BB296', 'en-US', '2023-11-20 17:27:20', '2023-11-20 17:27:20');
INSERT INTO `tb_multilingual_term` VALUES (129, 10, '蔻露薇五月玫瑰香氛蒸汽发膜帽（40MLx3）', 'SHOP-637DE5AADF50A', 'en-US', '2023-11-20 17:27:20', '2023-11-20 17:27:20');
INSERT INTO `tb_multilingual_term` VALUES (130, 10, '鲜知瑞雪苹果青新脆苹果8枚礼盒装 大果85mm', 'SHOP-637DE53BA09F6', 'en-US', '2023-11-20 17:27:20', '2023-11-20 17:27:20');
INSERT INTO `tb_multilingual_term` VALUES (131, 10, '竹节杯350ml', 'SHOP-637DE420057A0', 'en-US', '2023-11-20 17:27:20', '2023-11-20 17:27:20');
INSERT INTO `tb_multilingual_term` VALUES (132, 10, 's摩飞折叠暖菜板MR8300', 'SHOP-637DEA40376A9-0', 'en-US', '2023-11-20 17:33:50', '2023-11-20 17:33:50');
INSERT INTO `tb_multilingual_term` VALUES (133, 10, 's1九阳332', 'SHOP-637DE7F0C9579-1', 'en-US', '2023-11-20 17:33:50', '2023-11-20 17:33:50');
INSERT INTO `tb_multilingual_term` VALUES (134, 10, 'ssohome-泰迪珍藏暖手杯', 'SHOP-637DE643BB296-0', 'en-US', '2023-11-20 17:33:50', '2023-11-20 17:33:50');
INSERT INTO `tb_multilingual_term` VALUES (135, 10, 's蔻露薇五月玫瑰香氛蒸汽发膜帽（40MLx3）', 'SHOP-637DE5AADF50A-0', 'en-US', '2023-11-20 17:33:50', '2023-11-20 17:33:50');
INSERT INTO `tb_multilingual_term` VALUES (136, 10, 's鲜知瑞雪苹果青新脆苹果8枚礼盒装 大果85mm', 'SHOP-637DE53BA09F6-0', 'en-US', '2023-11-20 17:33:50', '2023-11-20 17:33:50');
INSERT INTO `tb_multilingual_term` VALUES (137, 10, 's竹节杯350ml', 'SHOP-637DE420057A0-0', 'en-US', '2023-11-20 17:33:51', '2023-11-20 17:33:51');
INSERT INTO `tb_multilingual_term` VALUES (138, 10, 's0九阳332', 'SHOP-637DE7F0C9579-0', 'en-US', '2023-11-24 14:49:46', '2023-11-24 14:49:46');
INSERT INTO `tb_multilingual_term` VALUES (139, 10, '实物商品测试三-有优惠', 'SHOP-62907AAE33472-0', 'en-US', '2023-11-24 17:18:43', '2023-11-24 17:18:43');
INSERT INTO `tb_multilingual_term` VALUES (140, 10, '测试商品1', 'SHOP-623C2AB6BCD44-0', 'en-US', '2023-12-04 14:47:16', '2023-12-04 14:47:16');
INSERT INTO `tb_multilingual_term` VALUES (141, 10, '京东E卡 100元面值 电子卡（测试）', 'SHOP-5F3B742188BF1-0', 'en-US', '2023-12-04 14:47:16', '2023-12-04 14:47:16');
INSERT INTO `tb_multilingual_term` VALUES (142, 10, '【京东超市】三只松鼠 肉干肉脯 零食即食海味鲜爽鱿鱼足片88g/袋', 'JD-2518083', 'en-US', '2023-12-04 14:47:16', '2023-12-04 14:47:16');
INSERT INTO `tb_multilingual_term` VALUES (143, 10, '秋冬袜子', 'SHOPNG-63759A4E6DBB8-0', 'en-US', '2023-12-05 14:05:13', '2023-12-05 14:05:13');

-- ----------------------------
-- Table structure for tb_multilingual_term_attribute
-- ----------------------------
DROP TABLE IF EXISTS `tb_multilingual_term_attribute`;
CREATE TABLE `tb_multilingual_term_attribute`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `term_id` int NOT NULL COMMENT '词条ID',
  `attribute` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '属性',
  `value` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '内容',
  `gmt_created` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `IDX_NAME`(`attribute`) USING BTREE,
  INDEX `IDX_TERM_ID`(`term_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 299 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_multilingual_term_attribute
-- ----------------------------
INSERT INTO `tb_multilingual_term_attribute` VALUES (1, 14, 'name', 'General Check-ups', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (2, 14, 'detail', 'By using the instruments to measure height, weight and blood pressure,we can scientifically determine whether the weight is standard and the blood pressure is normal,and provide an important basis for the diagnosis of the relevant departments.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (3, 14, 'description', 'Height,Weight,Blood Pressure,Body Mass Index, Waist circumference,etc.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (4, 15, 'name', 'Surgical Check-ups', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (5, 15, 'detail', 'Through physical examination,the basic condition of important organs such as skin,thyroid,breast (female),prostate (male),spine extremities,and external genitalia are examined to detect signs related to common surgical diseases or to initially exclude common surgical diseases.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (6, 15, 'description', 'Skin,Thyroid,Extremities, Spine,Anus,Prostate（male）,Breast（female）, etc.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (7, 16, 'name', 'Internal Medicine Check-ups', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (8, 16, 'detail', 'The basic condition of the vital organs such as the heart,lung,liver and spleen is examined by inspection,palpation, percussion,auscultation,to detect signs associated with common diseases or initially exclude common diseases.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (9, 16, 'description', 'Heart,Lungs,Abdomen,etc.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (10, 17, 'name', 'Eye and ENT Check-ups', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (11, 17, 'detail', 'With the relevant equipment,problems related to the eyes,ears,mouth,nose and throat are examined and initial screening for common diseases is carried out.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (12, 17, 'description', 'Outer Ear,Nose,Throat,Cral Cavity, External Eeye, Vision,Fundus,etc.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (13, 18, 'name', 'Gynecological examination', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (14, 18, 'detail', 'Finding related signs of common gynecological diseases or preliminarily rule out common gynecological diseases through gynecological palpation and instrumented examination methods.TCT is a more advanced screening method for cervical cancer and its precancerous lesions.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (15, 18, 'description', 'Routine gynecological examination,TCT', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (16, 19, 'name', 'Urine Routine', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (17, 19, 'detail', 'Urine Routine is used for localization and differential diagnosis and prognosis of urinary system diseases,such as diabetes mellitus and nephritis.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (18, 19, 'description', 'Urine sugar,urine ketone bodies,urine occult blood, etc.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (19, 20, 'name', 'Liver Function Tests', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (20, 20, 'detail', 'The indicators related to liver function and metabolism are measured by biochemical test methods to reflect the basic status of liver function.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (21, 20, 'description', 'Alanine transaminase (ALT), Aspartate transaminase (AST), Gamma-glutamyltransferase (GGT)，Three bilirubin (total bilirubin, direct bilirubin, indirect bilirubin),Serum proteins (total protein, albumin, globulin, albumin/globulin ratio), Alkaline phosphatase (ALP)', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (22, 21, 'name', 'Kidney Profile', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (23, 21, 'detail', 'For renal function evaluation,to determine the degree of renal impairment and to estimate prognosis.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (24, 21, 'description', 'Blood Urea Nitrogen, Creatinine,Uric Acid', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (25, 22, 'name', 'Blood Sugar Related Tests', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (26, 22, 'detail', 'Evaluating whether human glucose metabolism under fasting condition is normal and assessing whether fasting blood-glucose control is up to standard in diabetic patients.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (27, 22, 'description', 'Fasting blood sugar\nGlycated hemoglobin', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (28, 23, 'name', 'The Fecal Occult Blood Test (FOBT)', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (29, 23, 'detail', 'The hidden red blood cells or hemoglobin in the stool are examined to assist in determining the diseases causing gastrointestinal bleeding:acute and chronic gastritis, gastroduodenal ulcer,gastric cancer, intestinal cancer,etc.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (30, 23, 'description', 'Occult blood in stool', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (31, 24, 'name', 'Lipid Profile（Cholesterol, Triglycerides, HDL Cholesterol, LDL Cholesterol）', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (32, 24, 'detail', 'It provides insight into fat metabolism, which is an important indicator of cardiovascular disease and its prognosis.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (33, 24, 'description', 'Cholesterol,Triglycerides, HDL Cholesterol,LDL Cholesterol', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (34, 25, 'name', 'Carotid ultrasound', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (35, 25, 'detail', 'Using non-invasive examination methods through color ultrasound instruments, we detect carotid artery structure and atherosclerotic plaque morphology,extent,nature,and degree of arterial stenosis;early detection of arterial vascular lesions provides objective hemodynamic basis for effective prevention and reduction of the onset of cardiovascular and cerebrovascular diseases such as coronary heart disease and ischemic cerebrovascular disease.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (36, 25, 'description', 'Carotid artery', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (37, 26, 'name', 'Abdominal Examination', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (38, 26, 'detail', 'Abdominal ultrasound is mainly for routine examination of the liver,gallbladder, pancreas,spleen and kidneys,and can be used as a preliminary screening test;for example,fatty liver,kidney cysts,etc.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (39, 26, 'description', 'Ultrasound-abdomen', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (40, 27, 'name', 'Chest X-Ray (PA)', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (41, 27, 'detail', 'Examination of the heart,both lungs, mediastinum,diaphragm and pleura to determine the presence of inflammation and tumors.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (42, 27, 'description', 'Chest X-ray', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (43, 28, 'name', 'Cervical spine (lateral view)', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (44, 28, 'detail', 'X-rays are taken to check the vertebral body for congenital malformations,hyperplasia,degenerative changes,foraminal stenosis,and masses.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (45, 28, 'description', 'Cervical spine', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (46, 29, 'name', 'Prostate Examination', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (47, 29, 'detail', 'To observe the size,shape and structure of the prostate gland to determine if there are enlarged prostate,cysts,stones, malignant lesions,etc.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (48, 29, 'description', 'Prostate ultrasound', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (49, 30, 'name', 'Examination of Uterus and Adnexa', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (50, 30, 'detail', 'To observe the size, morphological structure and internal echogenicity of the uterus and adnexa (ovaries and fallopian tubes),to identify normal and abnormal,to understand the nature of the lesions and to discern the presence of malignant lesions for early management.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (51, 30, 'description', 'Pelvic Ultrasonography', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (52, 31, 'name', 'Mammography', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (53, 31, 'detail', 'Examination of the breast by color ultrasound instruments reveals lesions such as breast enlargement,masses, nodules,cysts,adenomas,and breast cancer.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (54, 31, 'description', 'Mammography ultrasound', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (55, 32, 'name', 'Electrocardiogram', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (56, 32, 'detail', 'Recording and analyzing the curvilinear figures of the changes in electrical activity generated by each cardiac cycle of the heart provides an important basis for the diagnosis,efficacy evaluation, and prognosis assessment of heart diseases.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (57, 32, 'description', 'ECG', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (58, 33, 'name', 'Breakfast', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (59, 33, 'detail', 'Nutritious Breakfast', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (60, 33, 'description', 'Nutritious Breakfast', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (61, 34, 'name', 'Individual Inspection Report', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (62, 34, 'detail', 'Individual Inspection Report', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (63, 34, 'description', 'Electronic Medical Examination Report', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (64, 35, 'name', 'Homocysteine', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (65, 35, 'detail', 'Homocysteine(Hcy),a sulfur-containing amino acid,is an important intermediate in the metabolism of methionine and is an independent risk factor for cardiovascular disease.High homocysteine indicates a predisposition to cerebral infarction,cerebral hemorrhage,coronary heart disease,atherosclerosis and other diseases.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (66, 36, 'name', 'Hyper-sensitive C-reactive protein (HS-CRP)', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (67, 36, 'detail', 'C-reactive protein is also a diagnostic indicator of bacterial infections and severe tissue damage,with elevations seen in tissue damage,bacterial infections,myocardial infarction,and connective tissue disease.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (68, 37, 'name', 'Transcranial doppler (TCD) ultrasound', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (69, 37, 'detail', 'Intracranial vascular detection by ultrasound means is non-invasive and painless;to understand the blood flow of intracranial and extracranial vessels,cerebral arterial ring vessels and their branches,and to determine the presence of vascular lesions such as sclerosis,stenosis, ischemia,malformation and spasm.It allows dynamic monitoring of cerebrovascular diseases.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (70, 38, 'name', 'Cardiovascular Genes', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (71, 38, 'detail', 'Risk of cardiovascular genetic predisposition for hypertension, coronary heart disease,atherosclerosis,cerebral infarction,cerebral hemorrhage,myocardial infarction,atrial fibrillation,hypertrophic cardiomyopathy,dilated cardiomyopathy,deep vein thrombosis, hypertension combined with left ventricular hypertrophy,ischemic stroke,etc.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (72, 39, 'name', 'Ultrasound of the heart', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (73, 39, 'detail', 'Ultrasound scanning technology is an non-invasive method to observe the cardiovascular structure,hemodynamic status and cardiac function.It provides an understanding of the morphology as well as the functional status of each component of the heart,the location and size of malformations within the heart,the relationship of the great vessels,and the condition and extent of other malformations.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (74, 40, 'name', 'Carcinoembryonic antigen （CEA) quantification', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (75, 40, 'detail', 'Broad-spectrum tumor markers, which are clinically important for screening, efficacy observation and prognosis assessment of colorectal and pancreatic cancers.It can also be elevated in gastric cancer, breast cancer and lung cancer.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (76, 41, 'name', 'Cancer antigen 125 (CA125)', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (77, 41, 'detail', 'Increased CA125 is seen in gynecological and gastrointestinal malignancies.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (78, 42, 'name', 'Cancer antigen 15-3 (CA15-3)', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (79, 42, 'detail', 'An increase in CA153 is seen in breast cancer disease.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (80, 43, 'name', 'Prostate tumor marker combinations', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (81, 43, 'detail', 'PSA is clinically important for the diagnosis,observation of efficacy, and prognosis evaluation of prostate cancer of males.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (82, 44, 'name', 'Tumor Genes', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (83, 44, 'detail', 'Tumor hereditary genetic disease risk test. (Male (10 types): esophageal cancer,lung cancer,nasopharyngeal cancer,stomach cancer, liver cancer,colon cancer,thyroid cancer,bladder cancer,lymphoma, prostate cancer + P53 oncogene / Female (13 types):esophageal cancer, lung cancer,nasopharyngeal cancer,stomach cancer,liver cancer,colon cancer,thyroid cancer,bladder cancer,lymphoma,breast cancer,cervical cancer,ovarian cancer,endometrial cancer + P53 oncogene).', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (84, 45, 'name', 'EB virus test', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (85, 45, 'detail', 'It can be used as a reliable method to assist in the clinical diagnosis of nasopharyngeal carcinoma and a useful indicator to observe the progression of the patient\'s disease.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (86, 46, 'name', 'Lumbar spine (lateral view) & (AP/PA view)', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (87, 46, 'detail', 'Multi-directional view for abnormalities in the lumbar spine such as osteophytes,scoliosis,spinal space narrowing,osteoporosis,bone destruction,and degenerative lesions.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (88, 47, 'name', 'Bone Density', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (89, 47, 'detail', 'By examining the heel bone or hand bone measurement,we can detect bone loss at an early stage and estimate the degree of osteoporosis for timely and effective prevention and treatment.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (90, 48, 'name', 'Low-dose spiral CT of the chest', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (91, 48, 'detail', 'The two lungs, heart, mediastinum, diaphragm and pleura are examined by low-dose spiral CT to determine the presence of inflammation and tumors.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (92, 49, 'name', 'Human papilloma virus typing (HPV typing)', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (93, 49, 'detail', 'It directly reflects the presence of papillomavirus in human body and can determine the specific type of infection,which provides reference for clinical diagnosis of cervical cancer.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (94, 50, 'name', 'Hormone blood tests \nProgesterone,Estradiol,luteinizing hormone,Follicle Stimulating Hormone,Testosterone', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (95, 50, 'detail', 'Monitoring female hormones through different periods of the menstrual cycle can provide insight into female ovarian function,can predict ovulation,and is also important for screening of female endocrine diseases and infertility.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (96, 51, 'name', 'BRCA1、BRCA2', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (97, 51, 'detail', 'To suggest that the subject may be at risk of developing a hereditary tumor.\nTo take appropriate preventive measures and live a healthy life to reduce the risk of the disease.\nTargeted health checkups and early screening for those at high risk to achieve early diagnosis and treatment and improve survival rates.\nFor people with family history, they can relieve psychological stress and do scientific prevention work.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (98, 52, 'name', 'Pepsinogen II (I and II)', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (99, 52, 'detail', 'It is called serological gastroscopy and \"serological biopsy\" of the gastric mucosa.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (100, 53, 'name', 'Check the status of H. pylori infection, which is closely associated with the development of gastric inflammation,peptic ulcers, and gastric cancer.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (101, 53, 'detail', 'Check the status of H. pylori infection,which is closely associated with the development of gastric inflammation,peptic ulcers and gastric cancer.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (102, 54, 'name', 'Thyroid function tests', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (103, 54, 'detail', 'It is the main indicator of the functional status of the thyroid gland and is used for screening of hyperthyroidism or hypothyroidism, etc.', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (104, 55, 'name', 'Blood Type', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (105, 55, 'detail', 'Blood type is divided into O, A, B, AB four types', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (106, 56, 'name', 'Hepatitis B Blood Tests(HBsAg, HBsAb, HBeAg, HBeAb and HBcAb)', '2023-03-11 16:34:28', '2023-03-11 16:34:28');
INSERT INTO `tb_multilingual_term_attribute` VALUES (107, 56, 'detail', 'To evaluate whether you are infected with the hepatitis B virus and what kind of status you are currently in,and to find out whether you are immune to hepatitis B,whether you are infectious,and whether you need further examination and treatment.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (108, 57, 'name', 'Internal Medicine Check-ups', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (109, 57, 'detail', 'The basic condition of the vital organs such as the heart,lung,liver and spleen is examined by by inspection,palpation,percussion, auscultation,to detect signs associated with common diseases or initially exclude common diseases.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (110, 58, 'name', 'Surgical Check-ups', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (111, 58, 'detail', 'Through physical examination,the basic condition of important organs such as skin,thyroid,breast (female),prostate (male),spine extremities,and external genitalia are examined to detect signs related to common surgical diseases or to initially exclude common surgical diseases.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (112, 59, 'name', 'Vision Screening and Eye Exams', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (113, 59, 'detail', 'Problems related to eye diseases and initial screening for common diseases are checked by using relevant equipment.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (114, 60, 'name', 'Gynaecological Examination (gynaecologist exam + TCT)', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (115, 60, 'detail', 'Gynecological palpation and instrumental examination methods are used to detect signs associated with common gynaecological conditions or to initially exclude common gynaecological conditions.TCT is an advanced screening method for cervical cancer and precancerous lesions.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (116, 61, 'name', 'Complete Blood Count (CBC)', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (117, 61, 'detail', 'Routine blood tests are used to detect blood problems, evaluate bone marrow function,help determine clinical acute and chronic infections and viral diseases;help understand the presence or absence of anemia and anemia classification;help diagnose bleeding disorders,etc.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (118, 61, 'description', 'White blood cell count,red blood cell count,hemoglobin amount,platelet count,etc.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (119, 62, 'name', 'Liver Function Tests(ALT+AST+DBil+ TBil)', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (120, 62, 'detail', 'The basic condition of the liver is reflected by biochemical tests that measure various indicators related to the metabolism of the liver function.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (121, 63, 'name', 'Fasting Blood Glucose (FBG)', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (122, 63, 'detail', 'Evaluate whether human glucose metabolism is normal in the fasting state and assess whether fasting blood glucose control is up to standard in diabetic patients.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (123, 64, 'name', 'AFB', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (124, 64, 'detail', 'It is clinically important for the diagnosis,efficacy observation and prognosis assessment of primary liver cancer.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (125, 65, 'name', 'CEA', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (126, 65, 'detail', 'Broad-spectrum tumor markers,which are clinically important for screening,efficacy observation and prognosis assessment of colorectal and pancreatic cancers.It can also be elevated in stomach,breast and lung cancers.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (127, 66, 'name', '(CA15-3)', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (128, 66, 'detail', 'An increase in CA153 is seen in breast cancer disease.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (129, 67, 'name', '(CA125)', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (130, 67, 'detail', 'Increased CA125 is seen in gynecological and gastrointestinal malignancies.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (131, 68, 'name', '(T-PSA）', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (132, 68, 'detail', 'PSA is clinically important for the diagnosis,observation of efficacy, and assessment of prognosis in men with prostate cancer.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (133, 69, 'name', 'Abdominal Ultrasound(liver, gallbladder, pancreas, spleen, both kidneys)', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (134, 69, 'detail', 'The ultrasound of abdomen is mainly for routine examination of the liver,gallbladder,pancreas,spleen and kidneys,and can be used as a preliminary screening test,for example: fatty liver, kidney cysts, etc.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (135, 70, 'name', 'Thyroid Ultrasound', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (136, 70, 'detail', 'The main mean of thyroid morphology examination can find thyroid nodule,thyroid cyst,thyroiditis,thyroid tumor,thyroid cancer and other diseases.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (137, 70, 'description', 'Thyroid gland', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (138, 71, 'name', 'Prostate Ultrasound', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (139, 71, 'detail', 'Observing the size,shape and structure of the prostate gland to determine if there are enlarged prostate,cysts,calculus,malignant lesions,etc.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (140, 72, 'name', 'Color Doppler Ultrasound', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (141, 72, 'detail', 'Examination of the breast by color ultrasound instruments reveals lesions such as breast enlargement,masses,nodules,cysts,adenomas and breast cancer.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (142, 73, 'name', 'Ultrasound of Uterus and Adnexa', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (143, 73, 'detail', 'To observe the size, morphological structure and internal echogenicity of the uterus and adnexa (ovaries and fallopian tubes),to identify normal and abnormal,to understand the nature of the lesions and to discern the presence of malignant lesions for early management.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (144, 74, 'name', 'Chest X-Ray (PA)', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (145, 74, 'detail', 'Examination of the heart,both lungs,mediastinum,diaphragm and pleura to determine the presence of inflammation and tumors.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (146, 75, 'name', 'Personalized Package - Male', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (147, 76, 'name', 'Personalized Package - Female (without gynecology）', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (148, 77, 'name', 'Personalized package - female (with gynecology)', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (149, 78, 'name', 'Youth Standard Package - Male', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (150, 79, 'name', 'Youth Standard Package - Female (without gynecological examination)', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (151, 80, 'name', 'Youth Standard Package - Female (with gynecological examination)', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (152, 83, 'name', 'Cardiovascular (blood) Tests', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (153, 83, 'description', 'For thoses with dizziness and headache;hypertension; cardiovascular and cerebrovascular diseases and family history.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (154, 83, 'medicalAdvice', 'Hcy is an independent risk factor for the development of cardiovascular diseases such as atherosclerosis. It is particularly relevant in people with a history of hypertension; it is associated with genetics, nutrition, oestrogen levels, and age; hcy is elevated by mutations in genes or certain synthetic enzyme genes that decrease enzyme activity; it also assesses liver metabolic function and detoxification.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (155, 84, 'name', 'Cardiovascular (imaging tests )', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (156, 84, 'description', 'For those who have hypertension, hyperlipidemia, blackening of the eyes, dizziness and family history of cardiovascular disease.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (157, 84, 'medicalAdvice', 'Early detection of carotid vascular lesions provides an objective haemodynamic basis for effective prevention and reduction in the development of cerebrovascular disease. To understand the blood flow in various intracranial and extracranial vessels, cerebral artery circumflex vessels and their branches, and to determine the presence of vascular lesions such as sclerosis, stenosis, ischaemia, malformation and spasm. It allows dynamic monitoring of cerebrovascular disease.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (158, 85, 'name', 'Cardiovascular Genetic Screening', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (159, 85, 'description', 'For those who have a family history of cardiovascular disease and want to know the genetic risk of cardiovascular disease in advance for early prevention.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (160, 85, 'medicalAdvice', 'For those who have a family history of coronary heart disease and would like to know the genetic risk of cardiovascular disease in advance for early prevention.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (161, 86, 'name', 'Cardiacmorphology Examination', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (162, 86, 'description', 'For patients with various heart diseases; metabolic diseases such as hypertension, diabetes, hyperlipidemia; history of cardiovascular and cerebrovascular diseases and family history.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (163, 86, 'medicalAdvice', 'It provides an understanding of the morphology and functional status of the various components of the heart, the location and size of malformations within the heart, the relationship of the great vessels and the extent of other malformations and lesions. The ejection fraction allows a direct assessment of the functional status of the heart and is suitable for all types of heart disease.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (164, 87, 'name', 'Tumor Marker Test (female)', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (165, 87, 'description', 'For women who need to be screened for gynecological and digestive tract malignant tumors.. For example, those with cirrhosis disease, suspected ovarian tumors, etc. Those with history of breast cancer, lung cancer, colon cancer, cervical cancer cancer and family history.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (166, 87, 'medicalAdvice', 'PSA is a broad-spectrum tumour marker that is clinically important for the screening, efficacy observation and prognosis assessment of colorectal and pancreatic cancers. It can also be elevated in stomach, breast and lung cancers. It has greater clinical value in the diagnosis of ovarian cancer, in addition to patients with benign ovarian tumours and uterine fibroids, and in the decompensated stage of liver cirrhosis. It is an aid in the diagnosis of early breast cancer and metastatic breast cancer. Increased: seen in breast cancer, lung cancer, colon cancer, cervical cancer, etc.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (167, 88, 'name', 'Tumor Marker Test (male)', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (168, 88, 'description', 'For men over 40 years of age with previous or suspected prostate disease.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (169, 88, 'medicalAdvice', 'PSA is a broad-spectrum tumour marker that is clinically important for the screening, efficacy observation and prognosis assessment of colorectal and pancreatic cancers. PSA is also elevated in stomach, breast and lung cancers. PSA is clinically important for the diagnosis, efficacy observation and prognosis assessment of prostate cancer in men.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (170, 89, 'name', 'Genetic Testing for Tumor', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (171, 89, 'description', 'For those who want to know the genetic risk of cancer and those who have a family history of cancer.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (172, 89, 'medicalAdvice', 'Genetic testing is a technique for testing DNA through blood, other body fluids, or cells. It is a method of testing the DNA molecules in the cells of the person being tested with specific equipment to analyse the types of genes and gene defects it contains and whether they are expressed in a normal function, thus enabling people to know their genetic information and to identify the cause of a disease or to predict the risk of a disease in the body.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (173, 90, 'name', 'Nasopharyngeal Cancer', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (174, 90, 'description', 'For those who need nasopharyngeal cancer review or suspected nasopharyngeal cancer;those who have nasopharyngeal discomfort without improvement from repeated treatment.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (175, 90, 'medicalAdvice', 'It can be used as a reliable clinical aid in the diagnosis of nasopharyngeal carcinoma and as a useful indicator of the progression of the patient\'s disease.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (176, 91, 'name', 'Radiological Examinations', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (177, 91, 'description', 'For those with low back pain, radiating pain and numbness and weakness of both lower limbs; scoliosis, reduced mobility of lumbar spine, muscle atrophy, decreased muscle strength,etc.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (178, 91, 'medicalAdvice', 'Lumbar spine  (PA view) can be used to understand the diagnosis and treatment of lumbar spine diseases such as the presence of scoliosis, abnormalities in the small joints of the lumbar spine; the presence of cryptorchidism, deviation of the spinous process, the relationship between the vertebral space and the intervertebral disc, and the compression of the spinal nerve.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (179, 92, 'name', 'Bone Density Screening', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (180, 92, 'description', 'For sedentary people who lack exercise; especially those over 40 years old.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (181, 92, 'medicalAdvice', 'The presence of abnormal bone density is also an important indicator of metabolic and nutritional imbalances in the body. Bone densitometry is highly sensitive and diagnostic for all causes of osteoporosis. It can be used for the early diagnosis of osteoporosis and the observation of its outcome.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (182, 93, 'name', 'Chest CT Examination', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (183, 93, 'description', 'For those who smoke; have a family history of lung cancer or other cancers; pulmonary fibrosis or previous history of tuberculosis.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (184, 93, 'medicalAdvice', 'Examination of both lungs, heart, mediastinum, diaphragm and pleura by low-dose spiral CT to determine the presence of inflammation, tumours, etc.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (185, 94, 'name', 'HPV Screening For Women', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (186, 94, 'description', 'For those with recurrent inflammation of the cervix; those with a history of cervical cancer; those with a history of sexual intercourse.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (187, 94, 'medicalAdvice', 'HPV is an epitheliophilic virus and only humans can be infected by HPV. It directly detects whether the human body is infected with HPV and the typing of the infection is determined to provide a reference for clinical diagnosis of cervical cancer.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (188, 95, 'name', 'Female Endocrine', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (189, 95, 'description', 'For women with menstrual cycle disorders,planning for pregnancy; gynecological disorders due to hormonal imbalance, etc.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (190, 95, 'medicalAdvice', 'The five sex hormone tests are effective in detecting endocrine disorders in women. It is suitable for women with menstrual cycle disorders, women who are planning for pregnancy, infertility, overweight women, etc.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (191, 96, 'name', 'BRCA Genetic Testing', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (192, 96, 'description', 'For those who have a family history of breast or ovarian cancer or have already had breast or ovarian cancer.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (193, 96, 'medicalAdvice', 'To suggest that the subject may be at risk of developing a hereditary tumor.\nTo take appropriate preventive measures and live a healthy life to reduce the risk of the disease.\nTargeted health checkups and early screening for those at high risk to achieve early diagnosis and treatment and improve survival rates.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (194, 97, 'name', 'Stomach Tumor Markers', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (195, 97, 'description', 'Suitable for people with stomach problems such as stomach pain, acid reflux and indigestion; and people with family history of stomach, esophageal, liver and intestinal cancers.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (196, 97, 'medicalAdvice', 'Useful for assessing gastrointestinal digestive and absorption functions, inflammation, ulcers, tumour screening, etc.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (197, 98, 'name', 'H.pylori screening', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (198, 98, 'description', 'Recurrent gastrointestinal inflammation; gastric polyps; indigestion; family members or those who have had previous infections themselves.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (199, 98, 'medicalAdvice', 'A positive breath test for H. pylori indicates the presence of H. pylori infection, which is closely associated with the development of inflammatory conditions in the stomach, peptic ulcers and gastric cancer. It has an impact on the health of the digestive system. There are effective ways to improve it.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (200, 99, 'name', 'Thyroid Examination', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (201, 99, 'description', 'For those who need diagnosis and treatment for hyperthyroidism, hypothyroidism, thyroid nodules, masses, etc.; it is also recommended for those who often suffer from insomnia, intolerance to heat, chills, irritability, lethargy, mood swings, abnormal stools, and frequent palpitation for unknown reasons.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (202, 99, 'medicalAdvice', 'It is used to screen for conditions such as hyperthyroidism or hypothyroidism. It can detect thyroid nodules, thyroid cysts, thyroiditis, thyroid tumours, thyroid cancer and other diseases.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (203, 100, 'name', 'ABO typing', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (204, 100, 'description', 'For those who want to know their own blood type.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (205, 100, 'medicalAdvice', 'Blood group refers to the type of antigen on the surface of blood components (including red blood cells, white blood cells and platelets). The blood group is usually referred to as the specific antigen type on the red blood cell membrane, and the most clinically relevant and well known are the ABO blood group system and the Rh blood group system of red blood cells.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (206, 101, 'name', 'Hepatitis B Virus Test', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (207, 101, 'description', 'For those with a history of hepatitis B or suspected hepatitis B infection; those who have other liver diseases for hepatitis B screening. Those with previous hepatitis B infection or abnormal liver function; those who want to know if they have protective antibodies; those with a family or household history of hepatitis B disease,etc.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (208, 101, 'medicalAdvice', 'To evaluate the presence or absence of hepatitis B virus infection and the presence or absence of protective antibodies. To understand how infectious the hepatitis B virus is. To determine whether the infection is a first infection or a recurrence of virus carriage is assessed to provide a clinical basis for treatment and observation of treatment effects suitable for the diagnosis and treatment of hepatitis B,cirrhosis and liver cancer.', '2023-03-11 16:34:29', '2023-03-11 16:34:29');
INSERT INTO `tb_multilingual_term_attribute` VALUES (209, 102, 'name', 'ikang Zhuoyue Beijing Zhongguancun Founder Building branch', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (210, 102, 'address', '3rd Floor,Founder International Building,52nd North Fourth Ring West Road,Haidian District, Beijing', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (211, 102, 'businessHours', 'From Tuesday to Sunday: 07:30AM-10:30AM,deadline for blood collection:  10:30AM', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (212, 102, 'unobstructed', 'Subway: Zhongguancun E Exit ,Line 4/Line 10', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (213, 103, 'name', 'ikang Guobin Beijing Asian Games Village Huizhong Beili Branch VIP Department', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (214, 103, 'address', 'The second floor of the Jingshi Science and Technology Building,Section B,Floor 105,Huizhong Beili,Chaoyang District,Beijing', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (215, 103, 'businessHours', 'From Tuesday to Sunday: 07:30AM-10:30AM,deadline for blood collection:  10:30AM', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (216, 103, 'unobstructed', 'Subway:Datun East Station on Line 5/Anli Road Station on Line 15', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (217, 104, 'name', 'ikang Guobin Beijing Xishimen Branch VIP Department', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (218, 104, 'address', '4/F,Building D,Chengming Mansion,2 Xizhimen South Street, Xicheng District, Beijing', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (219, 104, 'businessHours', 'From Tuesday to Sunday: 07:30AM-10:30AM,deadline for blood collection:  10:30AM', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (220, 104, 'unobstructed', 'Subway: Exit C from Xizhimen Station,Line 2', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (221, 105, 'name', 'ikang Guobin Shanghai Pudong Babaiban Branch VIP Department', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (222, 105, 'address', 'West District,6th Floor,Zhongrong Hengrui Building,560 Zhangyang Road,Shanghai', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (223, 105, 'businessHours', 'From Tuesday to Sunday: 07:30AM-10:00AM,deadline for blood collection:  10:00AM', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (224, 105, 'unobstructed', 'Subway: Shangcheng Road Station Exit 2,Line 9', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (225, 106, 'name', 'ikang Guobin Shanghai Lujiazui Branch VIP Department', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (226, 106, 'address', '1-3 /F,Gaowei Building,999 Binjiang Avenue,Pudong New Area, Shanghai', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (227, 106, 'businessHours', 'From Tuesday to Sunday: 07:30AM-10:30AM,deadline for blood collection:  10:30AM', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (228, 106, 'unobstructed', 'Subway: Exit 1,Yuanshen Road,Line 4/Lower Changyi Road,Line 18', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (229, 107, 'name', 'ikang Guobin Shanghai Wujiaochang Wanda Plaza Branch VIP Department', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (230, 107, 'address', '6th Floor,Wanda International Plaza,36 Guobin Road,Yangpu District, Shanghai', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (231, 107, 'businessHours', 'From Tuesday to Sunday: 07:30AM-10:00AM,deadline for blood collection:  10:00AM', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (232, 107, 'unobstructed', 'Subway:Wujiaochang Station,Line 10', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (233, 108, 'name', 'ikang Guobin Shenzhen Futian Branch VIP Department', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (234, 108, 'address', 'B201/203,Building QB,Union Square,East Interchange of Beicaitian Road,Binhe Road,Futian District,Shenzhen', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (235, 108, 'businessHours', 'From Tuesday to Sunday: 07:30AM-10:30AM,deadline for blood collection:  10:30AM', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (236, 108, 'unobstructed', 'Subway: 500 meters ahead of Gangsha Exit B,Line 1', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (237, 109, 'name', 'ikang Guobin Shenzhen Kexing Branch VIP Department', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (238, 109, 'address', 'Floor 3A,4/F,Unit 3,Block B,Kexing Academy of Sciences, Keyuan Road,High-tech Park,Nanshan District,Shenzhen', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (239, 109, 'businessHours', 'From Tuesday to Sunday: 07:30AM-10:30AM,deadline for blood collection:  10:30AM', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (240, 109, 'unobstructed', 'Subway:Exit A4 of Shenda Station,Line 1', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (241, 110, 'name', 'ikang Zhuoyue Shenzhen Chegongmiao Hanggang Fuchun Building branch', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (242, 110, 'address', 'Second floor,Hanggang Fuchun Business Building,No.6031 Shennan Avenue,Tian \'an Community,Shatou Street,Futian District,Shenzhen', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (243, 110, 'businessHours', 'From Tuesday to Sunday: 07:30AM-10:30AM,deadline for blood collection:  10:30AM', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (244, 110, 'unobstructed', 'Subway:Chegongmiao Station,Luobao Line/Line 9', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (245, 111, 'name', 'ikang Zhuoyue Shenzhen Kuaiyanbao branch', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (246, 111, 'address', '1-3/F,Huibin Square Phase II,Dongbin Road,Nanshan District, Shenzhen', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (247, 111, 'businessHours', 'From Tuesday to Sunday: 07:30AM-10:30AM,deadline for blood collection:  10:30AM', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (248, 111, 'unobstructed', 'Bus route:No.122/79/322 /390/M484,Dongbin Road middle station,East Station', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (249, 112, 'name', 'iKang Guangzhou Huacheng Avenue Nantian Square Medical Examination Branch 3/F VIP Department', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (250, 112, 'address', '3/F (Nantian Jewelry World) Nantian International Business Center,No.7 Huacheng Avenue,Zhujiang Xincheng,Tianhe District,Guanghzou', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (251, 112, 'businessHours', 'From Monday to Saturday: 08:00-16:30,cut-off time for blood collection:  10:30', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (252, 112, 'unobstructed', 'Subway: Line No.5 - Wuyangcun Station Exit C', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (253, 113, 'name', 'ikang Zhuoyue Guangzhou Pazhou Poly Zhongyue branch', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (254, 113, 'address', '3rd Floor,Office Building (South Tower),Poly Zhongyue Plaza, No.23,Xuanyue East Street,Haizhu District,Guangzhou', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (255, 113, 'businessHours', 'From Monday to Saturday: 08:00-16:30,cut-off time for blood collection:  10:30', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (256, 113, 'unobstructed', 'Bus/subway:Wan Sheng Wai Station', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (257, 114, 'name', 'iKang Guangzhou Huanshi East Branch 2/F VIP Department', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (258, 114, 'address', '2/F Guangfa Garden,No.496 Huanshi East Road,Yuexiu District,Guangzhou', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (259, 114, 'businessHours', 'From Monday to Saturday: 08:00-16:30,cut-off time for blood collection:  10:30', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (260, 114, 'unobstructed', 'Line No.5-Zoo Station Exits B and C', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (261, 115, 'name', 'ikang Guobin Hangzhou Qianjiang Century City Guangfu Center Branch VIP Department', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (262, 115, 'address', '2nd Floor,Guangfu United International Center,Qianjiang Century City,Hangzhou', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (263, 115, 'businessHours', 'From Tuesday to Sunday: 07:30AM-10:00AM,deadline for blood collection:  10:00AM', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (264, 115, 'unobstructed', 'Subway:Qianjiang Century City,Line 2', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (265, 116, 'name', 'ikang Guobin Hangzhou Wenhui Branch VIP Department', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (266, 116, 'address', '2nd Floor,Zhejiang Publishing Materials Building,108 Wenhui Road,Xiacheng District,Hangzhou', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (267, 116, 'businessHours', 'From Tuesday to Sunday: 07:30AM-10:00AM,deadline for blood collection:  10:00AM', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (268, 116, 'unobstructed', 'Subway:Tieguan Station, Exit C,Line 1', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (269, 117, 'name', 'ikang Zhuoyue Hangzhou Future Science and Technology City Branch', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (270, 117, 'address', 'Building 4,Oxchuangzhi No.1,intersection of Gaojiao Road and Lianchuang Road,Yuhang District, Hangzhou', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (271, 117, 'businessHours', 'From Tuesday to Sunday: 07:30AM-10:00AM,deadline for blood collection:  10:00AM', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (272, 117, 'unobstructed', 'Bus: No.332,Yaojiakou Station', '2023-03-13 16:20:58', '2023-03-13 16:20:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (273, 118, 'examNotice', 'test', '2023-05-25 21:24:41', '2023-05-25 21:24:41');
INSERT INTO `tb_multilingual_term_attribute` VALUES (274, 119, 'examNotice', '<p><strong>Friendly reminder:</strong></p><p><strong>The physical examination adopts an appointment system. If you go directly without an appointment, you will not be able to arrange the physical examination normally.</strong></p><p><strong>【Before physical examination】</strong></p><p>1. The day before the physical examination, please have a light diet, do not drink alcohol, do not be tired, avoid strenuous exercise and emotional excitement, ensure adequate sleep, and fast and water after 10 pm; fast and water in the morning on the day of the physical examination.</p><p>2. If you have recently taken medication or need to take medication during the examination due to illness, please inform the front desk or healthcare workers of the institution.</p><p>3. If you make an appointment for a gastroscopy, you need to stop using anticoagulants such as aspirin for 14 days in advance.</p><p>4. Female colleagues please avoid menstruation.</p><p><strong>【Physical examination】</strong></p><p>1. Pregnant or pregnant colleagues, please take the initiative to inform the front desk or healthcare workers, to avoid radiation examination.</p><p>2. Do not wear overly complicated clothing, do not wear contact lenses, female colleagues pay attention not to wear underwear with metal buckles.</p><p>3. Avoid carrying valuables, do not wear metal ornaments, and keep your belongings safe.</p><p>4. Precautions for some projects:</p><ul><li>The general items that require fasting examination include blood drawing, abdominal ultrasound, breath test, etc. For details, please consult the inspector to see if you can eat.</li><li>Before internal medicine examination, a general examination is required to check blood pressure.</li><li>Radiological examination must remove jewelry such as gold, silver, and jade worn on the body to avoid affecting the examination results.</li></ul><p>5. Women need to drink 400-500 milliliters of water before undergoing pelvic ultrasound (abdominal) examination to fill the bladder to ensure accurate examination results.</p><p><strong>【After physical examination】</strong></p><p>1. After all inspection items are completed, please submit the inspection form to the inspection station.</p><p>2. Receive a medical report</p><ul><li>The physical examination report of private institutions (such as Aikang, Ruici, Meinian, etc.) defaults to the electronic version, which can be viewed and downloaded through this platform after authorization. The paper version needs to be actively informed to the front desk for self-pickup. If not authorized, please consult the front desk of the institution for the report acquisition method during the physical examination.</li></ul>', '2023-11-01 16:23:52', '2023-11-01 16:23:52');
INSERT INTO `tb_multilingual_term_attribute` VALUES (275, 120, 'name', 'Morphy Richards folding warm plate MR8300', '2023-11-20 14:49:58', '2023-11-20 14:49:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (276, 121, 'name', 'Joyoung 332', '2023-11-20 14:49:58', '2023-11-20 14:49:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (277, 122, 'name', 'SOHOME-Teddy hand warmer cup', '2023-11-20 14:49:58', '2023-11-20 14:49:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (278, 123, 'name', 'Kouluwei May Rose Fragrance Steam Hair Mask Cap (40MLx3)', '2023-11-20 14:49:58', '2023-11-20 14:49:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (279, 124, 'name', 'Fresh Zhixirui Snow Apple Green New Crisp Apple 8 Pieces Gift Box, Large Fruit 85mm', '2023-11-20 14:49:58', '2023-11-20 14:49:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (280, 125, 'name', 'Bamboo cup 350ml', '2023-11-20 14:49:58', '2023-11-20 14:49:58');
INSERT INTO `tb_multilingual_term_attribute` VALUES (281, 126, 'name', 'Morphy Richards folding warm plate MR8300', '2023-11-20 17:27:20', '2023-11-20 17:27:20');
INSERT INTO `tb_multilingual_term_attribute` VALUES (282, 127, 'name', 'Joyoung 332', '2023-11-20 17:27:20', '2023-11-20 17:27:20');
INSERT INTO `tb_multilingual_term_attribute` VALUES (283, 128, 'name', 'SOHOME-Teddy hand warmer cup', '2023-11-20 17:27:20', '2023-11-20 17:27:20');
INSERT INTO `tb_multilingual_term_attribute` VALUES (284, 129, 'name', 'Kouluwei May Rose Fragrance Steam Hair Mask Cap (40MLx3)', '2023-11-20 17:27:20', '2023-11-20 17:27:20');
INSERT INTO `tb_multilingual_term_attribute` VALUES (285, 130, 'name', 'Fresh Zhixirui Snow Apple Green New Crisp Apple 8 Pieces Gift Box, Large Fruit 85mm', '2023-11-20 17:27:20', '2023-11-20 17:27:20');
INSERT INTO `tb_multilingual_term_attribute` VALUES (286, 131, 'name', 'Bamboo cup 350ml', '2023-11-20 17:27:20', '2023-11-20 17:27:20');
INSERT INTO `tb_multilingual_term_attribute` VALUES (287, 132, 'name', 'S Morphy Richards folding warm plate MR8300', '2023-11-20 17:33:50', '2023-11-20 17:33:50');
INSERT INTO `tb_multilingual_term_attribute` VALUES (288, 133, 'name', 'S1 Joyoung 332', '2023-11-20 17:33:50', '2023-11-20 17:33:50');
INSERT INTO `tb_multilingual_term_attribute` VALUES (289, 134, 'name', 'S SOHOME-Teddy hand warmer cup', '2023-11-20 17:33:50', '2023-11-20 17:33:50');
INSERT INTO `tb_multilingual_term_attribute` VALUES (290, 135, 'name', 'S Kouluwei May Rose Fragrance Steam Hair Mask Cap (40MLx3)', '2023-11-20 17:33:50', '2023-11-20 17:33:50');
INSERT INTO `tb_multilingual_term_attribute` VALUES (291, 136, 'name', 'S Fresh Zhixirui Snow Apple Green New Crisp Apple 8 Pieces Gift Box, Large Fruit 85mm', '2023-11-20 17:33:51', '2023-11-20 17:33:51');
INSERT INTO `tb_multilingual_term_attribute` VALUES (292, 137, 'name', 'S Bamboo cup 350ml', '2023-11-20 17:33:51', '2023-11-20 17:33:51');
INSERT INTO `tb_multilingual_term_attribute` VALUES (293, 138, 'name', 'S0 Joyoung 332', '2023-11-24 14:49:46', '2023-11-24 14:49:46');
INSERT INTO `tb_multilingual_term_attribute` VALUES (294, 139, 'name', 'Physical Product Test 3 - With Discount', '2023-11-24 17:18:43', '2023-11-24 17:18:43');
INSERT INTO `tb_multilingual_term_attribute` VALUES (295, 140, 'name', 'Test Product 1', '2023-12-04 14:47:16', '2023-12-04 14:47:16');
INSERT INTO `tb_multilingual_term_attribute` VALUES (296, 141, 'name', 'JD 100 RMB recharge card', '2023-12-04 14:47:16', '2023-12-04 14:47:16');
INSERT INTO `tb_multilingual_term_attribute` VALUES (297, 142, 'name', 'Three Squirrel Dried Pork jerky', '2023-12-04 14:47:16', '2023-12-04 14:47:16');
INSERT INTO `tb_multilingual_term_attribute` VALUES (298, 143, 'name', 'Autumn and winter socks', '2023-12-05 14:05:13', '2023-12-05 14:05:13');

-- ----------------------------
-- Table structure for tb_multilingual_term_domain
-- ----------------------------
DROP TABLE IF EXISTS `tb_multilingual_term_domain`;
CREATE TABLE `tb_multilingual_term_domain`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `domain` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '词条域',
  `description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '词条领域描述',
  `gmt_created` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `IDX_DOMAIN`(`domain`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_multilingual_term_domain
-- ----------------------------
INSERT INTO `tb_multilingual_term_domain` VALUES (1, 'ExamitemDepartment', 'ExamitemDepartment', '2023-03-11 16:14:32', '2023-03-11 16:14:32');
INSERT INTO `tb_multilingual_term_domain` VALUES (2, 'ExamitemPackageCategory', 'ExamitemPackageCategory', '2023-03-11 16:14:39', '2023-03-11 16:14:39');
INSERT INTO `tb_multilingual_term_domain` VALUES (3, 'ExamItem', 'ExamItem', '2023-03-11 16:14:45', '2023-03-11 16:14:45');
INSERT INTO `tb_multilingual_term_domain` VALUES (4, 'Meal', 'Meal', '2023-03-11 16:14:53', '2023-03-11 16:14:53');
INSERT INTO `tb_multilingual_term_domain` VALUES (5, 'ExamItemPackage', 'ExamItemPackage', '2023-03-11 16:15:00', '2023-03-11 16:15:00');
INSERT INTO `tb_multilingual_term_domain` VALUES (6, 'MealTag', 'MealTag', '2023-03-11 16:24:36', '2023-03-11 16:24:36');
INSERT INTO `tb_multilingual_term_domain` VALUES (7, 'Hospital', 'Hospital', '2023-03-13 16:20:33', '2023-03-13 16:20:33');
INSERT INTO `tb_multilingual_term_domain` VALUES (8, 'CompanyExamNotice', 'CompanyExamNotice', '2023-05-25 21:22:41', '2023-05-25 21:22:45');
INSERT INTO `tb_multilingual_term_domain` VALUES (9, 'SPU', '商城商品', '2023-11-20 14:49:54', '2023-11-20 15:02:11');
INSERT INTO `tb_multilingual_term_domain` VALUES (10, 'SKU', 'SKU', '2023-11-20 17:25:37', '2023-11-20 17:25:37');

-- ----------------------------
-- View structure for multilingual
-- ----------------------------
DROP VIEW IF EXISTS `multilingual`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `multilingual` AS select `a`.`id` AS `attribute_id`,`a`.`attribute` AS `attribute`,`a`.`value` AS `value`,`a`.`term_id` AS `term_id`,`t`.`term` AS `term`,`t`.`term_key` AS `term_key`,`t`.`language` AS `language`,`t`.`domain_id` AS `domain_id`,`d`.`domain` AS `domain`,`d`.`description` AS `description` from ((`tb_multilingual_term_attribute` `a` left join `tb_multilingual_term` `t` on((`a`.`term_id` = `t`.`id`))) left join `tb_multilingual_term_domain` `d` on((`t`.`domain_id` = `d`.`id`)));

SET FOREIGN_KEY_CHECKS = 1;

/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50735
 Source Host           : localhost:3306
 Source Schema         : store_ssm

 Target Server Type    : MySQL
 Target Server Version : 50735
 File Encoding         : 65001

 Date: 16/10/2021 12:43:28
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `goodId` int(11) NOT NULL AUTO_INCREMENT,
  `typeId` int(11) NOT NULL,
  `goodName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `price` decimal(10, 2) NULL DEFAULT NULL,
  `star` int(11) NULL DEFAULT NULL,
  `total` int(255) NULL DEFAULT NULL,
  `addTime` date NULL DEFAULT NULL,
  `detail` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`goodId`) USING BTREE,
  INDEX `typeId`(`typeId`) USING BTREE,
  CONSTRAINT `fk_typeId` FOREIGN KEY (`typeId`) REFERENCES `goodstype` (`typeId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 83 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (1, 1, '醇香核桃乳', 'static/image/b97f956c08cb431d9e66f7245f74312d.jpg', 12.00, 6, 156, '2021-10-13', '醇香核桃乳240ml12--优质核桃，口感纯正，营养丰富');
INSERT INTO `goods` VALUES (2, 1, '法国进口红酒', 'static/image/b59945c8d0ff48b9ad132d8cacec1274.jpg', 554.00, 8, 148, '2021-10-21', '法国进口红酒，口感回甘醇香');
INSERT INTO `goods` VALUES (3, 1, '芬达', 'static/image/2afaaa8b13494f8f8c6ced28ecccc3f3.jpg', 2.00, 8, 644, '2021-10-07', '小瓶装芬达，橙子味，每瓶200ml');
INSERT INTO `goods` VALUES (4, 1, '干红葡萄酒', 'static/image/383c4a6ee7814f2ba67bfeb6f674b35f.jpg', 996.00, 7, 654, '2021-10-13', '干红葡萄酒，平价中的香醇');
INSERT INTO `goods` VALUES (5, 1, '怪兽速溶咖啡', 'static/image/a35cbbdc3f444353aed17358ff528788.jpg', 123.00, 8, 78, '2021-10-19', '怪兽速溶咖啡，送定制咖啡杯');
INSERT INTO `goods` VALUES (6, 1, '罐装可乐', 'static/image/94a5c081d8364dbaa75aa30f395ca065.jpg', 17.80, 8, 645, '2021-10-13', '罐装可乐--可口可乐罐装整箱6罐装');
INSERT INTO `goods` VALUES (7, 1, '尖叫饮料', 'static/image/f9e32273354f417b8f5a32c878efed58.jpg', 5.00, 8, 98, '2021-10-11', '纤维运动饮料，柠檬味');
INSERT INTO `goods` VALUES (8, 1, '康师傅冰红茶', 'static/image/419ccd9793fb44a59932be39ebee439b.jpg', 3.00, 8, 844, '2021-10-14', '康师傅冰红茶，正宗，每瓶200ml');
INSERT INTO `goods` VALUES (9, 1, '牛奶', 'static/image/eaaaacaa08344a84a51c1aabec664082.jpg', 123.00, 7, 194, '2021-10-18', '鲜牛奶，原生高钙，品质奶源，短期即使');
INSERT INTO `goods` VALUES (10, 1, '瓶装可乐', 'static/image/7d0ab54a0dd2446d83eac836b2f68a94.jpg', 3.00, 8, 84, '2021-10-04', '瓶装可乐，每瓶350ml');
INSERT INTO `goods` VALUES (11, 1, '青岛啤酒', 'static/image/ce31b2371a0042b6bceef7ad68258486.jpg', 6.00, 9, 4849, '2021-10-15', '青岛啤酒每箱12罐，每罐500ml');
INSERT INTO `goods` VALUES (12, 1, '特级乌龙茶', 'static/image/4289c98c8b3a48f8bba911cbc7fc1323.jpg', 46.90, 8, 489, '2021-10-20', '怪兽茶叶--新鲜特技乌龙香茶');
INSERT INTO `goods` VALUES (13, 1, '养生茶', 'static/image/0c687468a919455d83f58ade07ebc44b.jpg', 36.90, 9, 544, '2021-10-12', '养生茶，功效：清肝明目降火');
INSERT INTO `goods` VALUES (14, 2, '海苔', 'static/image/9cda402314f14312a6f4d298431b0ef5.jpg', 12.90, 5, 881, '2021-10-07', 'Bigbang海苔，绿色包装，清脆美味');
INSERT INTO `goods` VALUES (15, 2, '夹心饼干', 'static/image/8033aff696814c98b805ef8181ac893a.jpg', 18.80, 8, 156, '2021-10-06', 'Lemond夹心饼干，巧克力夹心，浓郁美味');
INSERT INTO `goods` VALUES (16, 2, '开心果', 'static/image/e36b6801dee04fd68bf0523b7dbfd0f0.jpg', 19.90, 8, 463, '2021-10-13', '三只松鼠开心果，量足新鲜，清脆美味');
INSERT INTO `goods` VALUES (17, 2, '迷你肌肉串', 'static/image/7ae57ee9d397446d8b83d73aa8aedbab.jpg', 27.80, 6, 544, '2021-09-27', '冷冻食品，生食，送到后请放入冰箱保存');
INSERT INTO `goods` VALUES (18, 2, '葡萄干', 'static/image/f0b4896aa846464590c84c9e83f0adb8.jpg', 17.80, 8, 594, '2021-10-27', '三只松鼠葡萄干，青提口味，好吃美味');
INSERT INTO `goods` VALUES (19, 2, '葡萄干饼干', 'static/image/d9e2b61143544b0b9a1238f499edadf8.jpg', 16.50, 7, 43, '2021-10-04', 'Totaste葡萄干饼干，饼干的酥脆加葡萄干的酸甜，冲击你的味蕾');
INSERT INTO `goods` VALUES (20, 2, '千层酥', 'static/image/848c215fc72f4b85bf1cafbb13480114.jpg', 5.00, 6, 123, '2021-10-12', '原味千层酥，酥脆爽口，让你欲罢不能');
INSERT INTO `goods` VALUES (21, 2, '曲奇饼干', 'static/image/aa042ab826f8440bb698b7063aca119a.jpg', 16.90, 5, 211, '2021-10-06', '皇冠曲奇饼干礼盒版--好处的饼干+好看的礼盒=适合送礼');
INSERT INTO `goods` VALUES (22, 2, '手工辣条', 'static/image/3c006ee76aa940eb81898558ce1e8ea0.jpg', 18.90, 10, 423, '2021-10-11', '手工辣条，下单现做现发，新鲜美味+童年的味道');
INSERT INTO `goods` VALUES (23, 2, '手撕面包', 'static/image/a92649b1698a4b1b80580f2e11ff0fdd.png', 12.90, 10, 163, '2021-10-12', '三只松鼠手撕面包，美食之爱，早餐饱腹感强');
INSERT INTO `goods` VALUES (24, 2, '蔬菜饼干', 'static/image/d9032c78b4e44bfead286c056f7fd923.jpg', 13.30, 10, 516, '2021-10-06', 'Totaste蔬菜饼干条--饼干的清脆，蔬菜的清香');
INSERT INTO `goods` VALUES (25, 2, '卫龙辣条大礼包', 'static/image/19f164a5f2dd45c49597cbaf2f4d5d79.jpg', 12.90, 10, 161, '2021-10-27', '卫龙辣条大礼包--“真”童年的味道，麻辣舒爽，刺激味蕾');
INSERT INTO `goods` VALUES (26, 2, '玉米棒', 'static/image/23aaadecf22942f2b9e656addad78dc7.jpg', 13.50, 10, 546, '2021-10-05', '香甜玉米棒，除了香甜还有酥脆');
INSERT INTO `goods` VALUES (27, 3, '白鹿原', 'static/image/9f5caf575639466ab3eab39a259193cc.jpg', 39.90, 8, 1515, '2021-10-20', '白鹿原--二十年畅销不衰的小说力作，茅盾文学奖获奖作品');
INSERT INTO `goods` VALUES (28, 3, '材料化学', 'static/image/692ae52bb5054691aa2814c1497559b1.jpg', 49.90, 8, 515, '2021-10-26', '材料化学--材料学分支，研究在制备、生产、应用及废弃过程中新型材料的化学性质');
INSERT INTO `goods` VALUES (29, 3, '泛函分析导论', 'static/image/b0229e0be7084718923e764cf1c5793a.jpg', 69.90, 9, 55, '2021-10-27', '《泛函分析导论(英文版)》主要内容：Functional analysis is primarily concerned with infinite-dimensional linear（vector） spaces, mainly function spaces whose points are functions, andmappings between them...');
INSERT INTO `goods` VALUES (30, 3, '绿野仙踪涂色书', 'static/image/8d6da4df70fa4a16ad9c452160814153.jpg', 46.80, 9, 545, '2021-09-28', '绿野仙踪涂色书--一千个人心中就有一千个不同的绿野仙踪，用你喜欢的画材来填充、修改、添加，注入你的风格！');
INSERT INTO `goods` VALUES (31, 3, '墨菲定律', 'static/image/1b98667272404a14b6a1428efd989141.jpg', 29.90, 8, 51, '2021-10-04', '墨菲定律：越是害怕出错，就越容易出错本书通过一系列生动直观的现象描述和心理剖析，揭开墨菲定律的神秘面纱，还原其本来面目');
INSERT INTO `goods` VALUES (32, 3, '深度学习：走向核心素养', 'static/image/ed0279de73944234a35bc371287c2ede.jpg', 49.80, 8, 484, '2021-10-14', '深度学习：本书是理论普及读本,着重阐明以下几个主要问题：为什么要推进深度学习？什么是深度学习？怎样实现深度学习？怎样推进深度学习？');
INSERT INTO `goods` VALUES (33, 3, '思路决定出路', 'static/image/955b051b839e4a35bf3ea25d2aae2454.jpg', 45.00, 9, 52, '2021-10-19', '思维决定出路，格局决定结局。');
INSERT INTO `goods` VALUES (34, 3, '思维的形状', 'static/image/d4c0a2bec4c945319fa047ccce4a6318.jpg', 55.40, 9, 552, '2021-10-04', '从遥远的历史真相到眼前的信息过滤，从外星人的思维之谜到机器人的道德困惑，从为人父母的情感记录到奇点时刻的真正降临，为读者呈现了了极为广阔的科幻创作视野。');
INSERT INTO `goods` VALUES (35, 3, '微生物资源学', 'static/image/03167ee3ac384d828a0a807b2586ab97.jpg', 44.80, 9, 112, '2021-10-04', '微生物资源学：微生物资源学是研究微生物资源的种类和深度，微生物资源与环境的关系，微生物资源合理开发利用的战略和策略微生物资源有效保护的措施的科学');
INSERT INTO `goods` VALUES (36, 3, '乌合之众', 'static/image/45fe83e07f4c43468af72d2060141d79.jpg', 36.60, 9, 511, '2021-10-11', '乌合之众：法国著名社会心理学家古斯塔夫勒庞著作。在社会心理学领域的著作中最有影响的，就是本书。书中极为精致的描绘了集体心态，对人们理解集体行为的作用，以及对于社会心理学的思考发挥了重大的影响。');
INSERT INTO `goods` VALUES (37, 3, '喜智与悲智', 'static/image/797fd596e3bc423a92fdfcd2a49f521b.jpg', 56.90, 9, 55, '2021-10-12', '本书深入浅出，详尽解读杨绛的全部戏剧、小说、散文作品，抉幽发徽，引领读者体察杨绛作品独特的审美特征、精神意蕴与文化内涵，进入这位身披“隐身衣”的智者的内心世界，领略其幽默与悲悯交织、理性与感性并举的智慧魅力。 作为海内外第一部系统化、总体性阐述杨绛八十余年文学创作的专著，本书亦力图通过个案分析把握二十世纪中国历史变迁中知识分子的精神脉动');
INSERT INTO `goods` VALUES (38, 3, '熊逸说经典', 'static/image/43448f3a9bd54982a6dc4a4a32f9049e.jpg', 26.80, 8, 213, '2021-10-19', '串讲了一些国学经典，并且搭配了一些经典案例进行佐证，让人对各个经典作品的主要观点和风格有了大概的了解');
INSERT INTO `goods` VALUES (39, 3, '一本书玩转思维导图', 'static/image/12a78640aad44188acbf772d725d0227.jpg', 36.60, 9, 515, '2021-10-18', '从软件、思维、行业、职业四条线，帮助读者快速成为思维导图高手');
INSERT INTO `goods` VALUES (40, 3, '油画的诀窍', 'static/image/84daf591e20c4a09adfad24476580509.jpg', 46.00, 9, 114, '2021-10-19', '油画的诀窍：本书分为五章，第一章向读者介绍了油画创作的基础知识，其余四中分别以静物画、风景画、野生动物画及人物肖像画为主题，具体讲解油画的创作方法');
INSERT INTO `goods` VALUES (41, 3, '正常人体解剖学', 'static/image/1c14bc38e0fd495c8f74ec3aee8e4097.jpg', 23.60, 6, 151, '2021-10-06', '人体解剖学是一门重要的医学基础课。随着近年来科学技术的进步，人体解剖学也得到了很大的发展。全书力图做到重点突出、内容简明、文笔流畅、制图精良');
INSERT INTO `goods` VALUES (42, 3, '自卑与超越', 'static/image/901a64ba666f429cbc1eada5d13f2e9b.jpg', 45.60, 9, 123, '2021-10-18', '自卑与超越--从探寻人生的意义出发，启迪我们去理解真实的生命意义');
INSERT INTO `goods` VALUES (43, 4, '春季男士潮流套装', 'static/image/bcfd7b6a2f8e4eb9b096c404b7533b9d.jpg', 79.90, 9, 555, '2021-10-19', '红色格子上衣外套+破洞黑色牛仔--春季上新，潮流时尚套装');
INSERT INTO `goods` VALUES (44, 4, '春秋男款儿童套装', 'static/image/22264371481d4eba9c0561beb6e1564f.jpg', 156.00, 9, 544, '2021-10-12', '长袖上衣+黑色长裤--春秋换季儿童时尚穿搭');
INSERT INTO `goods` VALUES (45, 4, '春秋男士套装大气时尚', 'static/image/0120a81356e24076ac6400adaa7f6252.jpg', 213.00, 9, 565, '2021-10-13', '内搭半领黑领长袖+外搭白色短袖+灰黑丝滑长裤--韩款时尚穿搭套装');
INSERT INTO `goods` VALUES (46, 4, '冬季男士长T卫衣', 'static/image/1aea2a0c04444b03b94397689e62efc4.jpg', 79.90, 9, 155, '2021-10-06', '冬季男士上衣T恤，卫衣，加绒加厚');
INSERT INTO `goods` VALUES (47, 4, '冬季女士家居服', 'static/image/d5743eea849243ac8caaa3c02f3a94e7.jpg', 109.00, 9, 467, '2021-10-12', '冬季女士家居服--灰色，鸭梨款，花领，冬季保暖必买套装');
INSERT INTO `goods` VALUES (48, 4, '男士商务西服', 'static/image/bb7d85c6703c443cb9adf6d347f047b9.jpg', 554.00, 9, 154, '2021-10-19', '男士西装外套+白色衬衫+黑色白格领结---商务男士不拘一格套装');
INSERT INTO `goods` VALUES (49, 4, '女士港风穿搭外套', 'static/image/8ecb4fce0da24ccd8450a4648bb5c8a1.jpg', 399.00, 9, 1221, '2021-09-28', '港式百搭外衣，星星款');
INSERT INTO `goods` VALUES (50, 4, '清新文艺女装套装', 'static/image/2f26b3fe507a46549c4dcc543459ff71.jpg', 499.00, 9, 544, '2021-10-12', '褐色斑点上衣+经典小黑裙--卫衣女青年的清新穿搭套装');
INSERT INTO `goods` VALUES (51, 4, '秋冬男士休闲卫衣', 'static/image/25712d3464b84cc0ac4dd2c8032e0899.jpg', 99.90, 8, 484, '2021-10-19', '白色休闲卫衣--背面搭配简单的英文字母和花纹更显休闲美观');
INSERT INTO `goods` VALUES (52, 4, '秋冬女士时尚套装大气款', 'static/image/69ff29acd187408da2464f9a34c3643e.jpg', 299.90, 9, 884, '2021-09-27', '毛绒红色外套+宽松棉麻裤+白色高跟鞋--秋冬时尚女士套装，时尚出街必备套装');
INSERT INTO `goods` VALUES (53, 4, '夏季女士休闲T恤', 'static/image/f4a0d7f4e12a48c89d21cae7e64999cf.jpg', 198.90, 8, 145, '2021-10-03', '粉色、白色夏季上衣女款T恤--可可爱爱哦');
INSERT INTO `goods` VALUES (54, 4, '夏季时尚情侣装', 'static/image/93ef91dc6b5c492f87143ffa2e8569b7.jpg', 399.00, 9, 554, '2021-10-05', '橙色男款上衣T恤+蓝色女款上衣T恤--情侣新品上市啦');
INSERT INTO `goods` VALUES (55, 4, '小熊维尼童装天蓝', 'static/image/391943f8722444adab135116b3d1adc3.jpg', 256.00, 9, 155, '2021-10-11', '小熊维尼套装童装--天蓝色，小熊维尼图标');
INSERT INTO `goods` VALUES (56, 5, 'GS水乳套装', 'static/image/ea9b2dcc37dc4017b8926e7e2a0221c2.jpg', 199.00, 10, 4884, '2021-10-12', 'GS金色简约套装--水润保湿，卓效抗老');
INSERT INTO `goods` VALUES (57, 5, '佰草集护肤品套装', 'static/image/77d29e24a62e4ac0b940ce757f58b617.jpg', 554.00, 8, 455, '2021-10-11', '佰草集简约套装水乳--高能维稳，深度修复');
INSERT INTO `goods` VALUES (58, 5, '本草堂面霜', 'static/image/451fd21f9bd24de6a03aeeba81a53d1f.jpg', 399.00, 9, 555, '2021-10-20', '本草堂基础套装水乳--芦荟护肤天然新体验');
INSERT INTO `goods` VALUES (59, 5, '大宝防晒霜', 'static/image/7560460ded2441a79e94a3bc0970266d.jpg', 99.00, 10, 449, '2021-10-19', '大宝防晒隔离霜--SPF25++防晒，提亮肤色，隔离灰霾');
INSERT INTO `goods` VALUES (60, 5, '法国欧莱雅护肤品套装', 'static/image/ffe51818515e4358bfc20ae52b1eee25.jpg', 299.00, 9, 155, '2021-10-11', '欧莱雅全套--紧致抗皱，淡化细纹，滋养弹嫩');
INSERT INTO `goods` VALUES (61, 5, '高资面膜', 'static/image/d260182d9e48407c9ccadae0ee85f809.jpg', 223.00, 10, 846, '2021-10-04', '高姿面膜--补水保湿，润白透亮；养润透白敷出好气色');
INSERT INTO `goods` VALUES (62, 5, '花容月貌芦荟护手霜', 'static/image/25d20a1381d240249ba67ab1c0c45e06.jpg', 399.00, 9, 484, '2021-10-19', 'AGOAGE花容月面芦荟护手霜--滋润保湿，软化角质，淡化干纹，美白弹嫩');
INSERT INTO `goods` VALUES (63, 5, '魅可丝防晒喷雾', 'static/image/d54b409cb6724484ad035a57cc120017.jpg', 233.00, 9, 153, '2021-10-12', '魅可丝防晒喷雾--新活水感防晒喷雾，高倍防晒，布局紫外线，清透保湿，防晒遮瑕，隔离修颜');
INSERT INTO `goods` VALUES (64, 5, '丝维蓝皙面膜', 'static/image/d6c3b1b2979247dbb088a8b1e96d127b.jpg', 456.00, 10, 115, '2021-10-04', '丝维蓝皙面膜--丝滑冰敷面膜，水油平衡，保湿滋养嫩肤');
INSERT INTO `goods` VALUES (65, 5, '天然护肤补水', 'static/image/47b31ab061214599a75aedc02558ce49.jpg', 199.00, 10, 643, '2021-10-10', '冰川水+集合百草精华--清透去角质素');
INSERT INTO `goods` VALUES (66, 5, '新宠爱护肤套装', 'static/image/ecf130213bf6431d95f2238f808205eb.jpg', 139.00, 9, 134, '2021-10-11', '新宠爱经典黄金套装--水润保湿，深度修复');
INSERT INTO `goods` VALUES (67, 5, '雪肤美面膜', 'static/image/c5396c4e068f4b7d9829399ad4c64cb9.jpg', 199.00, 9, 151, '2021-09-27', '雪肤美面膜--新鲜海洋补水面膜，25ml高浓度补水精华，20倍补水吸收力');
INSERT INTO `goods` VALUES (68, 5, '雅顿兰斯护肤品套装', 'static/image/061f2e3995e642b99604f40d714a168a.jpg', 199.00, 9, 151, '2021-10-05', '雅诗兰黛全套套装--润白补水，抗老提色');
INSERT INTO `goods` VALUES (69, 6, 'iPhone手机保护壳', 'static/image/dd7f93297cf849eba7319b406f097e44.jpg', 399.00, 10, 5115, '2021-10-18', 'iPhone手机保护壳--款式新颖，设计大方，采用金属边框，PVC透明背板，紧跟时尚潮流');
INSERT INTO `goods` VALUES (70, 6, 'NFC配件', 'static/image/e66ec5b184344ca7b403577ebecfe95e.jpg', 233.00, 9, 151, '2021-10-04', 'NFC专用配件--圆环为全铝合金材质，镶嵌有信号感应装置，请根据具体需求进行选购，拆封后无质量问题不退不换');
INSERT INTO `goods` VALUES (71, 6, 'Nikon相机', 'static/image/cd61c76545b44200b487691c75831ec8.jpg', 3999.80, 10, 135, '2021-10-04', 'Nikon单反相机--官方正品，全新国行，赠一年保修');
INSERT INTO `goods` VALUES (72, 6, 'SONY电子手表', 'static/image/d83147490f8d44a4806142b8da1666e0.jpg', 1999.00, 9, 161, '2021-10-26', 'Sony电子手表--大屏清晰，感应灵敏，可选配表带');
INSERT INTO `goods` VALUES (73, 6, 'USB充电基座', 'static/image/d3874da1f7d24ec7a794b31bb2dee5f5.jpg', 299.00, 9, 126, '2021-10-19', 'USB充电基座--设计人性，高效耐用，全金属镀层的基座，为您的充电体验，添上浓墨重彩的一笔');
INSERT INTO `goods` VALUES (74, 6, '电子秤', 'static/image/75661ac4991e46a39413af7f065ea851.jpg', 399.00, 7, 556, '2021-10-20', '电子秤--数字精确，操作可调，称重范围广，实验室专用');
INSERT INTO `goods` VALUES (75, 6, '电子手表', 'static/image/e4af4b17ebeb4485bfd2db642932938f.jpg', 499.00, 10, 551, '2021-10-10', '电子手表--超大屏为您带来极致的视觉享受，人性化的语音交流功能，让使用者们都欲罢不能，您还在等什么呢？');
INSERT INTO `goods` VALUES (76, 6, '感应灯', 'static/image/bd445b0a187c4972a16fe8915d7363f7.jpg', 199.00, 10, 151, '2021-10-05', '感应灯--轻便灵活，功率不小，适用于桌面摆件，夜灯设置。我们致力于为您的双眼，点上迷离的微光。全新的灯光体验，期待您选购');
INSERT INTO `goods` VALUES (77, 6, '卡西欧数码相机', 'static/image/67904f3ff42c4277b277c5364bf6324f.jpg', 449.00, 10, 156, '2021-10-18', '卡西欧的爆款数码相机--以超高像素、流畅机身、轻巧便携为主打的新生代数码摄像机');
INSERT INTO `goods` VALUES (78, 6, '蓝牙头戴式耳机', 'static/image/6f9d0ba552dd420b8bb3e561ddcd6a82.jpg', 199.00, 10, 515, '2021-10-18', '蓝牙头戴式耳机--蓝牙连接稳定，传输速率高，解码清晰带金标，侧方触控面板手势识别');
INSERT INTO `goods` VALUES (79, 6, '软边钢化膜', 'static/image/6b17a718eceb494ab2ed82da63683125.jpg', 19.90, 10, 48, '2021-10-11', '软边钢化膜--多种机型适配，钢化玻璃抗震防摔，边沿柔软，握持感良好，挖空精确');
INSERT INTO `goods` VALUES (80, 6, '摄像头', 'static/image/2263117146f14207b03c27723a77f7cd.jpg', 239.00, 10, 557, '2021-10-11', '桌面摄像头--小巧便捷，关节灵活，支持360度无死角旋转，摄像清晰度360P');
INSERT INTO `goods` VALUES (81, 6, '体重秤', 'static/image/65c26bc12fe94aa89caabe6b7da1ec3d.jpg', 179.00, 9, 58, '2021-10-11', '体重秤，蓝牙电子款，玻璃面板感应，致力于成为您健康与自信的第一道防线！');
INSERT INTO `goods` VALUES (82, 6, '血压计', 'static/image/179de25a2e084076986b6f5337423c15.jpg', 151.00, 7, 516, '2021-10-04', '血压计，推荐中老年人及有心血管等相关疾病家族患病史的成年人使用，儿童请在家长陪同下使用');

-- ----------------------------
-- Table structure for goodstype
-- ----------------------------
DROP TABLE IF EXISTS `goodstype`;
CREATE TABLE `goodstype`  (
  `typeId` int(11) NOT NULL AUTO_INCREMENT,
  `typeName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`typeId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goodstype
-- ----------------------------
INSERT INTO `goodstype` VALUES (1, '饮品');
INSERT INTO `goodstype` VALUES (2, '食品');
INSERT INTO `goodstype` VALUES (3, '书籍');
INSERT INTO `goodstype` VALUES (4, '服装');
INSERT INTO `goodstype` VALUES (5, '护肤品');
INSERT INTO `goodstype` VALUES (6, '电子产品');

-- ----------------------------
-- Table structure for manager_user
-- ----------------------------
DROP TABLE IF EXISTS `manager_user`;
CREATE TABLE `manager_user`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of manager_user
-- ----------------------------
INSERT INTO `manager_user` VALUES (1, 'admin', 'admin');

-- ----------------------------
-- Table structure for views_user
-- ----------------------------
DROP TABLE IF EXISTS `views_user`;
CREATE TABLE `views_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `phoneNum` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `gender` char(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of views_user
-- ----------------------------
INSERT INTO `views_user` VALUES (1, 'whoops', 'whoops', '13635237846', 'whoops_zq@foxmail.com', '男');
INSERT INTO `views_user` VALUES (2, 'shenshen', 'shenshen', '15689746469', 'shenshen@qq.com', '女');

SET FOREIGN_KEY_CHECKS = 1;

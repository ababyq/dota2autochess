/*
 Navicat Premium Data Transfer

 Source Server         : 本地
 Source Server Type    : MySQL
 Source Server Version : 80036
 Source Host           : localhost:3306
 Source Schema         : zizouqi

 Target Server Type    : MySQL
 Target Server Version : 80036
 File Encoding         : 65001

 Date: 01/04/2026 14:53:13
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for chess
-- ----------------------------
DROP TABLE IF EXISTS `chess`;
CREATE TABLE `chess`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '棋子描述',
  `isuse` tinyint(1) NULL DEFAULT NULL COMMENT '是否在用',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '棋子名称',
  `occupation` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '职业',
  `race` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '种族',
  `cost` int(0) NULL DEFAULT NULL COMMENT '费用',
  `sort` int(0) NULL DEFAULT NULL COMMENT '排序',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '棋子图标',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '棋子图片',
  `skill` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '技能',
  `skill_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '技能描述',
  `skill_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '技能类型：战吼/被动/指向性/无目标/光环等',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 122 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of chess
-- ----------------------------
INSERT INTO `chess` VALUES (1, '冰女', 1, '水晶室女', '4', '16', 1, 1, 'npc_dota_hero_crystal_maiden_png.png', 'chess_cm_png.png', 'cm_mana_aura', '奥术光环：周期性的为所有友方棋子充能法力值', '光环');
INSERT INTO `chess` VALUES (2, 'fw', 1, '斧王', '1', '14', 1, 2, 'npc_dota_hero_axe_png.png', 'chess_axe_png.png', 'axe_berserkers_call', '狂战士之吼：嘲讽附近1格的敌方棋子，强迫他们攻击自己，同时获得额外护甲', '无目标');
INSERT INTO `chess` VALUES (3, '小鹿', 1, '魅惑魔女', '8', '20,35', 1, 3, 'npc_dota_hero_enchantress_png.png', 'chess_eh_png.png', 'eh_untouchable_aura', '不可侵犯：攻击魅惑魔女的敌人会降低攻击速度；主动：召唤小精灵治疗', '无目标');
INSERT INTO `chess` VALUES (4, '海民', 1, '巨牙海民', '1', '20', 1, 4, 'npc_dota_hero_tusk_png.png', 'chess_tusk_png.png', 'tusk_walrus_punch_lua', '海象神拳：将一个近身的敌方棋子打到半空中造成暴击物理伤害', '指向性');
INSERT INTO `chess` VALUES (5, '敌法', 1, '敌法师', '13', '15', 4, 5, 'npc_dota_hero_antimage_png.png', 'chess_am_png.png', 'am_mana_break', '法力损毁：每次攻击损毁法力值并造成等值物理伤害，累计触发法力虚空', '被动');
INSERT INTO `chess` VALUES (6, '露娜', 1, '月之骑士', '5', '15', 2, 6, 'npc_dota_hero_luna_png.png', 'chess_luna_png.png', 'luna_moon_glaive', '月刃：普通攻击可以在敌方棋子之间弹跳', '被动');
INSERT INTO `chess` VALUES (7, '小仙女', 1, '邪影芳灵', '9', '15', 1, 7, 'npc_dota_hero_dark_willow_png.png', 'chess_dw_png.png', 'dw_flower', '荆棘迷宫：战斗回合开始前禁锢若干个随机敌方棋子', '战吼');
INSERT INTO `chess` VALUES (8, '小歪', 1, '暗影萨满', '10', '18', 1, 8, 'npc_dota_hero_shadow_shaman_png.png', 'chess_ss_png.png', 'lion_voodoo', '妖术：将一个敌方棋子变形为人畜无害的小动物', '指向性');
INSERT INTO `chess` VALUES (9, '巫医', 1, '巫医', '6', '18', 1, 9, 'npc_dota_hero_witch_doctor_png.png', 'chess_wd_png.png', 'witch_doctor_paralyzing_cask', '麻痹药剂：抛出一个木桶在敌人之间弹跳，眩晕并造成魔法伤害', '指向性');
INSERT INTO `chess` VALUES (10, '小黑', 1, '卓尔游侠', '3', '22', 3, 10, 'npc_dota_hero_drow_ranger_png.png', 'chess_dr_png.png', 'ability_drow_ranger_wave_of_silence', '狂风：释放一阵狂风，击退敌人并造成沉默和魔法伤害', '点目标');
INSERT INTO `chess` VALUES (11, '冰龙', 1, '寒冰飞龙', '4', '22,25', 1, 11, 'npc_dota_hero_winter_wyvern_png.png', 'chess_ww_png.png', 'winter_wyvern_cold_embrace', '极寒之拥：将友方棋子封入冰茧，恢复生命值并阻隔物理伤害', '指向性');
INSERT INTO `chess` VALUES (12, '赏金', 1, '赏金猎人', '3', '19,36', 1, 12, 'npc_dota_hero_bounty_hunter_png.png', 'chess_bh_png.png', 'bh_shuriken', '忍术飞镖：被动-首次击杀获得赏金；主动-掷出飞镖造成魔法伤害和眩晕', '指向性/被动');
INSERT INTO `chess` VALUES (13, '发条', 1, '发条技师', '7', '19', 1, 13, 'npc_dota_hero_rattletrap_png.png', 'chess_clock_png.png', 'rattletrap_battery_assault', '弹幕冲击：向附近2格敌方棋子随机射出高能弹片，造成魔法伤害和短暂眩晕', '无目标');
INSERT INTO `chess` VALUES (14, 'tk', 1, '修补匠', '7', '19', 1, 14, 'npc_dota_hero_tinker_png.png', 'chess_tk_png.png', 'a108', '热导飞弹：发射数枚火箭飞弹，追踪轰炸随机的敌方棋子', '无目标');
INSERT INTO `chess` VALUES (15, '小小', 1, '山岭巨人', '1', '24', 2, 15, 'npc_dota_hero_tiny_png.png', 'chess_tiny_png.png', 'tiny_touzhi', '投掷：将身边敌方棋子抛起，对落地点周围造成物理伤害和眩晕；被动：主场阵亡永久+100生命值', '点目标/被动');
INSERT INTO `chess` VALUES (16, '马尔斯', 1, '天界战神', '1', '28', 1, 16, 'npc_dota_hero_mars_png.png', 'chess_mars_png.png', 'mars_bulwark_attack', '护身甲盾：被动-格挡正面/侧面伤害；主动-举盾击退前方敌人并造成物理伤害', '被动');
INSERT INTO `chess` VALUES (17, '白牛', 1, '裂魂人', '2', '31', 1, 17, 'npc_dota_hero_spirit_breaker_png.png', 'chess_sb_png.png', 'sb_julizhongji', '巨力重击：攻击有概率眩晕并击退敌方棋子，造成额外伤害', '被动');
INSERT INTO `chess` VALUES (18, '兽王', 1, '兽王', '3', '14', 2, 18, 'npc_dota_hero_beastmaster_png.png', 'chess_bm_png.png', 'bm_beast', '野性召唤：召唤野兽伙伴，★豪猪、★★战鹰、★★★斗熊（带嘲讽）', '点目标');
INSERT INTO `chess` VALUES (19, '剑圣', 1, '剑圣', '1', '14', 2, 19, 'npc_dota_hero_juggernaut_png.png', 'chess_jugg_png.png', 'juggernaut_blade_fury_lua', '剑刃风暴：舞起剑刃风暴，对周围2格敌方持续造成魔法伤害，获得减益免疫和魔法抗性', '无目标');
INSERT INTO `chess` VALUES (20, '血魔', 1, '血魔', '10', '14', 2, 20, 'npc_dota_hero_bloodseeker_png.png', 'chess_bs_png.png', 'bloodseeker_blood_bath_lua', '血祭：用魔血洗礼一片区域，完成后造成纯粹伤害并沉默敌人', '点目标');
INSERT INTO `chess` VALUES (21, '蓝胖', 1, '食人魔魔法师', '4', '21', 3, 21, 'npc_dota_hero_ogre_magi_png.png', 'chess_om_png.png', 'om_multi_cast_aura', '多重施法：光环-周围友军施法有概率连续释放两次并获得嗜血术攻速加成', '光环');
INSERT INTO `chess` VALUES (22, '火枪', 1, '狙击手', '3', '27', 2, 22, 'npc_dota_hero_sniper_png.png', 'chess_sniper_png.png', 'sniper_assassinate', '暗杀：锁定目标，瞄准后射出毁灭性子弹，造成大量物理伤害', '指向性');
INSERT INTO `chess` VALUES (23, 'puck', 1, '精灵龙', '4', '15,25', 2, 23, 'npc_dota_hero_puck_png.png', 'chess_puck_png.png', 'puck_illusory_orb', '幻象法球：发出魔法球，对路径敌人造成魔法伤害并致盲（攻击有概率丢失）', '点目标');
INSERT INTO `chess` VALUES (24, '先知', 1, '先知', '8', '15', 2, 24, 'npc_dota_hero_furion_png.png', 'chess_fur_png.png', 'fur_tree', '自然的呼唤：从棋盘边缘的树木召唤树人，★1小树人、★★2小树人、★★★2大树人', '点目标');
INSERT INTO `chess` VALUES (25, 'pom', 1, '月之女祭司', '3', '15', 1, 1, 'npc_dota_hero_mirana_png.png', 'chess_pom_png.png', 'pom_arrow_far', '月神箭：向最远敌方棋子射出精准箭矢，距离越远伤害越高、眩晕越长', '指向性');
INSERT INTO `chess` VALUES (26, '暗牧', 1, '暗影牧师', '11', '18', 1, 26, 'npc_dota_hero_dazzle_png.png', 'chess_dazzle_png.png', 'dazzle_bozang', '薄葬：使友方棋子持续时间内不会死亡，所受治疗效果+100%', '指向性');
INSERT INTO `chess` VALUES (27, '蝙蝠', 1, '蝙蝠骑士', '5', '18', 2, 27, 'npc_dota_hero_batrider_png.png', 'chess_bat_png.png', 'batrider_firefly', '火焰飞行：飞向最远能攻击到敌人的格子，留下燃烧尾迹造成持续魔法伤害', '点目标');
INSERT INTO `chess` VALUES (28, '死骑', 1, '死亡骑士', '5', '22', 1, 28, 'npc_dota_hero_abaddon_png.png', 'chess_abaddon_png.png', 'abaddon_aphotic_shield', '无光之盾：驱散并创造护盾吸收伤害，护盾摧毁时对周围敌人造成魔法伤害', '指向性');
INSERT INTO `chess` VALUES (29, '伐木机', 1, '伐木机', '7', '19', 2, 29, 'npc_dota_hero_shredder_png.png', 'chess_shredder_png.png', 'shredder_whirling_death', '死亡旋风：飞旋刀刃，对周围2格敌方棋子造成纯粹伤害', '无目标');
INSERT INTO `chess` VALUES (30, '水人', 1, '变体精灵', '2', '15,24', 5, 30, 'npc_dota_hero_morphling_png.png', 'chess_morph_png.png', 'morphling_waveform', '波浪形态：根据生命值转换属性，攻击一定次数后化为波浪涌进，造成魔法伤害', '点目标');
INSERT INTO `chess` VALUES (31, '神谕', 1, '神谕者', '11', '28', 2, 31, 'npc_dota_hero_oracle_png.png', 'chess_oracle_png.png', 'oracle_rain_of_destiny_datadriven', '天命之雨：在目标范围内降下大雨，治疗区域内的友方棋子', '点目标');
INSERT INTO `chess` VALUES (32, '小鱼', 1, '鱼人夜行者', '2', '17', 2, 32, 'npc_dota_hero_slark_png.png', 'chess_slark_png.png', 'slark_nengliangzhuanyi', '能量转移：攻击偷取敌方棋子的攻击速度', '被动');
INSERT INTO `chess` VALUES (33, 'lion', 1, '恶魔巫师', '9', '23', 4, 33, 'npc_dota_hero_lion_png.png', 'chess_lion_png.png', 'lion_finger_of_death', '死亡一指：撕裂一个敌方棋子，造成大量纯粹伤害，每层邪能之力增加额外伤害', '指向性');
INSERT INTO `chess` VALUES (34, '混沌', 1, '混沌骑士', '5', '23', 2, 34, 'npc_dota_hero_chaos_knight_png.png', 'chess_ck_png.png', 'chaos_knight_chaos_strike', '混沌一击：攻击有几率造成威力不一的致命一击，触发时带吸血效果', '被动');
INSERT INTO `chess` VALUES (35, '再来一杯', 1, '熊猫酒仙', '12', '30', 2, 35, 'npc_dota_hero_brewmaster_png.png', 'chess_brew_png.png', 'brewmaster_cinder_brew', '余烬佳酿：将烈酒洒向一片区域，使敌人物理攻击有概率丢失，受到技能伤害后燃烧', '点目标');
INSERT INTO `chess` VALUES (36, '隐刺', 1, '隐形刺客', '2', '26', 3, 36, 'npc_dota_hero_riki_png.png', 'chess_riki_png.png', 'smoke_screen_trigger', '战术烟幕弹：准备回合隐身，战斗开始投放烟雾弹，沉默并致盲敌人', '战吼/被动');
INSERT INTO `chess` VALUES (37, '军团', 1, '军团指挥官', '5', '16', 3, 37, 'npc_dota_hero_legion_commander_png.png', 'chess_lc_png.png', 'lc_qianggong', '强攻：被攻击后概率立即反击附带吸血，主场获胜且存活永久增加攻击力', '被动');
INSERT INTO `chess` VALUES (38, '全能', 1, '全能骑士', '5', '16', 5, 38, 'npc_dota_hero_omniknight_png.png', 'chess_ok_png.png', 'ok_angel', '守护天使：召唤守护天使，使附近友方棋子获得强效王者祝福护盾', '无目标');
INSERT INTO `chess` VALUES (39, '火女', 1, '秀逗魔导士', '4', '16', 2, 39, 'npc_dota_hero_lina_png.png', 'chess_lina_png.png', 'lina_laguna_blade', '神灭斩：对一个敌方棋子射出闪电，造成大量魔法伤害', '指向性');
INSERT INTO `chess` VALUES (40, '狼人', 1, '狼人', '1', '16,20', 3, 40, 'npc_dota_hero_lycan_png.png', 'chess_lyc_png.png', 'lyc_wolf', '变身：变身为凶狼形态，提高攻击力，在空格子召唤小狼', '无目标');
INSERT INTO `chess` VALUES (41, 'PA，幻刺', 1, '幻影刺客', '2', '15', 4, 41, 'npc_dota_hero_phantom_assassin_png.png', 'chess_pa_png.png', 'phantom_assassin_coup_de_grace', '恩赐解脱：被动-概率闪避技能伤害，攻击概率造成致命一击', '被动');
INSERT INTO `chess` VALUES (42, '大树', 1, '树精卫士', '8', '15', 3, 42, 'npc_dota_hero_treant_png.png', 'chess_tp_png.png', 'tp_seed', '寄生种子：在敌方棋子体内种下吸血种子，降低攻速移速，每秒造成魔法伤害并治疗附近友军', '指向性');
INSERT INTO `chess` VALUES (43, '死灵龙', 0, '死灵飞龙', '3', '22,25', 3, 43, 'npc_dota_hero_visage_png.png', 'chess_visage_png.png', 'baby_dragon', '召唤佣兽：召唤若干只盲眼佣兽，满能量时偷取敌方攻速', '无目标');
INSERT INTO `chess` VALUES (44, '屠夫', 1, '屠夫', '1', '22', 3, 44, 'npc_dota_hero_pudge_png.png', 'chess_pudge_png.png', 'pudge_meat_hook_lua', '肉钩：向最远敌方棋子射出肉钩，拖到身边造成纯粹伤害，友军会优先攻击此目标', '指向性');
INSERT INTO `chess` VALUES (45, '毒龙', 1, '冥界亚龙', '2', '25,2', 3, 45, 'npc_dota_hero_viper_png.png', 'chess_viper_png.png', 'ability_viper_viper_strike', '蝮蛇突袭：突袭攻击力最高的敌方棋子，降低攻击速度并造成持续毒素魔法伤害', '指向性');
INSERT INTO `chess` VALUES (46, '电棍', 1, '闪电幽魂', '10', '24', 3, 46, 'npc_dota_hero_razor_png.png', 'chess_razor_png.png', 'razor_plasma_field', '等离子场：释放等离子能量场，扩张和收缩时对击中的敌人造成魔法伤害，距离越远伤害越高', '无目标');
INSERT INTO `chess` VALUES (47, '拉比克', 1, '大魔导师', '9', '28', 3, 47, 'npc_dota_hero_rubick_png.png', 'chess_rubick_png.png', 'rubick_qiequ', '技能窃取：战斗回合开始偷学一个随机敌方棋子的主动技能', '战吼');
INSERT INTO `chess` VALUES (48, '大鱼', 1, '鱼人守卫', '1', '17', 3, 48, 'npc_dota_hero_slardar_png.png', 'chess_slardar_png.png', 'slardar_slithereen_crush', '鱼人碎击：猛击地面，对附近敌人造成物理伤害、眩晕和减速', '无目标');
INSERT INTO `chess` VALUES (49, 'SF', 1, '影魔', '6', '23', 3, 49, 'npc_dota_hero_nevermore_png.png', 'chess_sf_png.png', 'shadow_fiend_requiem_of_souls_lua', '魂之挽歌：聚集捕获的灵魂，以多道魔能向四面八方释放，造成魔法伤害', '无目标');
INSERT INTO `chess` VALUES (50, '大哥，TB', 1, '灵魂守卫', '13', '23', 3, 50, 'npc_dota_hero_terrorblade_png.png', 'chess_tb_png.png', 'tb_mohua_new', '魔化：变身成远程攻击的恶魔，★★以上会魔化最近的队友棋子', '无目标');
INSERT INTO `chess` VALUES (51, 'SK', 1, '沙王', '2', '29', 3, 51, 'npc_dota_hero_sand_king_png.png', 'chess_sk_png.png', 'sandking_burrowstrike', '掘地穿刺：钻入地面隧道前进，穿出时伤害并眩晕直线上的敌人', '点目标');
INSERT INTO `chess` VALUES (52, '剧毒', 1, '剧毒术士', '6', '20,29', 3, 52, 'npc_dota_hero_venomancer_png.png', 'chess_veno_png.png', 'veno_ward', '瘟疫守卫：在周围空格子召唤魔法抗性极高的瘟疫守卫攻击敌人', '点目标');
INSERT INTO `chess` VALUES (53, '米波，狗头', 1, '地卜师', '7', '32', 2, 53, 'npc_dota_hero_meepo_png.png', 'chess_meepo_png.png', 'poof', '忽悠：所有米波从地底传送至指定敌人位置，每只对附近敌人造成纯粹伤害', '指向性');
INSERT INTO `chess` VALUES (54, '火猫', 1, '灰烬之灵', '2', '30', 4, 54, 'npc_dota_hero_ember_spirit_png.png', 'chess_ember_png.png', 'sleight_of_fist_datadriven', '无影拳：以燎原之火速度横冲直撞，攻击目标区域内所有敌人，击杀重置冷却', '点目标');
INSERT INTO `chess` VALUES (55, '土猫', 1, '大地之灵', '10', '30', 4, 55, 'npc_dota_hero_earth_spirit_png.png', 'chess_earth_png.png', 'earth_rock_roll', '巨石翻滚：从棋盘边缘召唤巨石，撞击一排或一列，眩晕敌人并造成物理伤害', '无目标');
INSERT INTO `chess` VALUES (56, '蓝猫', 1, '风暴之灵', '4', '30', 4, 56, 'npc_dota_hero_storm_spirit_png.png', 'chess_storm_png.png', 'storm_spirit_ball_lightning_datadriven', '球状闪电：变成不稳定的电流横冲直撞，对撞到的敌人造成魔法伤害，距离递增', '点目标');
INSERT INTO `chess` VALUES (57, '光法', 1, '光之守卫', '4', '16', 4, 57, 'npc_dota_hero_keeper_of_the_light_png.png', 'chess_light_png.png', 'keeper_of_the_light_illuminate', '冲击波：积攒光的能量，释放时沿直线发出光波，造成大量魔法伤害', '点目标');
INSERT INTO `chess` VALUES (58, '船长', 1, '海军上将', '1', '16', 4, 58, 'npc_dota_hero_kunkka_png.png', 'chess_kunkka_png.png', 'kunkka_ship', '幽灵船：召唤幽灵船驶过战场，撞碎时对残骸周围敌人造成魔法伤害并眩晕', '点目标');
INSERT INTO `chess` VALUES (59, '龙骑', 1, '龙骑士', '5', '16,25', 4, 59, 'npc_dota_hero_dragon_knight_png.png', 'chess_dk_png.png', 'dk_dragon_form', '古龙形态：变身成为三种古龙形态之一，获得古龙吐息能力', '无目标');
INSERT INTO `chess` VALUES (60, '老陈', 1, '上帝之手', '11', '14', 4, 60, 'npc_dota_hero_chen_png.png', 'chess_chen_png.png', 'chen_fuhuo', '神圣劝化：复活本回合阵亡的等级最高的棋子，星级等于技能等级', '无目标');
INSERT INTO `chess` VALUES (61, '熊德', 1, '利爪德鲁伊', '8', '20', 4, 61, 'npc_dota_hero_lone_druid_png.png', 'chess_ld_png.png', 'ld_bear', '熊灵伙伴：在周围空格子召唤一只熊灵伙伴并肩作战', '点目标');
INSERT INTO `chess` VALUES (62, '风行', 1, '风行者', '3', '15', 2, 62, 'npc_dota_hero_windrunner_png.png', 'chess_wr_png.png', 'windrunner_shackleshot', '束缚击：将目标束缚在正对其后的敌人或树上，使其眩晕', '指向性');
INSERT INTO `chess` VALUES (63, '蘸酱', 1, '巨魔战将', '1', '18', 5, 63, 'npc_dota_hero_troll_warlord_png.png', 'chess_troll_png.png', 'troll_axe', '狂战士之怒：攻击概率发动旋风飞斧，根据距离造成物理伤害、减速或致盲', '被动');
INSERT INTO `chess` VALUES (64, '40法', 1, '死灵法师', '6', '22', 5, 64, 'npc_dota_hero_necrolyte_png.png', 'chess_nec_png.png', 'nec_scythe', '死神镰刀：使附近敌人按最大生命值百分比流失生命；主动-斩击敌人造成眩晕和纯粹伤害', '指向性');
INSERT INTO `chess` VALUES (65, '炼金', 1, '炼金术士', '6', '19,21', 4, 65, 'npc_dota_hero_alchemist_png.png', 'chess_ga_png.png', 'alchemist_chemical_rage', '化学狂暴：降低攻击间隔，提高生命回复，原地制造化学酸雾降低周围敌人护甲', '无目标');
INSERT INTO `chess` VALUES (66, '美杜莎，一姐', 1, '蛇发女妖', '3', '17', 4, 66, 'npc_dota_hero_medusa_png.png', 'chess_medusa_png.png', 'medusa_stone_gaze', '石化凝视：被动-分裂箭；主动-面朝美杜莎超过2秒的敌人被石化，造成基于最大生命值的纯粹伤害', '无目标/被动');
INSERT INTO `chess` VALUES (67, 'doom，末日', 1, '末日守卫', '1', '23', 4, 67, 'npc_dota_hero_doom_bringer_png.png', 'chess_doom_png.png', 'doom_bringer_doom', '末日：施加末日诅咒，使敌人无法施放技能、使用物品或被治疗，同时造成持续纯粹伤害', '指向性');
INSERT INTO `chess` VALUES (68, '墨客', 0, '天涯墨客', '9', '23', 4, 68, 'npc_dota_hero_grimstroke_png.png', 'chess_gs_png.png', 'gs_mingyunzhibi', '命运之笔：战斗回合开始前圈出若干个敌方棋子，对其施加缚魂效果', '战吼');
INSERT INTO `chess` VALUES (69, '小强，夜神', 1, '司夜刺客', '2', '22,29', 4, 69, 'npc_dota_hero_nyx_assassin_png.png', 'chess_na_png.png', 'nyx_assassin_spiked_carapace_datadriven', '尖刺外壳：激活尖刺外壳，反弹并无效化受到的伤害，同时眩晕攻击者', '无目标');
INSERT INTO `chess` VALUES (70, '蜘蛛', 1, '育母蜘蛛', '3', '29', 4, 70, 'npc_dota_hero_broodmother_png.png', 'chess_br_png.png', 'br_web_new', '丝质重器：缠绕最近的目标，使其攻击有概率落空，被攻击受额外魔法伤害，死亡孵化小蜘蛛', '被动');
INSERT INTO `chess` VALUES (71, '小牛', 1, '撼地神牛', '10', '31', 4, 71, 'npc_dota_hero_earthshaker_png.png', 'chess_es_png.png', 'gouhe', '沟壑：用图腾猛击地面，裂开地面制造岩脊，击飞敌人并造成物理伤害和眩晕', '点目标');
INSERT INTO `chess` VALUES (72, '萨尔', 1, '干扰者', '10', '14', 5, 72, 'npc_dota_hero_disruptor_png.png', 'chess_disruptor_png.png', 'ability_disruptor_static_storm', '静态风暴：创造静态风暴，沉默并魔法伤害区域内的敌人，伤害逐渐增强', '点目标');
INSERT INTO `chess` VALUES (73, '大圣', 1, '齐天大圣', '12', '20', 4, 73, 'npc_dota_hero_monkey_king_png.png', 'chess_mk_png.png', 'mk_ruyibangfa', '如意棒法：普通攻击累计伤害后，使用棒击大地，对直线敌人造成暴击伤害和眩晕', '被动');
INSERT INTO `chess` VALUES (74, '卡尔', 1, '祈求者', '4', '15', 5, 74, 'npc_dota_hero_invoker_png.png', 'chess_kael_png.png', 'invoke', '元素祈唤：召唤三个随机的元素精华并将它们融合为祈唤法术供祈求者施放', '被动');
INSERT INTO `chess` VALUES (75, '球', 1, '精灵守卫', '', '15', 5, 75, 'npc_dota_hero_wisp_png.png', 'chess_io_png.png', 'wisp_tether_lua', '羁绊：与附近友方棋子建立连接，提供百分比减伤，每隔一段时间平摊生命值百分比', '战吼');
INSERT INTO `chess` VALUES (76, '圣堂', 1, '圣堂刺客', '2', '15', 5, 76, 'npc_dota_hero_templar_assassin_png.png', 'chess_ta_png.png', 'templar_assassin_refraction', '折光：被动-灵能之刃穿透敌人；主动-变得难以捉摸，躲避伤害并获得攻击力加成', '无目标/被动');
INSERT INTO `chess` VALUES (77, '飞机', 1, '矮人直升机', '7', '27', 5, 77, 'npc_dota_hero_gyrocopter_png.png', 'chess_gyro_png.png', 'gyro_flak_cannon', '高射火炮：被动-副火炮持续攻击最远敌人；主动-主火炮同时射击范围内所有未近身敌人', '被动');
INSERT INTO `chess` VALUES (78, '神灵，哈斯卡', 1, '神灵武士', '1', '18', 3, 78, 'npc_dota_hero_huskar_png.png', 'chess_huskar_png.png', 'burning_spear_datadriven', '沸血狂战士：点燃长矛，每次攻击对自己造成魔法伤害，对敌人造成可叠加的持续魔法伤害', '被动');
INSERT INTO `chess` VALUES (79, '双头龙', 1, '双头龙', '4', '25', 5, 79, 'npc_dota_hero_jakiro_png.png', 'chess_thd_png.png', 'jakiro_macropyre', '烈焰焚身/冰封路径：释放烈焰风暴造成持续魔法伤害，或制造冰封路径冻结敌人', '点目标');
INSERT INTO `chess` VALUES (80, '51', 1, '巫妖', '4', '22', 4, 80, 'npc_dota_hero_lich_png.png', 'chess_lich_png.png', 'lich_chain_frost', '连环霜冻：释放在敌人间弹跳的霜冻之球，每次击中造成魔法伤害和减速', '指向性');
INSERT INTO `chess` VALUES (81, 'DP', 1, '死亡先知', '6', '22', 3, 81, 'npc_dota_hero_death_prophet_png.png', 'chess_dp_png.png', 'death_prophet_exorcism', '驱使恶灵：释放若干个恶灵偷走敌方棋子的生命，结束后根据伤害量获得治疗', '无目标');
INSERT INTO `chess` VALUES (82, '炸弹', 1, '地精工程师', '7', '19', 5, 82, 'npc_dota_hero_techies_png.png', 'chess_tech_png.png', 'chess_tech_bomb', '自爆炸药桶：埋设炸药桶，数秒后引爆，对4格范围内敌人造成大量物理伤害', '点目标');
INSERT INTO `chess` VALUES (83, '奶奶', 1, '电炎绝手', '5', '19', 4, 83, 'npc_dota_hero_snapfire_png.png', 'chess_snap_png.png', 'snapfire_lil_shredder', '霹雳铁手：开动加农炮对敌人子弹齐射，击中造成物理伤害并叠加降低护甲', '无目标');
INSERT INTO `chess` VALUES (84, '潮汐', 1, '潮汐猎人', '3', '17', 5, 84, 'npc_dota_hero_tidehunter_png.png', 'chess_th_png.png', 'tidehunter_ravage', '毁灭：猛击地面，触手向各个方向穿出，魔法伤害并眩晕附近最多6格内所有敌人', '无目标');
INSERT INTO `chess` VALUES (85, '谜团', 1, '谜团', '6', '24', 3, 85, 'npc_dota_hero_enigma_png.png', 'chess_enigma_png.png', 'midnight_pulse_datadriven', '午夜凋零：使一块3格区域浸入暗共振，对其中敌人持续造成基于最大生命值百分比的纯粹伤害', '点目标');
INSERT INTO `chess` VALUES (86, '宙斯', 1, '众神之王', '4', '28', 5, 86, 'npc_dota_hero_zuus_png.png', 'chess_zeus_png.png', 'zeus_thunder', '雷神之怒：用闪电打击同色格子上的敌人，造成目标剩余生命值百分比的魔法伤害', '无目标');
INSERT INTO `chess` VALUES (87, '大牛', 1, '上古巨神', '8', '28,31', 4, 87, 'npc_dota_hero_elder_titan_png.png', 'chess_et_png.png', 'et_earth_splitter', '裂地沟壑：向前方放出不平坦裂纹，塌陷时将敌人拉向中间造成眩晕，并造成双伤', '点目标');
INSERT INTO `chess` VALUES (88, '斯温', 1, '流浪剑客', '1', '23', 5, 88, 'npc_dota_hero_sven_png.png', 'chess_sven_png.png', 'sven_gods_strength', '碎神之力：被动-攻击对身后扇形敌人造成溅射伤害；主动-自身和邪能力量友军攻击力大幅提升', '无目标/被动');
INSERT INTO `chess` VALUES (89, '女王', 1, '痛苦女王', '2', '23', 5, 89, 'npc_dota_hero_queenofpain_png.png', 'chess_qop_png.png', 'queenofpain_sonic_wave_datadriven', '超声冲击波：制造强大的声波，对轨迹上所有敌人造成纯粹伤害，并使他们混乱', '点目标');
INSERT INTO `chess` VALUES (90, 'vs', 1, '复仇之魂', '13', '22,34', 2, 90, 'npc_dota_hero_vengefulspirit_png.png', 'chess_vs_png.png', 'vs_swap', '移形换位：与一个星级不高于技能等级的敌方棋子交换位置', '指向性');
INSERT INTO `chess` VALUES (91, 'warlock', 1, '术士', '6', '14', 5, 91, 'npc_dota_hero_warlock_png.png', 'chess_wl_png.png', 'wl_inferno', '混乱之祭：召唤若干个从天而降的地狱火，砸昏附近敌人，造成随机眩晕和纯粹伤害', '无目标');
INSERT INTO `chess` VALUES (92, '虚空', 1, '虚空假面', '2', '33', 2, 92, 'npc_dota_hero_faceless_void_png.png', 'chess_fv_png.png', 'fv_zhao_new', '逆转时空：在时空中创造遮罩，改变其中所有棋子的攻击和移动速度', '点目标');
INSERT INTO `chess` VALUES (93, '滚滚', 1, '石鳞剑士', '2', '20', 4, 93, 'npc_dota_hero_pangolier_png.png', 'chess_pangolier_png.png', 'pangolier_swashbuckle_datadriven', '虚张声势：滚向能攻击到敌人的空格子，对一个方向上的所有敌人刺出数剑', '点目标');
INSERT INTO `chess` VALUES (94, '电狗', 1, '天穹守望者', '10', '32', 5, 94, 'npc_dota_hero_arc_warden_png.png', 'chess_aw_png.png', 'arc_double', '风暴双雄：战斗回合开始前创造出一个自身的完美电子复制体', '战吼');
INSERT INTO `chess` VALUES (95, '松鼠', 1, '森海飞霞', '3', '20', 1, 95, 'npc_dota_hero_hoodwink_png.png', 'chess_hw_png.png', 'hoodwink_acorn_shot_datadriven', '爆栗出击：发射象栗并弹射给附近威胁较大的敌人，造成物理伤害并使其概率触发技能必触发', '指向性');
INSERT INTO `chess` VALUES (96, '马西', 1, '马西', '12', '15', 3, 96, 'npc_dota_hero_marci_png.png', 'chess_marci_png.png', 'marci_unleash', '怒拳破：放出隐藏力量，获得狂怒能量点数，发动快速打击，最后一击创造脉冲效果', '无目标');
INSERT INTO `chess` VALUES (97, '小娜迦', 1, '娜迦海妖', '9', '17', 2, 97, 'npc_dota_hero_naga_siren_png.png', 'chess_naga_png.png', 'siren_song', '海妖之歌：开始海妖的歌唱，范围内敌人每0.5秒概率陷入睡眠，非技能伤害会惊醒', '无目标');
INSERT INTO `chess` VALUES (98, '兽', 1, '原始巨兽', '1', '20', 5, 98, 'npc_dota_hero_primal_beast_png.png', 'chess_pb_png.png', 'primal_beast_pulverize_lua', '捶：抓起攻击范围内生命值最高的敌人，反复向地面捶击，对范围内敌人造成物理伤害和短暂眩晕', '指向性');
INSERT INTO `chess` VALUES (99, '幽鬼', 1, '幽鬼', '13', '22', 5, 99, 'npc_dota_hero_spectre_alt1_png.png', 'chess_spe_png.png', 'spe_haunt', '鬼影重重：在每个敌方棋子身后复制一个复仇鬼影攻击它们，普攻带荒芜效果', '无目标');
INSERT INTO `chess` VALUES (100, '骷髅王', 1, '冥魂大帝', '1', '22', 5, 100, 'npc_dota_hero_skeleton_king_png.png', NULL, 'skeletonking_reincarnation', '绝冥再生：光环-使附近等级不高于自身的友方棋子获得亡语：阵亡后原地复活一次', '光环');
INSERT INTO `chess` VALUES (101, '老鹿、拉席克', 1, '受折磨的灵魂', '8', '28,35', 5, 101, 'npc_dota_hero_leshrac_png.png', NULL, 'leshrac_pulse_nova', '脉冲新星：在周围创造破坏性的能量波，持续对附近敌人造成魔法伤害并消耗法力值', '无目标');
INSERT INTO `chess` VALUES (102, '痛苦，bane', 1, '祸乱之源', '6', '26,33', 1, 102, 'npc_dota_hero_bane_png.png', NULL, 'bane_fiends_grip', '魔爪：持续施法-抓住一个随机敌方棋子，使其失去行动能力并持续受到纯粹伤害', '指向性');
INSERT INTO `chess` VALUES (103, '暗影恶魔', 1, '暗影恶魔', '11', '23,36', 1, 103, 'npc_dota_hero_shadow_demon_png.png', NULL, 'sd_disseminate', '散播：对攻击目标施加诅咒，受到伤害时附近友军按百分比受伤，受到治疗时附近敌人按百分比受治疗', '指向性');
INSERT INTO `chess` VALUES (104, '天怒', 1, '天怒法师', '4', '34', 1, 104, 'npc_dota_hero_skywrath_mage_png.png', NULL, 'skywrath_mage_arcane_bolt_container', '奥法鹰隼：每当友方棋子施放技能，立即对敌人施放出缓慢移动的奥术鹰群，造成魔法伤害', '被动');
INSERT INTO `chess` VALUES (105, '小骷髅，骨弓', 1, '骷髅弓箭手', '3', '22', 1, 105, 'npc_dota_hero_clinkz_png.png', NULL, 'clinkz_burning_barrage', '炽烈火雨：持续朝攻击目标的方向射出多支灼热箭矢，击中一条线上的所有敌人', '点目标');
INSERT INTO `chess` VALUES (106, '奶绿', 1, '琼英碧灵', '3', '22', 2, 106, 'npc_dota_hero_muerta_png.png', NULL, 'muerta_pierce_the_veil', '越界：被动-攻击有几率再射一枪；主动-进入虚无形态，免疫物理伤害，所有攻击伤害为魔法伤害', '无目标/被动');
INSERT INTO `chess` VALUES (107, '小狗', 1, '噬魂鬼', '9', '22,32', 2, 107, 'npc_dota_hero_life_stealer_png.png', NULL, 'life_stealer_rage', '狂暴：进入狂暴状态，暂时获得魔法抗性加成，并免疫纯粹伤害', '无目标');
INSERT INTO `chess` VALUES (108, '大锤', 1, '破晓晨星', '5', '36', 3, 108, 'npc_dota_hero_dawnbreaker_png.png', NULL, 'dawnbreaker_fire_wreath', '星破天惊：将战锤旋转3次，对周围敌人造成普通攻击物理伤害，最后一击击向地面并眩晕前方敌人', '无目标');
INSERT INTO `chess` VALUES (109, '凯子', 1, '影舞者', '2', '34', 3, 109, 'npc_dota_hero_kez_png.png', NULL, 'kez_kazurai_katana_datadriven', '影武长刀：用长刀刺中攻击目标，使目标眩晕在原地，并造成基于最大生命值百分比的物理伤害', '指向性');
INSERT INTO `chess` VALUES (110, '尸王', 1, '不朽尸王', '11', '22', 3, 110, 'npc_dota_hero_undying_png.png', NULL, 'ud_decay', '腐朽：使指定的友方目标从附近敌方棋子身上吸取最大生命值，并造成纯粹伤害用于治疗目标', '指向性');
INSERT INTO `chess` VALUES (111, '猛犸', 1, '半人猛犸', '2', '35', 4, 111, 'npc_dota_hero_magnataur_png.png', NULL, 'mag_reverse_polarity', '两极反转：改变物质的属性，将附近的敌人都拖拽到他的前方，造成伤害和眩晕', '无目标');
INSERT INTO `chess` VALUES (112, '人马', 1, '半人马战行者', '1', '35', 2, 112, 'npc_dota_hero_centaur_png.png', NULL, 'ct_double_edge', '双刃剑：以猛烈力量进行近战攻击，对目标及其周围的棋子和自身造成基于最大生命值的魔法伤害', '指向性');
INSERT INTO `chess` VALUES (113, '兔子', 1, '黑暗贤者', '6', '36', 2, 113, 'npc_dota_hero_dark_seer_png.png', NULL, 'dark_seer_ion_shell', '离子外壳：将友方棋子用尖刺之盾包裹，减少受到的伤害，并对周围敌人持续造成魔法伤害', '指向性');
INSERT INTO `chess` VALUES (114, '紫猫', 1, '虚无之灵', '12', '30', 4, 114, 'npc_dota_hero_void_spirit_png.png', NULL, 'void_astralstep', '太虚之径：撕裂现实进入精神位面，穿行越过未被施加太虚印记的敌人，减速后延迟引爆造成魔法伤害', '无目标');
INSERT INTO `chess` VALUES (115, '小丑', 1, '百戏大王', '37', '', 5, 115, 'npc_dota_hero_ringmaster_png.png', NULL, 'ringmaster_spotlight', '聚光灯：灯光下的敌人会被致盲，隐身的敌人显形，非永久棋子被击中会逐渐消散', '点目标');
INSERT INTO `chess` VALUES (116, '大屁股', 1, '孽主', '6', '23', 5, 116, 'npc_dota_hero_abyssal_underlord_png.png', NULL, 'au_portal', '恶魔之扉：打开通往扭曲虚空的传送门，源源不断召唤星级相当于技能等级的随机恶魔棋子', '战吼');
INSERT INTO `chess` VALUES (119, '乐师，蛤蟆', 1, '朗戈', '12', '17', 2, 117, 'npc_dota_hero_largo_png.png', NULL, 'largo_frogstomp', '蛙力千钧：把小青蛙扔到一片区域，每秒践踏地面，造成伤害和短暂眩晕，区域内敌人移速减缓', '点目标');
INSERT INTO `chess` VALUES (120, '凤凰，伊卡洛斯', 1, '凤凰', '4', '24', 4, 118, 'npc_dota_hero_phoenix_png.png', NULL, 'phoenix_sun_ray', '烈日炙烤：凤凰以每秒损失自身一定百分比生命值为代价，向前射出一束炽热的光线。光线对敌人造成伤害，并能治疗友军。伤害和治疗量均由基础数值加上目标生命值的一定百分比构成，并且随着光线持续炙烤，百分比会不断增加。', '主动技能（立即激活）');
INSERT INTO `chess` VALUES (121, '冰魂，AA', 1, '极寒幽魂', '4', '24', 1, 119, 'npc_dota_hero_ancient_apparition_png.png', NULL, 'aa_ice_blast', '极寒之触：使远古冰魄的普通攻击具有攻击距离加成，被攻击到的敌人会被寒气侵蚀，攻击速度大幅下降并且无法回复生命值。', '被动技能');

-- ----------------------------
-- Table structure for fetter
-- ----------------------------
DROP TABLE IF EXISTS `fetter`;
CREATE TABLE `fetter`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '羁绊id',
  `type` tinyint(1) NOT NULL COMMENT '羁绊类型：0职业1种族',
  `majorId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '种族职业id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '羁绊名称',
  `condition` int(0) NOT NULL COMMENT '符合条件',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '羁绊描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 83 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fetter
-- ----------------------------
INSERT INTO `fetter` VALUES (1, 0, '1', '3战士', 3, '所有友方战士护甲+3');
INSERT INTO `fetter` VALUES (2, 0, '1', '6战士', 6, '所有友方战士护甲+11');
INSERT INTO `fetter` VALUES (3, 0, '1', '9战士', 9, '所有友军受到物理/魔法伤害时反弹（当前护甲×1.5）点纯粹伤害');
INSERT INTO `fetter` VALUES (4, 0, '2', '3刺客', 3, '所有友方刺客攻击有15%概率造成3倍伤害');
INSERT INTO `fetter` VALUES (5, 0, '2', '6刺客', 6, '所有友方刺客攻击有15%概率造成4倍伤害');
INSERT INTO `fetter` VALUES (6, 0, '2', '9刺客', 9, '所有友方刺客的背刺跳跃总是造成最高可能倍数的暴击伤害，每当击杀敌人或每15秒获得一次额外的背刺跳跃');
INSERT INTO `fetter` VALUES (7, 0, '3', '3猎人', 3, '猎人攻击有50%概率无视闪避，目标护甲-5，持续5秒');
INSERT INTO `fetter` VALUES (8, 0, '3', '6猎人', 6, '猎人攻击有100%概率无视闪避，目标护甲-10，持续10秒');
INSERT INTO `fetter` VALUES (9, 0, '3', '9猎人', 9, '精准射击击退敌人1格并发动一次额外攻击');
INSERT INTO `fetter` VALUES (10, 0, '4', '3法师', 3, '所有敌军魔法抗性-30%');
INSERT INTO `fetter` VALUES (11, 0, '4', '6法师', 6, '所有敌军魔法抗性-35%');
INSERT INTO `fetter` VALUES (12, 0, '4', '9法师', 9, '敌军受到魔法伤害时冻结，伤害越高冻结越长（0.5秒起）');
INSERT INTO `fetter` VALUES (13, 0, '5', '2骑士', 2, '骑士每3秒有25%概率获得减伤护盾');
INSERT INTO `fetter` VALUES (14, 0, '5', '4骑士', 4, '所有友军每3秒有25%概率获得减伤护盾');
INSERT INTO `fetter` VALUES (15, 0, '5', '6骑士', 6, '所有友军每3秒有25%概率获得减伤护盾，触发时额外+300治疗');
INSERT INTO `fetter` VALUES (16, 0, '6', '2术士', 2, '所有友军获得5%伤害吸血');
INSERT INTO `fetter` VALUES (17, 0, '6', '4术士', 4, '所有友军获得20%伤害吸血');
INSERT INTO `fetter` VALUES (18, 0, '6', '6术士', 6, '友方术士造成伤害时吸取目标50%生命值上限');
INSERT INTO `fetter` VALUES (19, 0, '7', '3工匠', 3, '主场获胜且有工匠存活，下回合获得机械之心');
INSERT INTO `fetter` VALUES (20, 0, '7', '6工匠', 6, '机械之心升级为金色');
INSERT INTO `fetter` VALUES (21, 0, '8', '2德鲁伊', 2, '2个★德鲁伊可合成为★★');
INSERT INTO `fetter` VALUES (22, 0, '8', '4德鲁伊', 4, '2个★★德鲁伊可合成为★★★');
INSERT INTO `fetter` VALUES (23, 0, '8', '6德鲁伊', 6, '2个★★★德鲁伊可合成为万灵祭坛，获得祭坛之力');
INSERT INTO `fetter` VALUES (24, 0, '9', '2巫师', 2, '4人以上羁绊需求-1');
INSERT INTO `fetter` VALUES (25, 0, '9', '3巫师', 3, '唯一羁绊解锁所有层数');
INSERT INTO `fetter` VALUES (26, 0, '10', '3萨满', 3, '施法后变形为等级+2的随机棋子');
INSERT INTO `fetter` VALUES (27, 0, '10', '6萨满', 6, '变形时装备也变为等级+2随机装备');
INSERT INTO `fetter` VALUES (28, 0, '11', '2牧师', 2, '主场战败受伤时，若棋子未满获得树之祭祀');
INSERT INTO `fetter` VALUES (29, 0, '11', '4牧师', 4, '每个牧师可精神控制一个不高于自身等级的敌方棋子');
INSERT INTO `fetter` VALUES (30, 0, '12', '2武僧', 2, '近战武僧有概率秒杀低生命值敌人');
INSERT INTO `fetter` VALUES (31, 0, '12', '4武僧', 4, '武僧有概率使敌人当前生命值减半');
INSERT INTO `fetter` VALUES (32, 0, '13', '2恶魔猎手', 2, '所有友方恶魔视为同一种类');
INSERT INTO `fetter` VALUES (33, 0, '13', '4恶魔猎手', 4, '友军造成的所有伤害结算为纯粹伤害');
INSERT INTO `fetter` VALUES (34, 1, '14', '2兽人', 2, '所有友军最大生命值+100');
INSERT INTO `fetter` VALUES (35, 1, '14', '4兽人', 4, '所有友军最大生命值+300');
INSERT INTO `fetter` VALUES (36, 1, '14', '6兽人', 6, '友军获得已损失生命值×10的最大生命值');
INSERT INTO `fetter` VALUES (37, 1, '15', '3精灵', 3, '精灵有25%闪避');
INSERT INTO `fetter` VALUES (38, 1, '15', '6精灵', 6, '精灵有40%闪避');
INSERT INTO `fetter` VALUES (39, 1, '15', '9精灵', 9, '闪避时隐身1秒并复制攻击者镜像');
INSERT INTO `fetter` VALUES (40, 1, '16', '3人类', 3, '准备回合获得2经验');
INSERT INTO `fetter` VALUES (41, 1, '16', '6人类', 6, '主场获胜且有1个人类存活，获得（信使等级-2）经验');
INSERT INTO `fetter` VALUES (42, 1, '17', '2娜迦', 2, '友军获得10%技能伤害护盾');
INSERT INTO `fetter` VALUES (43, 1, '17', '4娜迦', 4, '友军获得30%技能伤害护盾');
INSERT INTO `fetter` VALUES (44, 1, '17', '6娜迦', 6, '娜迦护盾每3秒对周围造成（吸收伤害）魔法伤害');
INSERT INTO `fetter` VALUES (45, 1, '18', '2巨魔', 2, '友军攻速+20%');
INSERT INTO `fetter` VALUES (46, 1, '18', '4巨魔', 4, '友军攻速+50%');
INSERT INTO `fetter` VALUES (47, 1, '18', '6巨魔', 6, '每次攻击命中攻速+20%，最多7层');
INSERT INTO `fetter` VALUES (48, 1, '19', '3地精', 3, '随机近战友军护甲+10，生命回复+20');
INSERT INTO `fetter` VALUES (49, 1, '19', '6地精', 6, '所有友军护甲+10，生命回复+20');
INSERT INTO `fetter` VALUES (50, 1, '20', '2野兽', 2, '友军攻击力+10%');
INSERT INTO `fetter` VALUES (51, 1, '20', '4野兽', 4, '友军攻击力+25%');
INSERT INTO `fetter` VALUES (52, 1, '20', '6野兽', 6, '物理攻击使敌人永久叠加10%物理易伤，最多10层');
INSERT INTO `fetter` VALUES (53, 1, '21', '2食人魔', 2, '食人魔开场吞噬相邻格不高于自身等级的友军，获得60%生命/攻击');
INSERT INTO `fetter` VALUES (54, 1, '22', '3亡灵', 3, '所有非亡灵生命上限-10%');
INSERT INTO `fetter` VALUES (55, 1, '22', '6亡灵', 6, '所有非亡灵生命上限-35%');
INSERT INTO `fetter` VALUES (56, 1, '22', '9亡灵', 9, '非亡灵每2秒生命上限-5%');
INSERT INTO `fetter` VALUES (57, 1, '23', '1恶魔', 1, '恶魔普攻为纯粹伤害，每同名友方恶魔+15%伤害，最多7层');
INSERT INTO `fetter` VALUES (58, 1, '24', '2元素', 2, '元素被近战攻击15%概率石化攻击者3秒');
INSERT INTO `fetter` VALUES (59, 1, '24', '4元素', 4, '全体友军被攻击10%概率石化攻击者3秒');
INSERT INTO `fetter` VALUES (60, 1, '25', '3龙', 3, '龙初始法力值100');
INSERT INTO `fetter` VALUES (61, 1, '25', '5龙', 5, '所有友军初始法力值100');
INSERT INTO `fetter` VALUES (62, 1, '27', '2矮人', 2, '所有友方远程矮人棋子获得效果：攻击距离+200，对敌人造成的任何物理伤害都会有每1格距离+15%的伤害加成');
INSERT INTO `fetter` VALUES (63, 1, '28', '2神', 2, '所有友方棋子技能冷却时间-30%');
INSERT INTO `fetter` VALUES (64, 1, '28', '4神', 4, '所有友方棋子技能冷却时间-30%（可叠加）');
INSERT INTO `fetter` VALUES (65, 1, '28', '6神', 6, '消耗法力值释放技能会使主动技能和物品的当前剩余冷却时间-60%');
INSERT INTO `fetter` VALUES (66, 1, '29', '2虫', 2, '使所有非虫族友方棋子获得亡语：如果场上有与它同名的被感染的友方棋子存活，原地孵化一只随机虫族棋子');
INSERT INTO `fetter` VALUES (67, 1, '29', '4虫', 4, '使所有友方虫族棋子也获得该亡语，并且孵化的虫族棋子等级相当于同名棋子最高等级+1');
INSERT INTO `fetter` VALUES (68, 1, '30', '1熊猫人', 1, '回合开始时有10%的概率邀请一个与场上友方棋子同种族的不在场棋子');
INSERT INTO `fetter` VALUES (69, 1, '30', '2熊猫人', 2, '回合开始时场上每个友方熊猫人棋子都有15%的概率邀请一个同名熊猫人棋子');
INSERT INTO `fetter` VALUES (70, 1, '31', '2牛头人', 2, '战斗开始时召唤一个稻草人图腾');
INSERT INTO `fetter` VALUES (71, 1, '31', '4牛头人', 4, '战斗开始时召唤一个啄木鸟图腾和一个蛮牛角图腾');
INSERT INTO `fetter` VALUES (72, 1, '32', '1狗头人', 1, '为每种两两相同的友方狗头人棋子召唤一个复制品');
INSERT INTO `fetter` VALUES (73, 1, '32', '2狗头人', 2, '为每种两两相同的友方非狗头人棋子召唤一个复制品');
INSERT INTO `fetter` VALUES (74, 1, '32', '3狗头人', 3, '友方狗头人棋子会将自己塑形为一个同星的非狗头人友方棋子，以凑成两两相同。');
INSERT INTO `fetter` VALUES (75, 1, '33', '1无面者', 1, '除无面者以外，如果你没有触发任何种族/职业技能，全体友军获得效果：免疫所有战斗时产生的不良状态');
INSERT INTO `fetter` VALUES (76, 1, '34', '2鹰身人', 2, '所有友方棋子获得效果：对敌人施放的指向性法术+1目标数量');
INSERT INTO `fetter` VALUES (77, 1, '34', '4鹰身人', 4, '所有友方棋子获得效果：对敌人施放的指向性法术+1目标数量');
INSERT INTO `fetter` VALUES (78, 1, '35', '2半人马', 2, '所有友方半人马棋子获得效果：开始战斗时立即冲锋到周围敌方棋子最多的目标格子，并撞晕路径上的敌方棋子');
INSERT INTO `fetter` VALUES (79, 1, '35', '4半人马', 4, '所有近战友方棋子的每次移动都是奔袭冲撞');
INSERT INTO `fetter` VALUES (80, 1, '36', '2德莱尼', 2, '每5秒从最近的敌方棋子偷取（50+2%%最大生命值）点生命值治疗自己');
INSERT INTO `fetter` VALUES (81, 1, '36', '4德莱尼', 4, '所有友方棋子获得效果：每当累计受到超过100点治疗会对周围敌人造成等于（累计治疗量）的纯粹伤害');
INSERT INTO `fetter` VALUES (82, 1, '41', '1远古', 1, '免疫精神控制，并且累计受到一定量的伤害会自动驱散自身的所有负面状态');
INSERT INTO `fetter` VALUES (83, 1, '24', '6元素', 6, ' 石化的持续时间延长1秒，并且被石化的敌人受到的所有伤害+100%。');

-- ----------------------------
-- Table structure for item
-- ----------------------------
DROP TABLE IF EXISTS `item`;
CREATE TABLE `item`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '装备名称',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '装备代码',
  `level` int(0) NOT NULL COMMENT '装备等级（1-5）',
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '装备类型：普通/圣物/消耗品',
  `desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '装备描述',
  `isuse` tinyint(1) NULL DEFAULT 1 COMMENT '是否在用',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图标',
  `recipe` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '合成配方',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 92 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of item
-- ----------------------------
INSERT INTO `item` VALUES (1, '力量护腕', 'item_lilianghuwan', 1, '普通', '生命值+300', 1, 'bracer_png.png', NULL);
INSERT INTO `item` VALUES (2, '怨灵系带', 'item_yuanlingxidai', 1, '普通', '攻击速度+20%', 1, 'wraith_band_png.png', NULL);
INSERT INTO `item` VALUES (3, '空灵挂件', 'item_konglingguajian', 1, '普通', '魔法伤害+20%', 1, 'null_talisman_png.png', NULL);
INSERT INTO `item` VALUES (4, '水晶剑', 'item_shuijingjian', 1, '普通', '攻击有20%概率造成2倍暴击', 1, 'lesser_crit_png.png', NULL);
INSERT INTO `item` VALUES (5, '碎颅锤', 'item_suiluchui', 1, '普通', '近战携带者攻击有20%概率击晕目标2秒', 1, 'basher_png.png', NULL);
INSERT INTO `item` VALUES (6, '玄冥盾牌', 'item_xuanmingdunpai', 1, '普通', '护甲+5', 1, 'buckler_png.png', NULL);
INSERT INTO `item` VALUES (7, '蛛丝斗篷', 'item_zhusidoupeng', 1, '普通', '携带者和它的召唤物获得效果：魔法抗性+25%，免疫精神控制', 1, 'gossamer_cape_png.png', NULL);
INSERT INTO `item` VALUES (8, '王者之戒', 'item_wangzhezhijie', 1, '普通', '法力获取+50%', 1, 'ring_of_basilius_png.png', NULL);
INSERT INTO `item` VALUES (9, '腐蚀之球', 'item_fushizhiqiu', 1, '普通', '攻击目标护甲-5', 1, 'orb_of_corrosion_png.png', NULL);
INSERT INTO `item` VALUES (10, '勇气之光', 'item_yongqizhiguang', 1, '普通', '携带者对等级高于自己的敌方棋子造成的伤害+25%', 1, 'spark_of_courage_png.png', NULL);
INSERT INTO `item` VALUES (11, '幸运挂坠', 'item_xingyunguazhui', 1, '普通', '携带者概率触发的种族/职业技能效果触发概率+30%', 1, 'item_custom/item_slark_fish_bait.png', NULL);
INSERT INTO `item` VALUES (12, '凌厉长鞭', 'item_linglichangbian', 1, '普通', '携带者召唤的棋子获得效果：攻击速度+100%，持续时间+100%', 1, 'bullwhip_png.png', NULL);
INSERT INTO `item` VALUES (13, '迈达斯之手', 'item_dianjinshou', 1, '普通', '主动：立即消灭一个生命值低于携带者的召唤物或幻象。如果是主场作战，同时会掉落1个金币', 1, 'hand_of_midas_png.png', NULL);
INSERT INTO `item` VALUES (14, '原力法杖', 'item_yuanlifazhang', 1, '普通', '魔法伤害+10%。主动：将携带者推送到一个不能被敌方攻击到的安全格子，并且回复20点法力值', 1, 'force_staff_png.png', NULL);
INSERT INTO `item` VALUES (15, '闪烁匕首', 'item_tiaodao', 1, '普通', '主动：瞬间移动到范围内能攻击到敌人的最远的格子', 1, 'blink_png.png', NULL);
INSERT INTO `item` VALUES (16, '无知小帽', 'item_wuzhixiaomao', 1, '普通', '魔法抗性+25%，携带者视为+1等级', 1, 'witless_shako_png.png', NULL);
INSERT INTO `item` VALUES (17, '纷争面纱', 'item_fenzhengmiansha', 1, '普通', '主动：使周围敌人的魔法抗性-25%，持续10秒', 1, 'veil_of_discord_png.png', NULL);
INSERT INTO `item` VALUES (18, '阿托斯之棍', 'item_atuosi', 1, '普通', '攻击速度+10%。主动：缠绕一个随机的敌方近战棋子，使其不能移动，持续4秒', 1, 'rod_of_atos_png.png', NULL);
INSERT INTO `item` VALUES (21, '漩涡', 'item_xuanwo', 2, '普通', '攻击速度+10%。攻击有20%概率打出一道叉状闪电，对最多3个敌人造成100点魔法伤害', 1, 'maelstrom_png.png', 'item_shuijingjian;item_yuanlingxidai');
INSERT INTO `item` VALUES (22, '亲王短刀', 'item_qinwangduandao', 2, '普通', '攻击力+25。携带者对同种族/职业的敌方棋子造成的伤害+50%', 1, 'princes_knife_png.png', NULL);
INSERT INTO `item` VALUES (23, '慧光', 'item_huiguang', 2, '普通', '法力获取+25%，魔法伤害+30%', 1, 'kaya_png.png', 'item_konglingguajian;item_wangzhezhijie');
INSERT INTO `item` VALUES (24, '阿哈利姆魔晶', 'item_ahalimumojing', 2, '普通', '法力获取+75%。携带者会永久获得一个随机的敌方棋子的主动技能作为自己的额外技能', 1, 'aghanims_shard_png.png', NULL);
INSERT INTO `item` VALUES (25, '疯狂面具', 'item_fengkuangmianju', 2, '普通', '沉默自己，攻击吸血+25%，攻击速度+20%', 1, 'mask_of_madness_png.png', 'item_lilianghuwan;item_yuanlingxidai');
INSERT INTO `item` VALUES (26, '刃甲', 'item_renjia', 2, '普通', '护甲+5。主动：开启尖刺，将受到的所有伤害反弹为50%的纯粹伤害，持续7秒', 1, 'blade_mail_png.png', 'item_xuanmingdunpai;item_suiluchui');
INSERT INTO `item` VALUES (27, '先锋盾', 'item_xianfengdun', 2, '普通', '物理格挡+25。近战携带者有50%概率额外+25物理格挡', 1, 'vanguard_png.png', 'item_lilianghuwan;item_lilianghuwan');
INSERT INTO `item` VALUES (28, '长盾', 'item_changdun', 2, '普通', '护甲+5。每当主场战斗时持有者首次受到伤害，有概率永久获得+1护甲', 1, 'pavise_png.png', 'item_xuanmingdunpai;item_fushizhiqiu');
INSERT INTO `item` VALUES (29, '挑战头巾', 'item_tiaozhantoujin', 2, '普通', '魔法抗性+50%', 1, 'hood_of_defiance_png.png', 'item_konglingguajian;item_zhusidoupeng');
INSERT INTO `item` VALUES (30, '弗拉迪米尔的祭品', 'item_jipin', 2, '普通', '光环：周围范围内的友军获得效果：攻击吸血+25%', 1, 'vladmir_png.png', 'item_wangzhezhijie;item_lilianghuwan');
INSERT INTO `item` VALUES (31, '魔瓶', 'item_moping', 2, '普通', '法力值+50', 1, 'bottle_png.png', NULL);
INSERT INTO `item` VALUES (32, '望远镜', 'item_wangyuanjing', 2, '普通', '视为矮人', 1, 'item_custom/telescope.png', NULL);
INSERT INTO `item` VALUES (33, '网虫腿', 'item_wangchongtui', 2, '普通', '闪避+25%。携带者视为虫，并且加入友方虫族感染的随机召唤池', 1, 'spider_legs_png.png', 'item_zhusidoupeng;item_fushizhiqiu');
INSERT INTO `item` VALUES (34, '飞僵小帽', 'item_feijiangxiaomao', 2, '普通', '魔法抗性+25%，非亡灵携带者获得效果：回合开始时有概率被转化为一个同费同星的随机亡灵棋子，90%-50%随费用递减', 1, 'ascetic_cap_png.png', 'item_wuzhixiaomao;item_linglichangbian');
INSERT INTO `item` VALUES (35, '静谧鞋', 'item_jingmixie', 2, '普通', '快速移动，携带者使范围内的友军每2秒获得20点治疗', 1, 'tranquil_boots_png.png', NULL);
INSERT INTO `item` VALUES (36, '奥术鞋', 'item_aoshuxie', 2, '普通', '快速移动。主动：为范围内全体友军回复40点法力值', 1, 'arcane_boots_png.png', NULL);
INSERT INTO `item` VALUES (37, '残铁', 'item_cantie', 2, '普通', '攻击力+25。该物品等级视为3', 1, 'item_custom/jushencantie.png', NULL);
INSERT INTO `item` VALUES (41, '银月之晶', 'item_yinyuezhijing', 3, '普通', '攻击速度+50%', 1, 'moon_shard_png.png', 'item_yuanlingxidai;item_yuanlingxidai;item_yuanlingxidai');
INSERT INTO `item` VALUES (42, '黯灭', 'item_anmie', 3, '普通', '攻击力+25。使被攻击的敌人护甲-10', 1, 'desolator_png.png', 'item_fushizhiqiu;item_fushizhiqiu;item_qinwangduandao');
INSERT INTO `item` VALUES (43, '净魂之刃', 'item_jinghunzhiren', 3, '普通', '攻击速度+30%。主动：对当前攻击目标施加净化，移除所有种族/职业增益效果', 1, 'diffusal_blade_png.png', 'item_yuanlingxidai;item_yuanlingxidai;item_wangzhezhijie');
INSERT INTO `item` VALUES (44, '天堂之戟', 'item_tiantangzhiji', 3, '普通', '闪避+25%。主动：使一个攻击力最高的敌方棋子缴械，持续6秒', 1, 'heavens_halberd_png.png', 'item_xianfengdun;item_yuanlingxidai;item_yuanlingxidai');
INSERT INTO `item` VALUES (45, '三叉戟', 'item_sanchaji', 3, '普通', '攻击力+25。同时对最多2个伤害目标的同名棋子造成50%的伤害', 1, 'trident_png.png', 'item_qinwangduandao;item_xuanwo;item_huiguang');
INSERT INTO `item` VALUES (46, '骑士剑', 'item_qishijian', 3, '普通', '攻击力+25，攻击吸血+25%。携带者对恶魔和亡灵造成的伤害+50%', 1, 'paladin_sword_png.png', NULL);
INSERT INTO `item` VALUES (47, '梅肯斯姆', 'item_meiken', 3, '普通', '主动：范围内所有友军获得500点治疗', 1, 'mekansm_png.png', 'item_xuanmingdunpai;item_xuanmingdunpai;item_jipin');
INSERT INTO `item` VALUES (48, '赤红甲', 'item_chihongjia', 3, '普通', '护甲+5，物理格挡+25。主动：使范围内所有友军护甲+5，物理格挡+50，持续8秒', 1, 'crimson_guard_png.png', 'item_xianfengdun;item_xuanmingdunpai;item_renjia');
INSERT INTO `item` VALUES (49, '洞察烟斗', 'item_dongchayandou', 3, '普通', '魔法抗性+50%，生命回复+10。主动：使范围内所有友军获得：魔法抗性+50%，生命回复+10，持续10秒', 1, 'pipe_png.png', 'item_tiaozhantoujin;item_tiaozhantoujin;item_wangzhezhijie');
INSERT INTO `item` VALUES (50, '韧鼓', 'item_rengu', 3, '普通', '光环：周围范围内的友军获得效果：攻击速度+35%', 1, 'ancient_janggo_png.png', 'item_yuanlingxidai;item_wangzhezhijie;item_lilianghuwan');
INSERT INTO `item` VALUES (51, '希瓦之守护', 'item_xiwa', 3, '普通', '护甲+10。主动：发出一道寒冷的波动，使3格内的敌人攻击速度-50%，受到的治疗-50%，持续5秒，并造成100点魔法伤害', 1, 'shivas_guard_png.png', 'item_xuanmingdunpai;item_xuanmingdunpai;item_xuanmingdunpai');
INSERT INTO `item` VALUES (52, '林肯法球', 'item_linkenfaqiu', 3, '普通', '生命值+300，法力获取+100%。抵挡指向性法术或物品', 1, 'sphere_png.png', 'item_wangzhezhijie;item_wangzhezhijie;item_wangzhezhijie');
INSERT INTO `item` VALUES (53, '血精石', 'item_xuejingshi', 3, '普通', '生命值+600。每当主场的敌方棋子阵亡，持有者都有20%的概率获得1点能量点数，每点能量点数会提高15%持有者造成的魔法伤害。亡语：损失一半的能量点数', 1, 'bloodstone_png.png', 'item_huiguang;item_huiguang;item_renjia');
INSERT INTO `item` VALUES (54, '不朽之守护', 'item_buxiuzhishouhu', 3, '普通', '生命值+600。亡语：原地复活一次', 1, 'aegis_png.png', NULL);
INSERT INTO `item` VALUES (55, '法术棱镜', 'item_fashulengjing', 3, '普通', '魔法伤害+20%。对敌方施放的指向性法术或物品的目标数量+1', 1, 'spell_prism_png.png', 'item_konglingguajian;item_konglingguajian;item_huiguang');
INSERT INTO `item` VALUES (56, '艾维娜之羽', 'item_aiweinazhiyu', 3, '普通', '携带者造成的所有伤害都视为魔法伤害', 1, 'avianas_feather_png.png', 'item_konglingguajian;item_fengkuangmianju');
INSERT INTO `item` VALUES (61, '辉耀', 'item_huiyao', 4, '普通', '闪避+25%。光环：对周围的敌人每3秒造成100点纯粹伤害并使其有25%概率攻击落空', 1, 'radiance_png.png', 'item_yongqizhiguang;item_xingyunguazhui;item_xuanwo');
INSERT INTO `item` VALUES (62, '金箍棒', 'item_jingubang', 4, '普通', '攻击速度+40%。攻击无法被闪避并额外造成50点魔法伤害', 1, 'monkey_king_bar_png.png', 'item_shuijingjian;item_xuanwo;item_yuanlingxidai');
INSERT INTO `item` VALUES (63, '蝴蝶', 'item_hudie', 4, '普通', '闪避+40%，攻击速度+30%。主动：受伤时激活，在6秒内蝴蝶提供的加成翻倍', 1, 'butterfly_png.png', 'item_yuanlingxidai;item_yuanlingxidai;item_yuanlingxidai;item_tiaodao');
INSERT INTO `item` VALUES (64, '血棘', 'item_xueji', 4, '普通', '攻击速度+20%。主动：使一个攻击范围内等级最高的敌方棋子沉默，并获得效果：受到的任何攻击都会造成2倍的暴击，并使攻击范围内的友方棋子都倾向于攻击此目标，持续6秒', 1, 'bloodthorn_png.png', 'item_shuijingjian;item_jinghunzhiren;item_fengkuangmianju');
INSERT INTO `item` VALUES (65, '黑皇杖', 'item_bkb', 4, '普通', '生命值+600。主动：驱散自身的不良状态，并获得75%魔法抗性和技能免疫，持续4秒', 1, 'black_king_bar_png.png', 'item_lilianghuwan;item_lilianghuwan;item_lilianghuwan;item_tiaozhantoujin');
INSERT INTO `item` VALUES (66, '巨人之戒', 'item_jurenzhijie', 4, '普通', '魔法抗性+25%，物理格挡+100，永久嘲讽', 1, 'giants_ring_png.png', NULL);
INSERT INTO `item` VALUES (67, '深渊之刃', 'item_dayunchui', 4, '普通', '攻击力+50。主动：将一个近身的敌方棋子击晕5秒，并造成100点纯粹伤害，无视技能免疫', 1, 'abyssal_blade_png.png', 'item_suiluchui;item_suiluchui;item_tiaodao');
INSERT INTO `item` VALUES (68, '缚灵索', 'item_fulingsuo', 4, '普通', '攻击速度+30%。主动：缠绕等级最高的敌方棋子2格范围的所有敌方棋子，使其不能移动，持续4秒，并造成100点魔法伤害', 1, 'gungir_png.png', 'item_xuanwo;item_xuanwo;item_atuosi');
INSERT INTO `item` VALUES (69, '狂战斧', 'item_kuangzhanfu', 4, '普通', '攻击力+50。近战攻击会对1格范围内的其他敌人造成50%的溅射伤害', 1, 'bfury_png.png', 'item_shuijingjian;item_suiluchui;item_qinwangduandao');
INSERT INTO `item` VALUES (70, '幻影斧', 'item_huanyingfu', 4, '普通', '攻击力+25。主动：复制两个自身的镜像棋子，持续7秒', 1, 'manta_png.png', 'item_yuanlingxidai;item_yuanlingxidai;item_jinghunzhiren');
INSERT INTO `item` VALUES (71, '达贡之神力', 'item_hongzhang', 4, '普通', '魔法伤害+40%。主动：对一个随机敌方棋子造成700点魔法伤害', 1, 'dagon_4_png.png', 'item_konglingguajian;item_konglingguajian;item_ahalimumojing');
INSERT INTO `item` VALUES (72, '刷新球', 'item_shuaxinqiu', 4, '普通', '法力获取+200%。主动：立即刷新棋子技能和其他物品的冷却时间', 1, 'refresher_png.png', 'item_jinghunzhiren;item_huiguang;item_pers');
INSERT INTO `item` VALUES (73, '古龙号角', 'item_gulonghaojiao', 4, '普通', '携带者视为龙，并且初始法力值为100', 1, 'minotaur_horn_png.png', NULL);
INSERT INTO `item` VALUES (74, '死灵书', 'item_minglingshu', 4, '普通', '使你的召唤物获得效果：召唤数量+1。主动：召唤2个死灵士兵为你战斗', 1, 'necronomicon_3_png.png', 'item_wangchongtui;item_wangzhezhijie;item_linglichangbian');
INSERT INTO `item` VALUES (75, '卫士胫甲', 'item_weishijingjia', 4, '普通', '快速移动。主动：使范围内所有友军获得500点最大生命值和30点法力值，同时驱散战斗时产生的不良状态', 1, 'guardian_greaves_png.png', 'item_jingmixie;item_aoshuxie;item_meiken');
INSERT INTO `item` VALUES (81, '圣剑', 'item_shengjian', 5, '普通', '基础攻击力+350，技能伤害+25%。如果主场战败且信使受到伤害，则会掉落给一个随机其他玩家。不可被重铸', 1, 'rapier_png.png', 'item_dapao;item_anmie');
INSERT INTO `item` VALUES (82, '代达罗斯之殇', 'item_dapao', 5, '普通', '攻击力+75。攻击有20%概率造成4倍暴击', 1, 'greater_crit_png.png', 'item_shuijingjian;item_shuijingjian;item_demagicking');
INSERT INTO `item` VALUES (83, '雷神之锤', 'item_dadianchui', 5, '普通', '攻击速度+60%。攻击或被攻击有20%概率打出一道叉状闪电，对最多5个敌人造成200点魔法伤害', 1, 'mjollnir_png.png', 'item_xuanwo;item_xuanwo;item_xuanwo');
INSERT INTO `item` VALUES (84, '浩劫', 'item_haojie', 5, '普通', '攻击力+50。携带者造成的所有伤害都结算为纯粹伤害', 1, 'item_custom/haojie.png', 'item_kuangzhanfu;item_jingubang');
INSERT INTO `item` VALUES (85, '斯嘉蒂之眼', 'item_bingyan', 5, '普通', '生命值+600。任何受到持有者伤害的目标都会获得效果：攻击速度、攻击力、移动速度、法力获取和受到治疗-50%', 1, 'skadi_png.png', 'item_lilianghuwan;item_xuejingshi;item_xiwa');
INSERT INTO `item` VALUES (86, '阿哈利姆神杖', 'item_ahalimushenzhang', 5, '普通', '魔法伤害+40%。携带者的棋子技能等级+1', 1, 'ultimate_scepter_png.png', 'item_fashulengjing;item_fashulengjing;item_shuaxinqiu');
INSERT INTO `item` VALUES (87, '邪恶镰刀', 'item_yangdao', 5, '普通', '魔法伤害+60%。主动：使一个等级最高的敌方棋子变成可爱的小动物，持续5秒', 1, 'sheepstick_png.png', 'item_fengkuangmianju;item_tiaodao;item_jinghunzhiren');
INSERT INTO `item` VALUES (88, '撒旦之邪力', 'item_sadan', 5, '普通', '生命值+600，攻击吸血+50%。主动：受伤时激活，在6秒内+150%吸血', 1, 'satanic_png.png', 'item_lilianghuwan;item_fengkuangmianju;item_anmie');
INSERT INTO `item` VALUES (89, '强袭胸甲', 'item_qiangxi', 5, '普通', '护甲+15，攻击速度+20%。光环：周围友军护甲+10。光环：周围敌军护甲-10', 1, 'assault_png.png', 'item_renjia;item_chihongjia;item_rengu');
INSERT INTO `item` VALUES (90, '永恒之盘', 'item_yonghengzhipan', 5, '普通', '携带者和它的变身形态/召唤物始终视为永久棋子。主动：濒死时激活，免疫所有伤害，持续3.5秒', 1, 'aeon_disk_png.png', 'item_buxiuzhishouhu;item_xuejingshi;item_linkenfaqiu');
INSERT INTO `item` VALUES (91, '神镜盾', 'item_shenjingdun', 5, '普通', '物理格挡+60。50%概率反弹受到的所有伤害和指向性法术', 1, 'mirror_shield_png.png', 'item_xianfengdun;item_renjia;item_hudie');
INSERT INTO `item` VALUES (92, '食人魔之帽', 'item_shirenmozhimao', 5, '普通', '生命值+900，魔法抗性+25%。携带者视为+2等级的食人魔', 1, 'item_custom/shirenmozhimao.png', 'item_wuzhixiaomao;item_feijiangxiaomao;item_ogre');

-- ----------------------------
-- Table structure for item_consumable
-- ----------------------------
DROP TABLE IF EXISTS `item_consumable`;
CREATE TABLE `item_consumable`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '消耗品名称',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '消耗品代码',
  `level` int(0) NULL DEFAULT 0 COMMENT '等级',
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '消耗品' COMMENT '类型',
  `desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '消耗品描述',
  `isuse` tinyint(1) NULL DEFAULT 1 COMMENT '是否在用',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of item_consumable
-- ----------------------------
INSERT INTO `item_consumable` VALUES (1, '一袋金币', 'item_money', 0, '消耗品', '信使消耗品：拾取激活，获得一定数量的金币', 1);
INSERT INTO `item_consumable` VALUES (2, '树之祭祀', 'item_chishu', 1, '消耗品', '信使消耗品：点击食用，摧毁一棵树木，为你的信使随机回复（1～8）点生命值', 1);
INSERT INTO `item_consumable` VALUES (3, '树之祭祀', 'item_chishu_new', 2, '消耗品', '信使消耗品：点击食用，摧毁一棵树木，为你的信使随机回复（1～8）点生命值', 1);
INSERT INTO `item_consumable` VALUES (4, '蜂王浆护盾', 'item_fengwangjiang', 2, '消耗品', '信使消耗品：能抵挡至少1点伤害时自动激活，消耗一个蜂王浆护盾，使你的信使本回合内受到的伤害-20%', 1);
INSERT INTO `item_consumable` VALUES (5, '魔法芒果', 'item_mangguo', 2, '消耗品', '信使消耗品：点击食用，为你的信使随机获得（1～信使当前等级）的金币和经验值', 1);
INSERT INTO `item_consumable` VALUES (6, '金色魔法芒果', 'item_pingguo', 4, '消耗品', '信使消耗品：受到致死伤害时自动激活，消耗一个金色魔法芒果，使你的信使本回合免疫致死伤害', 1);
INSERT INTO `item_consumable` VALUES (7, '知识之书', 'item_zhishizhishu', 2, '消耗品', '信使消耗品：点击激活，为你的信使增加2点经验值，并且增加的经验值可以突破信使最大等级10的限制', 1);
INSERT INTO `item_consumable` VALUES (8, '诡计之雾', 'item_guijizhiwu', 2, '消耗品', '这是一个供信使用的消耗品，点击使用：释放大雾隐藏你的棋盘，跳过下一回合的主场战斗', 1);

-- ----------------------------
-- Table structure for item_lootbox
-- ----------------------------
DROP TABLE IF EXISTS `item_lootbox`;
CREATE TABLE `item_lootbox`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '代币名称',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '代币代码',
  `level` int(0) NOT NULL COMMENT '代币等级（1-5）',
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '消耗品' COMMENT '类型',
  `desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '代币描述',
  `isuse` tinyint(1) NULL DEFAULT 1 COMMENT '是否在用',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of item_lootbox
-- ----------------------------
INSERT INTO `item_lootbox` VALUES (1, '战利品代币 等级1', 'item_lootbox_lv1', 1, '消耗品', '信使消耗品：点击打开，获得随机的3件当前等级的物品，你可以从中挑选1件加入你的背包', 1);
INSERT INTO `item_lootbox` VALUES (2, '战利品代币 等级2', 'item_lootbox_lv2', 2, '消耗品', '信使消耗品：点击打开，获得随机的3件当前等级的物品，你可以从中挑选1件加入你的背包', 1);
INSERT INTO `item_lootbox` VALUES (3, '战利品代币 等级3', 'item_lootbox_lv3', 3, '消耗品', '信使消耗品：点击打开，获得随机的3件当前等级的物品，你可以从中挑选1件加入你的背包', 1);
INSERT INTO `item_lootbox` VALUES (4, '战利品代币 等级4', 'item_lootbox_lv4', 4, '消耗品', '信使消耗品：点击打开，获得随机的3件当前等级的物品，你可以从中挑选1件加入你的背包', 1);
INSERT INTO `item_lootbox` VALUES (5, '战利品代币 等级5', 'item_lootbox_lv5', 5, '消耗品', '信使消耗品：点击打开，获得随机的3件当前等级的物品，你可以从中挑选1件加入你的背包', 1);
INSERT INTO `item_lootbox` VALUES (6, '圣物宝箱', 'item_relicbox', 0, '消耗品', '信使消耗品：点击打开，获得随机的3件圣物，你可以从中挑选1件加入你的背包。已装备的圣物将在下次圣物回合的战斗回合结束时过期', 1);
INSERT INTO `item_lootbox` VALUES (7, '失窃的宝库', 'item_stolen_vault', 0, '消耗品', '放弃本次选择圣物，立刻随机获得10～15金币', 1);

-- ----------------------------
-- Table structure for item_relic
-- ----------------------------
DROP TABLE IF EXISTS `item_relic`;
CREATE TABLE `item_relic`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '圣物名称',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '圣物代码',
  `level` int(0) NULL DEFAULT 0 COMMENT '圣物等级',
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '圣物' COMMENT '类型',
  `desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '圣物描述',
  `image_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '圣物图片路径',
  `isuse` tinyint(1) NULL DEFAULT 1 COMMENT '是否在用',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of item_relic
-- ----------------------------
INSERT INTO `item_relic` VALUES (1, '哼哼井武器匠', 'item_upgrade_lootbox', 0, '圣物', '你重铸装备获得的战利品代币的等级+1。武器匠累计重铸2次战利品代币后就会离去', 'item_custom/哼哼井武器匠.png', 1);
INSERT INTO `item_relic` VALUES (2, '明暗终途', 'item_streak_plus', 0, '圣物', '你的连胜/连败不会中断。圣物消失时将根据持有期间最高的奖励/补偿和本局已选取圣物数量获得一个战利品代币', 'item_custom/明暗终途2.png', 1);
INSERT INTO `item_relic` VALUES (3, '帷幕', 'item_conceal_prepare', 0, '圣物', '在准备回合隐匿棋盘上的棋子。当你的信使受到伤害时，下个非战利品回合会同时隐匿信使并跳过战斗阶段', 'item_custom/帷幕2.png', 1);
INSERT INTO `item_relic` VALUES (4, '狱卒的钥匙', 'item_free_ban', 0, '圣物', '你可以免费屏蔽任意种族/职业。如果已经屏蔽，则返还所花费的金币', 'item_custom/狱卒的钥匙2.png', 1);
INSERT INTO `item_relic` VALUES (5, '第二次机会', 'item_second_chance', 0, '圣物', '当你使用选项类消耗性物品，或每回合开始自动招募棋子时有机会刷新一次选项面板，获取其他的选择', 'item_custom/第二次机会.png', 1);
INSERT INTO `item_relic` VALUES (6, '贪魔蛋', 'item_egg', 0, '圣物', '将一个棋子放进蛋中，每个回合开始时蛋都有概率长大，你可以随时出售蛋并重新孵化出该棋子，它的星级取决于蛋的大小', 'precious_egg_png.png', 1);
INSERT INTO `item_relic` VALUES (7, '魔法种子', 'item_bench_contract', 0, '圣物', '用菜苗填满你的等待席，回合开始时每颗菜的出售价值都有概率+1。你可以随时出售它们而启用等待席', 'item_custom/item_magic_seed.png', 1);
INSERT INTO `item_relic` VALUES (8, '芒果树', 'item_mangotree', 0, '圣物', '在你的棋盘旁边种植一棵芒果树。每当你主场的战斗结果和上一回合不同，就会掉落1个魔法芒果，累计掉落8个后芒果树会枯萎', 'mango_tree_png.png', 1);
INSERT INTO `item_relic` VALUES (9, '百兽大游行', 'item_more_creep', 0, '圣物', '你在战利品回合迎战的野怪数量×2，并且视为等级+1', 'item_custom/more_creep.png', 1);
INSERT INTO `item_relic` VALUES (10, '灾难狂欢', 'item_malefic_rapture', 0, '圣物', '当你的信使受到伤害时，立即获得（受到的伤害）点经验值', 'item_custom/zainankuanghuan.png', 1);
INSERT INTO `item_relic` VALUES (11, '奇观轮', 'item_rm_wheel_of_wonder', 0, '圣物', '指定一个友方棋子投入奇观轮，从它的五个获得额外种族或职业的同名棋子中进行一次发现', 'item_custom/rm_wheel_of_wonder.png', 1);
INSERT INTO `item_relic` VALUES (12, '复叶精魂', 'item_both_leaves', 0, '圣物', '在本局游戏中，你会自动解锁天赋树的另一边天赋', 'seeds_of_serenity_png.png', 1);
INSERT INTO `item_relic` VALUES (13, '魔术箱', 'item_magic_box', 0, '圣物', '指定一个等待席上的友方棋子，在下一回合开始时将它们变成同等级同星的其他棋子。可以使用12次', 'item_custom/magic_box.png', 1);
INSERT INTO `item_relic` VALUES (14, '双面币', 'item_double_coin', 0, '圣物', '如果你的生命值大于金币数，将当前生命值的20%转化为金币；如果你的生命值小于金币数，将当前金币的20%转化为生命值。可以使用2次', 'doubloon_png.png', 1);
INSERT INTO `item_relic` VALUES (15, '复刻时空', 'item_repeat_relic', 0, '圣物', '重复使用你的上一个圣物。如果你没有上一个圣物，复刻时空将随机一个圣物，并且该圣物不被视为已选择过', 'item_custom/repeat_relic.png', 1);
INSERT INTO `item_relic` VALUES (16, '大魔导师的袖里乾坤', 'item_copy_synergy', 0, '圣物', '随机获得一张命运卡牌或者机会卡牌，可以指定一个棋子使它从最近的其他种族/职业的棋子永久获得一个额外的种族/职业', 'creed_of_omniscience_png.png', 0);
INSERT INTO `item_relic` VALUES (17, '魔术卡牌：命运', 'item_card_fate', 0, '圣物', '准备回合对一个棋子使用，使它从最近的其他种族棋子永久获得一个额外的种族', 'item_custom/card_fate.png', 0);
INSERT INTO `item_relic` VALUES (18, '魔术卡牌：机会', 'item_card_chance', 0, '圣物', '准备回合对一个棋子使用，使它从最近的其他职业棋子永久获得一个额外的职业', 'item_custom/card_chance.png', 0);
INSERT INTO `item_relic` VALUES (19, '绿皮船长的宝藏', 'item_double_lootbox', 0, '圣物', '你的击杀野怪或玩家阵亡掉落的装备替换为战利品代币', 'item_custom/绿皮船长的宝藏.png', 0);
INSERT INTO `item_relic` VALUES (20, '宏伟宝库', 'item_more_interest', 0, '圣物', '你的每回合金币利息不再具有4的上限', 'item_custom/宏伟宝库.png', 0);
INSERT INTO `item_relic` VALUES (21, '罪孽收割者', 'item_more_reward', 0, '圣物', '每当你客场获胜时会获得4点经验值，客场终结和击杀额外获得（赏金×2）的经验值', 'item_custom/罪孽收割者.png', 0);
INSERT INTO `item_relic` VALUES (22, '精英招募官', 'item_upgrade_roll', 0, '圣物', '你在招募棋子时将使用更高1级信使的招募概率', 'item_custom/精英招募官.png', 0);
INSERT INTO `item_relic` VALUES (23, '自然的恩赐', 'item_double_io', 0, '圣物', '你在招募棋子时精灵守卫出现的概率×10，每招募到一个精灵守卫此概率就-2', 'item_custom/自然的恩赐.png', 0);
INSERT INTO `item_relic` VALUES (24, '垄断契约', 'item_destroy_piece', 0, '圣物', '你合成★★棋子时获得（该棋子费用）的垄断基金，合成★★★棋子时获得（该棋子费用×全体玩家拥有的该棋子总个数）的垄断基金并摧毁棋库中所有同名棋子', 'item_custom/垄断契约.png', 0);
INSERT INTO `item_relic` VALUES (25, '亲友折扣', 'item_friends_discount', 0, '圣物', '你招募已拥有棋子的价格减半', 'item_custom/亲友折扣.png', 0);
INSERT INTO `item_relic` VALUES (26, '不稳定的缩小射线', 'item_shrink_meister', 0, '圣物', '你的招募棋子有60%概率仅花费1金币，并使用-2等级信使的招募概率', 'item_custom/不稳定的缩小射线.png', 0);
INSERT INTO `item_relic` VALUES (27, '吸血鬼獠牙', 'item_vampiric_embrace', 0, '圣物', '你客场获胜对其他玩家造成伤害时+40%信使吸血。当你的信使生命值吸满100时将会获得一个树之祭祀', 'item_custom/吸血鬼獠牙.png', 0);
INSERT INTO `item_relic` VALUES (28, '幸存者', 'item_skip_battle', 0, '圣物', '每当你的信使受到伤害，可以跳过下一个非战利品回合的战斗阶段。跳过的战斗会视为失败', 'item_custom/幸存者.png', 0);

-- ----------------------------
-- Table structure for item_token
-- ----------------------------
DROP TABLE IF EXISTS `item_token`;
CREATE TABLE `item_token`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '代币名称',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '代币代码',
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '代币' COMMENT '类型',
  `desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '代币描述',
  `isuse` tinyint(1) NULL DEFAULT 1 COMMENT '是否在用',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of item_token
-- ----------------------------
INSERT INTO `item_token` VALUES (1, '机械之心', 'item_jixiezhixin', '代币', '信使消耗品：点击使用，进行一次免费的棋子超募', 1);
INSERT INTO `item_token` VALUES (2, '金色机械之心', 'item_jixiezhixin_gold', '代币', '信使消耗品：点击使用，从五个随机传说棋子中进行一次发现', 1);
INSERT INTO `item_token` VALUES (3, '暗黑核心', 'item_jixiezhixin_black', '代币', '信使消耗品：点击使用，进行一次特殊的免费棋子招募，但不会从本局游戏的棋子库招募，而是按照当前信使等级的招募概率，从备用棋子库招募', 1);
INSERT INTO `item_token` VALUES (4, '机械代币', 'item_common_token', '代币', '一种特殊的代币，可以用来发现机械之心招募到的棋子', 1);
INSERT INTO `item_token` VALUES (5, '金色机械代币', 'item_gold_token', '代币', '一种特殊的代币，可以用来发现金色机械之心招募到的传说棋子', 1);
INSERT INTO `item_token` VALUES (6, '奇观轮代币', 'item_rm_token', '代币', '一种特殊的代币，可以用来发现奇观轮招募到的特殊棋子', 1);

-- ----------------------------
-- Table structure for major
-- ----------------------------
DROP TABLE IF EXISTS `major`;
CREATE TABLE `major`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '种族职业表id',
  `type` tinyint(1) NOT NULL COMMENT '职业0种族1',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '种族职业名称',
  `isUse` tinyint(1) NOT NULL COMMENT '是否在用',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'icon图标',
  `color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '颜色',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '种族职业描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of major
-- ----------------------------
INSERT INTO `major` VALUES (1, 0, '战士', 1, 'dragon_knight_dragon_tail_png.png', '#a98a55', '战士将力量、领导才能和对武器盔甲的了解结合在一起，在光荣的战斗中一展身手。');
INSERT INTO `major` VALUES (2, 0, '刺客', 1, 'silencer_gaives_of_wisdom_png.png', '#e6c106', '刺客的信条就是契约，而荣誉则可以用金钱来交易。这些雇佣兵们不会被良知束缚，习惯依赖于残忍而高效的战术。');
INSERT INTO `major` VALUES (3, 0, '猎人', 1, 'drow_ranger_marksmanship_png.png', '#83cd47', '自远古以来，荒野的召唤就会让一些冒险者离开舒适的家，到无情的原始世界冒险。那些坚持下来的人就成为了猎人。');
INSERT INTO `major` VALUES (4, 0, '法师', 1, 'crystal_maiden_brilliance_aura_png.png', '#65c1ff', '只有最敏锐、聪慧、严于律己的学生才能够走上法师之路。法师所能够掌握的奥术魔法太过强大而危险，只有最专注的研习者才能够窥见其中的奥秘。');
INSERT INTO `major` VALUES (5, 0, '骑士', 1, 'chaos_knight_phantasm_png.png', '#f685b7', '骑士的天职：匡扶弱小，伸张正义，消灭来自世界最黑暗角落的邪恶力量。这些神圣的战士们身着板甲，以对抗最强大的敌人。');
INSERT INTO `major` VALUES (6, 0, '术士', 1, 'warlock_upheaval_png.png', '#987fcb', '面对恶魔的力量时，大多数英雄只看到了死亡。但术士看到的却只有机遇。他们的目标是支配这样的力量，并且在黑暗魔法中找到了手段。');
INSERT INTO `major` VALUES (7, 0, '工匠', 1, 'rattletrap_power_cogs_png.png', '#c57b17', '钻研工程学的地精、侏儒、矮人工匠制造了无数的震撼人心的发明。');
INSERT INTO `major` VALUES (8, 0, '德鲁伊', 1, 'lone_druid_spirit_bear_entangle_png.png', '#ff8c00', '德鲁伊能驾驭强大的自然力量来维护平衡、保护生命。');
INSERT INTO `major` VALUES (9, 0, '巫师', 1, 'grimstroke_ink_creature_png.png', '#ff8c00', '巫师是一个古老而又神秘的职业，虽然他们从事的是传示神谕，解读魔术牌，玩弄戏法等一些类似的活动，巫师们还是因为装神弄鬼经常被人们与邪恶画上等号。');
INSERT INTO `major` VALUES (10, 0, '萨满', 1, 'disruptor_thunder_strike_png.png', '#4e7cf8', '萨满祭司是灵魂的指引者，他们侍奉的不是神灵，而是每一种元素。');
INSERT INTO `major` VALUES (11, 0, '牧师', 1, 'skywrath_mage_ancient_seal_png.png', '#ff8c00', '牧师致力于升华他们的精神，通过造福大众来表达他们坚定不移的信念。在过去的千百年中，每当多多岛遭受战火、盟友需要他们支援的时候，他们都会抛开舒适的生活，离开与世隔绝的神殿。');
INSERT INTO `major` VALUES (12, 0, '武僧', 1, 'monkey_king_jingu_mastery_png.png', '#987fcb', '在熊猫人被奴役的时代，统治者们剥夺了它们使用武器的权利。熊猫人们专注于练习运用真气，使用随手捡起的道具甚至徒手战斗。这项技能使得训练有素的熊猫人们有了足够的能力粉碎奴役的枷锁。');
INSERT INTO `major` VALUES (13, 0, '恶魔猎手', 1, 'terrorblade_metamorphosis_alt1_png.png', '#a253b1', '恶魔猎手棋子会被同时视为敌方恶魔。');
INSERT INTO `major` VALUES (14, 1, '兽人', 1, 'beastmaster_primal_roar_png.png', '#ed4c4c', '兽人不是多多岛的原住民。起初，他们以萨满部族的身份居住在苍翠繁茂的啦啦星球。当恶魔领主腐化兽人，利用他们对抗从鸡蛋的家园逃离的德国人以完成自己的复仇阴谋时，兽人抛弃了他们原本和平生活的文化。');
INSERT INTO `major` VALUES (15, 1, '精灵', 1, 'wisp_overcharge_png.png', '#ed4c4c', '生活在世界之树之上的精灵们，是多多岛最重要的保护者之一，其月神信仰与自然平衡信仰渗透在生活之中点点滴滴。');
INSERT INTO `major` VALUES (16, 1, '人类', 1, 'silencer_curse_of_the_silent_png.png', '#ed4c4c', '人类是受到尤导血肉诅咒的野蛮维库人退化的后代。几千年以来，早期的人类主要是以分散的部落形式生活的，直到逐渐增长的外界压力迫使他们统一起来。');
INSERT INTO `major` VALUES (17, 1, '娜迦', 1, 'lion_voodoo_fish_png.png', '#ed4c4c', '娜迦族原本是暗夜精灵的贵族，这些权贵们被哼哼井的能量所迷惑而无节制地滥用魔法。上古之战哼哼井崩塌后，沉入海底的上层精灵因受到永远的诅咒而变型为妖怪一般的娜迦。');
INSERT INTO `major` VALUES (18, 1, '巨魔', 1, 'huskar_berserkers_blood_png.png', '#ed4c4c', '野蛮的巨魔因其残忍、黑暗的神秘宗教以及对其他种族的强烈仇恨而臭名昭着。');
INSERT INTO `major` VALUES (19, 1, '地精', 1, 'techies_minefield_sign_swine_png.png', '#ed4c4c', '地精们起初是科科岛上丛林巨魔的奴隶，而卡加矿石使得地精种族变得令人吃惊的狡猾和聪明。');
INSERT INTO `major` VALUES (20, 1, '野兽', 1, 'beastmaster_boar_poison_png.png', '#ed4c4c', '野兽拥有超人的力量、耐力和速度，擅长群体捕食。');
INSERT INTO `major` VALUES (21, 1, '食人魔', 1, 'ogre_magi_multicast_png.png', '#ed4c4c', '食人魔是一个曾经统治啦啦星球的拥有部分双头成员的强大种族，他们拥有自己的文化和城市，他们有不亚于兽人的种群和氏族。');
INSERT INTO `major` VALUES (22, 1, '亡灵', 1, 'arc_warden_spark_wraith_png.png', '#ed4c4c', '天灾亡灵是一股强大的邪恶力量，它们在生灵中传播邪恶、恐怖和不死状态。这支军队最初由燃烧军团所创建，并在第二次军团入侵失败后脱离了恶魔的掌控，但它们仍旧怀有与过去的主子同样邪恶的目的——让艾艾星球陷入混乱并走向毁灭。');
INSERT INTO `major` VALUES (23, 1, '恶魔', 1, 'nevermore_dark_lord_demon_png.png', '#fa4e5b', '来自次元裂隙中的拥有强大邪能力量的扭曲生物。');
INSERT INTO `major` VALUES (24, 1, '元素', 1, 'brewmaster_primal_split_png.png', '#ed4c4c', '元素位面是一处充满暴力且危险的地方，在那里每一种元素都和其他元素战斗着，在永无止境的冲突中试图扩展自己的疆土。');
INSERT INTO `major` VALUES (25, 1, '龙', 1, 'lina_dragon_slave_alt1_png.png', '#ed4c4c', '龙族是多多岛上古老的住民，它们拥有庞大的身躯、超乎想象的力量，被视为神圣而强大的存在。');
INSERT INTO `major` VALUES (27, 1, '矮人', 1, 'sniper_take_aim_png.png', '#ed4c4c', '大胆而勇敢的矮人族是一支古老的种族，它起源于早期多多岛的神明用具有活力的石头创造的土灵。擅长采矿和制造的矮人在这个世界上寻找泰坦的遗产，因为他们坚信是泰坦在创世之初用石头创造了矮人。');
INSERT INTO `major` VALUES (28, 1, '神', 1, 'zuus_static_field_alt1_png.png', '#ff8c00', '高高在上的神明被认为是多多岛的造物者。在将神力赐予了守护巨龙之后，神明们很少亲自涉事凡人的世界，直到多多岛遇到了来自扭曲虚空的空前危机。');
INSERT INTO `major` VALUES (29, 1, '虫', 1, 'big_thunder_lizard_wardrums_aura_png.png', '#f68bbf', '作为上古时代就存在多多岛的异形生物，亚基虫族早已褪去了克克帝国的辉煌。现在它们分成了不同的部族，被封印在地下世界，或者寄生在别的物种体内。');
INSERT INTO `major` VALUES (30, 1, '熊猫人', 1, 'brewmaster_cinder_brew_png.png', '#4e7cf8', '一万年之前世界将要分裂之际，熊猫人帝国的最后一位皇帝将整个潘潘大陆笼罩在云雾中从而逃过了劫难。所以直到现在它们重见天日的时候，对世界上的其他种族来说，熊猫人的一切都是谜。');
INSERT INTO `major` VALUES (31, 1, '牛头人', 1, 'elder_titan_ancestral_spirit_png.png', '#e6c106', '爱好和平的牛头人长期居住在多多大陆贫瘠地区的高山上，它们在大地母亲的护佑下，努力保护大自然的平衡。');
INSERT INTO `major` VALUES (32, 1, '狗头人', 1, 'meepo_divided_we_stand_png.png', '#8ecf5a', '生活在地穴之中的一类生物，矮小龌龊。为了适应阴暗的环境，它们的头上经常顶着燃烧的蜡烛行走。');
INSERT INTO `major` VALUES (33, 1, '无面者', 1, 'faceless_void_backtrack_png.png', '#4e7cf8', '恩拉基俗称无面之物或无面者，是从上古之神的枯萎形态中渗出的有机物质催生出的种族。他们狡诈而聪明，作为上古之神的肉体形态，他们狂热地效忠于他们的虚空主人。');
INSERT INTO `major` VALUES (34, 1, '鹰身人', 1, 'harpy_scout_take_off_png.png', '#9c89b8', '鹰身人相信她们的血脉可以上溯到远古时代，由于她们背叛了玩弄巫术的暗夜精灵女王，而被罚变成了丑陋的鸟形生物。');
INSERT INTO `major` VALUES (35, 1, '半人马', 1, 'centaur_hoof_stomp_png.png', '#cd7f32', '半人马族的种族基因其实异常高贵，它们是由半神德鲁伊的长子扎尔塔与石母唯一的女儿瑟莱德丝公主结合而诞生。半人马整个种族都异常残暴，具有非常强的侵略性和攻击性。');
INSERT INTO `major` VALUES (36, 1, '德莱尼', 1, 'bane_nightmare_png.png', '#4682b4', '为了避免被燃烧军团奴役为恶魔，在大先知的带领下逃离了自己家园的这群信仰纳鲁和圣光的异族生物，将自己称为德莱尼，或者“流亡者”。');
INSERT INTO `major` VALUES (41, 1, '远古', 0, 'tidehunter_kraken_shell_png.png', '#6a5acd', '远古时期就生活在这个世界上的生物，它们统治世界长达几万年之久，却因为不为人所知的原因灭绝了。');

-- ----------------------------
-- Table structure for skill_type
-- ----------------------------
DROP TABLE IF EXISTS `skill_type`;
CREATE TABLE `skill_type`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '技能类型主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类型名称',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类型说明',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类型码对应',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of skill_type
-- ----------------------------
INSERT INTO `skill_type` VALUES (1, '被动', '不需要主动释放的技能，常驻效果', '_G.ability_behavior_list[a] == 0');
INSERT INTO `skill_type` VALUES (2, '指向性', '需要选择一个敌方/友方目标释放', '_G.ability_behavior_list[a] == 1');
INSERT INTO `skill_type` VALUES (3, '无目标', '直接释放，不需要选择目标', '_G.ability_behavior_list[a] == 2');
INSERT INTO `skill_type` VALUES (4, '点目标', '需要选择一个位置（格子）释放', '_G.ability_behavior_list[a] == 3');
INSERT INTO `skill_type` VALUES (5, '战吼', '战斗回合开始前自动触发', '_G.ability_behavior_list[a] == 0 且有特殊标记');
INSERT INTO `skill_type` VALUES (6, '光环', '持续对周围单位生效', '羁绊技能或部分装备效果');
INSERT INTO `skill_type` VALUES (7, '持续施法', '需要引导的技能', '_G.ability_behavior_list[a] 特殊值');

SET FOREIGN_KEY_CHECKS = 1;

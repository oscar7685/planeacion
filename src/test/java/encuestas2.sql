/*
Navicat MySQL Data Transfer

Source Server         : saplocal
Source Server Version : 50516
Source Host           : localhost:3306
Source Database       : encuestas2

Target Server Type    : MYSQL
Target Server Version : 50516
File Encoding         : 65001

Date: 2014-08-19 16:55:55
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for condicion
-- ----------------------------
DROP TABLE IF EXISTS `condicion`;
CREATE TABLE `condicion` (
  `idcondicion` int(11) NOT NULL AUTO_INCREMENT,
  `preguntaCondicionada` int(11) NOT NULL,
  `tipo` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `preguntaCondicionadora` int(11) NOT NULL,
  `respuestaCondicionadora` int(11) NOT NULL,
  PRIMARY KEY (`idcondicion`),
  KEY `fk_condicion_pregunta1` (`preguntaCondicionada`),
  KEY `fk_condicion_respuesta1` (`respuestaCondicionadora`),
  KEY `fk_condicion_pregunta2` (`preguntaCondicionadora`),
  CONSTRAINT `fk_condicion_pregunta1` FOREIGN KEY (`preguntaCondicionada`) REFERENCES `pregunta` (`idpregunta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_condicion_respuesta1` FOREIGN KEY (`respuestaCondicionadora`) REFERENCES `respuesta` (`idrespuesta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_condicion_pregunta2` FOREIGN KEY (`preguntaCondicionadora`) REFERENCES `pregunta` (`idpregunta`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of condicion
-- ----------------------------

-- ----------------------------
-- Table structure for encuesta
-- ----------------------------
DROP TABLE IF EXISTS `encuesta`;
CREATE TABLE `encuesta` (
  `idencuesta` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `objetivo` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`idencuesta`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of encuesta
-- ----------------------------
INSERT INTO `encuesta` VALUES ('1', 'Encuesta para estudiantes', 'Objetivo');
INSERT INTO `encuesta` VALUES ('2', 'Encuesta para docentes', 'Objetivo');
INSERT INTO `encuesta` VALUES ('3', 'Encuesta para administrativos', 'Objetivo');

-- ----------------------------
-- Table structure for persona
-- ----------------------------
DROP TABLE IF EXISTS `persona`;
CREATE TABLE `persona` (
  `idpersona` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`idpersona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of persona
-- ----------------------------

-- ----------------------------
-- Table structure for pregunta
-- ----------------------------
DROP TABLE IF EXISTS `pregunta`;
CREATE TABLE `pregunta` (
  `idpregunta` int(11) NOT NULL AUTO_INCREMENT,
  `pregunta` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tipo` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `otro` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `label_otro` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `orden` int(11) DEFAULT NULL,
  `encuesta_idencuesta` int(11) DEFAULT NULL,
  `pregunta_padre` int(11) DEFAULT NULL,
  PRIMARY KEY (`idpregunta`),
  KEY `fk_pregunta_encuesta1` (`encuesta_idencuesta`),
  KEY `fk_pregunta_pregunta1` (`pregunta_padre`),
  CONSTRAINT `fk_pregunta_encuesta1` FOREIGN KEY (`encuesta_idencuesta`) REFERENCES `encuesta` (`idencuesta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pregunta_pregunta1` FOREIGN KEY (`pregunta_padre`) REFERENCES `pregunta` (`idpregunta`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of pregunta
-- ----------------------------
INSERT INTO `pregunta` VALUES ('1', 'Según su percepción general, en los últimos años la universidad de Cartagena en el ámbito académico:', '0', null, null, null, '1', null);
INSERT INTO `pregunta` VALUES ('2', 'Cuál es el principal objetivo de los programas de bienestar de la universidad', '0', null, null, null, '1', null);
INSERT INTO `pregunta` VALUES ('3', '¿Qué aspectos son necesarios para aumentar el uso de los servicios de bienestar en los programas a distancia?', '0', null, null, null, '1', null);

-- ----------------------------
-- Table structure for respuesta
-- ----------------------------
DROP TABLE IF EXISTS `respuesta`;
CREATE TABLE `respuesta` (
  `idrespuesta` int(11) NOT NULL AUTO_INCREMENT,
  `respuesta` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pregunta_idpregunta` int(11) NOT NULL,
  PRIMARY KEY (`idrespuesta`),
  KEY `fk_respuesta_pregunta1` (`pregunta_idpregunta`),
  CONSTRAINT `fk_respuesta_pregunta1` FOREIGN KEY (`pregunta_idpregunta`) REFERENCES `pregunta` (`idpregunta`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of respuesta
-- ----------------------------
INSERT INTO `respuesta` VALUES ('1', 'Ha mejorado considerablemente\r', '1');
INSERT INTO `respuesta` VALUES ('2', 'Ha mejorado\r', '1');
INSERT INTO `respuesta` VALUES ('3', 'Se ha mantenido igual\r', '1');
INSERT INTO `respuesta` VALUES ('4', 'Ha desmejorado', '1');
INSERT INTO `respuesta` VALUES ('5', 'Disminuir la deserción estudiantil\r', '2');
INSERT INTO `respuesta` VALUES ('6', 'Mejorar la calidad de los programas de la universidad\r', '2');
INSERT INTO `respuesta` VALUES ('7', 'Contribuir a la mejora del desempeño académico de los estudiantes\r', '2');
INSERT INTO `respuesta` VALUES ('8', 'Ninguna de las anteriores', '2');
INSERT INTO `respuesta` VALUES ('9', 'Mayor divulgación de los programas de bienestar por parte de la institución\r', '3');
INSERT INTO `respuesta` VALUES ('10', 'Mayor cobertura de los servicios de bienestar en los programas a distancia\r', '3');
INSERT INTO `respuesta` VALUES ('11', 'Ampliar los programas de bienestar a modalidad virtual\r', '3');
INSERT INTO `respuesta` VALUES ('12', 'Incentivar a los estudiantes a que accedan a los programas de bienestar', '3');

-- ----------------------------
-- Table structure for resultados
-- ----------------------------
DROP TABLE IF EXISTS `resultados`;
CREATE TABLE `resultados` (
  `idresultados` int(11) NOT NULL AUTO_INCREMENT,
  `valor` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pregunta_idpregunta` int(11) NOT NULL,
  `respuesta_idrespuesta` int(11) DEFAULT NULL,
  `persona_idpersona` int(11) NOT NULL,
  `orden` int(11) DEFAULT NULL,
  PRIMARY KEY (`idresultados`),
  KEY `fk_resultados_pregunta1` (`pregunta_idpregunta`),
  KEY `fk_resultados_respuesta1` (`respuesta_idrespuesta`),
  KEY `fk_resultados_persona1_idx` (`persona_idpersona`),
  CONSTRAINT `fk_resultados_pregunta1` FOREIGN KEY (`pregunta_idpregunta`) REFERENCES `pregunta` (`idpregunta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_resultados_respuesta1` FOREIGN KEY (`respuesta_idrespuesta`) REFERENCES `respuesta` (`idrespuesta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_resultados_persona1` FOREIGN KEY (`persona_idpersona`) REFERENCES `persona` (`idpersona`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of resultados
-- ----------------------------

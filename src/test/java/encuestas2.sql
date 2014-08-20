/*
Navicat MySQL Data Transfer

Source Server         : saplocal
Source Server Version : 50516
Source Host           : localhost:3306
Source Database       : encuestas2

Target Server Type    : MYSQL
Target Server Version : 50516
File Encoding         : 65001

Date: 2014-08-20 15:43:32
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
  CONSTRAINT `fk_condicion_pregunta2` FOREIGN KEY (`preguntaCondicionadora`) REFERENCES `pregunta` (`idpregunta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_condicion_respuesta1` FOREIGN KEY (`respuestaCondicionadora`) REFERENCES `respuesta` (`idrespuesta`) ON DELETE NO ACTION ON UPDATE NO ACTION
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
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of pregunta
-- ----------------------------
INSERT INTO `pregunta` VALUES ('1', 'Según su percepción general, en los últimos años la universidad de Cartagena en el ámbito académico:', '0', null, null, null, '1', null);
INSERT INTO `pregunta` VALUES ('2', 'Cuál es el principal objetivo de los programas de bienestar de la universidad', '0', null, null, null, '1', null);
INSERT INTO `pregunta` VALUES ('3', '¿Qué aspectos son necesarios para aumentar el uso de los servicios de bienestar en los programas a distancia?', '0', null, null, null, '1', null);
INSERT INTO `pregunta` VALUES ('9', 'Señale cuál de los siguientes programas de bienestar conoce o ha hecho uso', '8', null, null, null, '1', null);
INSERT INTO `pregunta` VALUES ('10', 'Programas psicológicos\r', null, null, null, null, null, '9');
INSERT INTO `pregunta` VALUES ('11', 'Programas deportivos\r', null, null, null, null, null, '9');
INSERT INTO `pregunta` VALUES ('12', 'Programas sociales\r', null, null, null, null, null, '9');
INSERT INTO `pregunta` VALUES ('13', 'Programas culturales', null, null, null, null, null, '9');
INSERT INTO `pregunta` VALUES ('14', 'Marque con una X de acuerdo a los aspectos que caracterizan los cursos ofrecidos en los programas a distancia', '8', null, null, null, '1', null);
INSERT INTO `pregunta` VALUES ('15', 'Flexibilidad\r', null, null, null, null, null, '14');
INSERT INTO `pregunta` VALUES ('16', 'Diversidad\r', null, null, null, null, null, '14');
INSERT INTO `pregunta` VALUES ('17', 'Educación integral\r', null, null, null, null, null, '14');
INSERT INTO `pregunta` VALUES ('18', 'Conocimiento interdisciplinario', null, null, null, null, null, '14');
INSERT INTO `pregunta` VALUES ('19', '¿Qué factor considera que impide que los estudiantes a distancia alcancen un mayor nivel de inglés?', '0', null, null, null, '1', null);
INSERT INTO `pregunta` VALUES ('20', '¿Qué aspectos dificultan el uso de los servicios de las bases de datos de la biblioteca por parte de los estudiantes a distancia?', '0', null, null, null, '1', null);
INSERT INTO `pregunta` VALUES ('21', '¿Promueven los docentes el uso de las bases de datos de la universidad a los estudiantes a distancia?', '0', null, null, null, '1', null);
INSERT INTO `pregunta` VALUES ('24', 'Jerarquice  de 1-4 (siendo uno el más importante) los aspectos que impiden el completo uso de las tecnologías de intermediación en los programas a distancia', '7', null, null, null, '1', null);
INSERT INTO `pregunta` VALUES ('25', 'Que factor impide que los estudiantes de los programas a distancia se dediquen a los procesos investigativos', '0', null, null, null, '1', null);
INSERT INTO `pregunta` VALUES ('26', 'Según su percepción general, en los últimos años la universidad de Cartagena en el ámbito académico:', '0', null, null, null, '2', null);
INSERT INTO `pregunta` VALUES ('27', 'Priorice de 1 a 5 (siendo 1 el aspecto más importante) los principales determinantes de la deserción de los estudiantes a distancia:', '7', null, null, null, '2', null);
INSERT INTO `pregunta` VALUES ('28', '¿Qué factores mejorarían la oferta de los servicios de bienestar en los programas a distancia?', '0', null, null, null, '2', null);
INSERT INTO `pregunta` VALUES ('29', 'Señale cuál de los siguientes programas de bienestar conoce o ha hecho uso', '8', null, null, null, '2', null);
INSERT INTO `pregunta` VALUES ('30', 'Programas psicológicos\r', null, null, null, null, null, '29');
INSERT INTO `pregunta` VALUES ('31', 'Programas deportivos\r', null, null, null, null, null, '29');
INSERT INTO `pregunta` VALUES ('32', 'Programas sociales\r', null, null, null, null, null, '29');
INSERT INTO `pregunta` VALUES ('33', 'Programas culturales', null, null, null, null, null, '29');
INSERT INTO `pregunta` VALUES ('34', '¿Qué factor considera que impide que los estudiantes a distancia alcancen un mayor nivel de inglés?', '0', null, null, null, '2', null);
INSERT INTO `pregunta` VALUES ('35', '¿Qué aspecto imposibilitan la formación de los docentes en segunda lengua?', '0', null, null, null, '2', null);
INSERT INTO `pregunta` VALUES ('36', '¿Han mejorado los procesos de los programas de distancia la incorporación de estos a las facultades?', '0', null, null, null, '2', null);
INSERT INTO `pregunta` VALUES ('37', 'Jerarquice de 1-3  (siendo 1 la más alta) las siguientes estrategias para fomentar el uso de las bases de datos en los estudiantes a distancia', '7', null, null, null, '2', null);
INSERT INTO `pregunta` VALUES ('38', 'Jerarquice  de 1-4 (siendo uno el más importante) los aspectos que impiden el completo uso de las tecnologías de intermediación en los programas a distancia', '7', null, null, null, '2', null);
INSERT INTO `pregunta` VALUES ('39', 'Que aspecto impide que los docentes de los programas a distancia se dediquen a la investigación.', '0', null, null, null, '2', null);
INSERT INTO `pregunta` VALUES ('40', 'Según su percepción general, en los últimos años la universidad de Cartagena en el ámbito académico:', '0', null, null, '1', '3', null);
INSERT INTO `pregunta` VALUES ('41', 'Cuál es el principal objetivo de los programas de bienestar de la universidad ', '0', null, null, '2', '3', null);
INSERT INTO `pregunta` VALUES ('42', 'Priorice de 1 a 5 (siendo 1 el aspecto más importante) los principales determinantes de la deserción de los estudiantes a distancia:', '7', null, null, '3', '3', null);
INSERT INTO `pregunta` VALUES ('43', 'Señale cuál de los siguientes programas de bienestar conoce o ha hecho uso', '8', null, null, '4', '3', null);
INSERT INTO `pregunta` VALUES ('44', 'Programas psicológicos\r', null, null, null, null, null, '43');
INSERT INTO `pregunta` VALUES ('45', 'Programas deportivos\r', null, null, null, null, null, '43');
INSERT INTO `pregunta` VALUES ('46', 'Programas sociales\r', null, null, null, null, null, '43');
INSERT INTO `pregunta` VALUES ('47', 'Programas culturales', null, null, null, null, null, '43');
INSERT INTO `pregunta` VALUES ('48', '¿Qué factor considera que impide que los estudiantes a distancia alcancen un mayor nivel de inglés?', '0', null, null, '5', '3', null);
INSERT INTO `pregunta` VALUES ('49', 'Ordene de 1-4 ( siendo 1 la más importante) que estrategias considera efectiva para aumentar el nivel de inglés de los estudiantes a distancia', '7', null, null, '6', '3', null);
INSERT INTO `pregunta` VALUES ('51', 'Jerarquice  de 1-4 (siendo uno el más importante) los aspectos que impiden el completo uso de las tecnologías de intermediación en los programas a distancia', '7', null, null, '8', '3', null);
INSERT INTO `pregunta` VALUES ('52', 'Califique de 1-5 (siendo 5 excelente) los procesos entre los programas presenciales y a distancia a partir de la integración de los últimos a las facultades', '8', null, null, '7', '3', null);
INSERT INTO `pregunta` VALUES ('53', 'Procesos administrativos\r', null, null, null, null, null, '52');
INSERT INTO `pregunta` VALUES ('54', 'Procesos de comunicación\r', null, null, null, null, null, '52');
INSERT INTO `pregunta` VALUES ('55', 'Procesos académicos\r', null, null, null, null, null, '52');
INSERT INTO `pregunta` VALUES ('56', 'Procesos financieros', null, null, null, null, null, '52');

-- ----------------------------
-- Table structure for respuesta
-- ----------------------------
DROP TABLE IF EXISTS `respuesta`;
CREATE TABLE `respuesta` (
  `idrespuesta` int(11) NOT NULL AUTO_INCREMENT,
  `respuesta` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pregunta_idpregunta` int(11) NOT NULL,
  PRIMARY KEY (`idrespuesta`),
  KEY `fk_respuesta_pregunta1` (`pregunta_idpregunta`),
  CONSTRAINT `fk_respuesta_pregunta1` FOREIGN KEY (`pregunta_idpregunta`) REFERENCES `pregunta` (`idpregunta`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
INSERT INTO `respuesta` VALUES ('21', 'Conoce	\r', '9');
INSERT INTO `respuesta` VALUES ('22', 'Ha hecho uso', '9');
INSERT INTO `respuesta` VALUES ('23', 'Sí\r', '14');
INSERT INTO `respuesta` VALUES ('24', 'No', '14');
INSERT INTO `respuesta` VALUES ('25', 'No tienen interés en aprender segunda lengua\r', '19');
INSERT INTO `respuesta` VALUES ('26', 'No se les exige un nivel de inglés mínimo para tomar grado\r', '19');
INSERT INTO `respuesta` VALUES ('27', 'No están fundamentados cursos de inglés para estudiantes a distancia\r', '19');
INSERT INTO `respuesta` VALUES ('28', 'Todas las anteriores\r', '19');
INSERT INTO `respuesta` VALUES ('29', 'Ninguna de las anteriores', '19');
INSERT INTO `respuesta` VALUES ('30', 'Las bases de datos no se acoplan al programa académico de estudio\r', '20');
INSERT INTO `respuesta` VALUES ('31', 'El contenido de las bases de datos no está dirigido a estudiantes de pregrado\r', '20');
INSERT INTO `respuesta` VALUES ('32', 'Resulta muy complicado acceder a las bases de datos a las que está adscrita la universidad\r', '20');
INSERT INTO `respuesta` VALUES ('33', 'Existe poca comunicación sobre las bases de datos con las que cuenta la universidad', '20');
INSERT INTO `respuesta` VALUES ('34', 'Si, mediante los trabajos desarrollados en las asignaturas\r', '21');
INSERT INTO `respuesta` VALUES ('35', 'No, nunca han mencionado al existencia de las bases de datos de la universidad\r', '21');
INSERT INTO `respuesta` VALUES ('36', 'Han mencionado alguna vez sobre las bases de datos de la universidad', '21');
INSERT INTO `respuesta` VALUES ('43', 'Baja calificación docente en el uso de las tecnologías de intermediación\r', '24');
INSERT INTO `respuesta` VALUES ('44', 'Baja calificación estudiantil en el uso de las tecnologías de intermediación\r', '24');
INSERT INTO `respuesta` VALUES ('45', 'El municipio como tal no cuenta con la infraestructura para ejercer el uso de las tecnologías de intermediación\r', '24');
INSERT INTO `respuesta` VALUES ('46', 'La infraestructura física de los centros tutoriales en donde se desarrollan los programas a distancias no permite el correcto uso de las tecnologías de intermediación', '24');
INSERT INTO `respuesta` VALUES ('47', 'Falta de motivación por parte de los docentes\r', '25');
INSERT INTO `respuesta` VALUES ('48', 'Insuficiente número de grupos de investigación\r', '25');
INSERT INTO `respuesta` VALUES ('49', 'Poco tiempo para dedicar a la investigación\r', '25');
INSERT INTO `respuesta` VALUES ('50', 'Ninguna de las anteriores.', '25');
INSERT INTO `respuesta` VALUES ('51', 'Ha mejorado considerablemente\r', '26');
INSERT INTO `respuesta` VALUES ('52', 'Ha mejorado\r', '26');
INSERT INTO `respuesta` VALUES ('53', 'Se ha mantenido igual\r', '26');
INSERT INTO `respuesta` VALUES ('54', 'Ha desmejorado', '26');
INSERT INTO `respuesta` VALUES ('55', 'Dificultades laborales\r', '27');
INSERT INTO `respuesta` VALUES ('56', 'Dificultades académicas\r', '27');
INSERT INTO `respuesta` VALUES ('57', 'Compromisos laborales\r', '27');
INSERT INTO `respuesta` VALUES ('58', 'Traslado a otra universidad\r', '27');
INSERT INTO `respuesta` VALUES ('59', 'Dificultades económicas', '27');
INSERT INTO `respuesta` VALUES ('60', 'Mayor divulgación de los programas existentes de bienestar de la institución\r', '28');
INSERT INTO `respuesta` VALUES ('61', 'Mayor cobertura de los servicios de bienestar en los programas a distancia\r', '28');
INSERT INTO `respuesta` VALUES ('62', 'Implementar programas de bienestar virtualizados\r', '28');
INSERT INTO `respuesta` VALUES ('63', 'Ampliar los programas de bienestar que ofrece la institución', '28');
INSERT INTO `respuesta` VALUES ('64', 'Conoce\r', '29');
INSERT INTO `respuesta` VALUES ('65', 'Ha hecho uso', '29');
INSERT INTO `respuesta` VALUES ('66', 'No tienen interés en aprender segunda lengua\r', '34');
INSERT INTO `respuesta` VALUES ('67', 'No se les exige un nivel de inglés mínimo para tomar grado\r', '34');
INSERT INTO `respuesta` VALUES ('68', 'No están fundamentados cursos de inglés para estudiantes a distancia\r', '34');
INSERT INTO `respuesta` VALUES ('69', 'Todas las anteriores\r', '34');
INSERT INTO `respuesta` VALUES ('70', 'Ninguna de las anteriores', '34');
INSERT INTO `respuesta` VALUES ('71', 'Falta de tiempo para la formación  en segunda lengua\r', '35');
INSERT INTO `respuesta` VALUES ('72', 'Poco interés en el aprendizaje de una segunda lengua\r', '35');
INSERT INTO `respuesta` VALUES ('73', 'Falta de recursos para la formación en segunda lengua\r', '35');
INSERT INTO `respuesta` VALUES ('74', 'Poca oferta de cursos de segunda lengua en los municipios', '35');
INSERT INTO `respuesta` VALUES ('75', 'Si, ha permitido que se estandaricen los procesos curriculares de programas presenciales y distancia\r', '36');
INSERT INTO `respuesta` VALUES ('76', 'No, sigue existiendo disparidad académica entre los programas a distancia y presenciales\r', '36');
INSERT INTO `respuesta` VALUES ('77', 'Si, ha permitido que se tenga más control sobre los procesos administrativos y comunicacionales de los programas a distancia\r', '36');
INSERT INTO `respuesta` VALUES ('78', 'No, siguen existiendo aspectos como la falta de comunicación entre los programas académicos de distancia y sus respectivas facultades', '36');
INSERT INTO `respuesta` VALUES ('79', 'Capacitar a los estudiantes para que puedan acceder a las bases de datos\r', '37');
INSERT INTO `respuesta` VALUES ('80', 'Exigir el uso de bases de datos por parte de los docentes en los procesos formativos\r', '37');
INSERT INTO `respuesta` VALUES ('81', 'Comunicar las distintas bases de datos con las que cuenta la universidad', '37');
INSERT INTO `respuesta` VALUES ('82', 'Baja calificación docente en el uso de las tecnologías de intermediación\r', '38');
INSERT INTO `respuesta` VALUES ('83', 'Baja calificación estudiantil en el uso de las tecnologías de intermediación\r', '38');
INSERT INTO `respuesta` VALUES ('84', 'El municipio como tal no cuenta con la infraestructura para ejercer el uso de las tecnologías de intermediación\r', '38');
INSERT INTO `respuesta` VALUES ('85', 'La infraestructura física de los centros tutoriales en donde se desarrollan los programas a distancias no permite el correcto uso de las tecnologías de intermediación', '38');
INSERT INTO `respuesta` VALUES ('86', 'Falta de motivación\r', '39');
INSERT INTO `respuesta` VALUES ('87', 'Insuficiente número de grupos de investigación\r', '39');
INSERT INTO `respuesta` VALUES ('88', 'Falta de tiempo para dedicarse a la investigación\r', '39');
INSERT INTO `respuesta` VALUES ('89', 'Ninguno de los anteriores', '39');
INSERT INTO `respuesta` VALUES ('90', 'Ha mejorado considerablemente\r', '40');
INSERT INTO `respuesta` VALUES ('91', 'Ha mejorado\r', '40');
INSERT INTO `respuesta` VALUES ('92', 'Se ha mantenido igual\r', '40');
INSERT INTO `respuesta` VALUES ('93', 'Ha desmejorado', '40');
INSERT INTO `respuesta` VALUES ('94', 'Disminuir la deserción estudiantil\r', '41');
INSERT INTO `respuesta` VALUES ('95', 'Mejorar la calidad de los programas de la universidad\r', '41');
INSERT INTO `respuesta` VALUES ('96', 'Contribuir a la mejora del desempeño académico de los estudiantes\r', '41');
INSERT INTO `respuesta` VALUES ('97', 'Ninguna de las anteriores', '41');
INSERT INTO `respuesta` VALUES ('98', 'Dificultades laborales\r', '42');
INSERT INTO `respuesta` VALUES ('99', 'Dificultades académicas\r', '42');
INSERT INTO `respuesta` VALUES ('100', 'Compromisos laborales\r', '42');
INSERT INTO `respuesta` VALUES ('101', 'Traslado a otra universidad\r', '42');
INSERT INTO `respuesta` VALUES ('102', 'Dificultades económicas', '42');
INSERT INTO `respuesta` VALUES ('103', 'Conoce\r', '43');
INSERT INTO `respuesta` VALUES ('104', 'Ha hecho uso', '43');
INSERT INTO `respuesta` VALUES ('105', 'No tienen interés en aprender segunda lengua\r', '48');
INSERT INTO `respuesta` VALUES ('106', 'No se les exige un nivel de inglés mínimo para tomar grado\r', '48');
INSERT INTO `respuesta` VALUES ('107', 'No están fundamentados cursos de inglés para estudiantes a distancia\r', '48');
INSERT INTO `respuesta` VALUES ('108', 'Todas las anteriores\r', '48');
INSERT INTO `respuesta` VALUES ('109', 'Ninguna de las anteriores', '48');
INSERT INTO `respuesta` VALUES ('110', 'Exigir un nivel mínimo de inglés para tomar grado\r', '49');
INSERT INTO `respuesta` VALUES ('111', 'Ofrecer cursos de inglés a los estudiantes a distancia\r', '49');
INSERT INTO `respuesta` VALUES ('112', 'Concientizar a los estudiantes sobre la importancia del manejo de una segunda lengua\r', '49');
INSERT INTO `respuesta` VALUES ('113', 'Incorporar módulos de inglés en los procesos curriculares de los programas a distancia', '49');
INSERT INTO `respuesta` VALUES ('118', 'Baja calificación docente en el uso de las tecnologías de intermediación\r', '51');
INSERT INTO `respuesta` VALUES ('119', 'Baja calificación estudiantil en el uso de las tecnologías de intermediación\r', '51');
INSERT INTO `respuesta` VALUES ('120', 'El municipio como tal no cuenta con la infraestructura para ejercer el uso de las tecnologías de intermediación\r', '51');
INSERT INTO `respuesta` VALUES ('121', 'La infraestructura física de los centros tutoriales en donde se desarrollan los programas a distancias no permite el correcto uso de las tecnologías de intermediación', '51');
INSERT INTO `respuesta` VALUES ('122', '1\r', '52');
INSERT INTO `respuesta` VALUES ('123', '2\r', '52');
INSERT INTO `respuesta` VALUES ('124', '3\r', '52');
INSERT INTO `respuesta` VALUES ('125', '4\r', '52');
INSERT INTO `respuesta` VALUES ('126', '5', '52');

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
  CONSTRAINT `fk_resultados_persona1` FOREIGN KEY (`persona_idpersona`) REFERENCES `persona` (`idpersona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_resultados_pregunta1` FOREIGN KEY (`pregunta_idpregunta`) REFERENCES `pregunta` (`idpregunta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_resultados_respuesta1` FOREIGN KEY (`respuesta_idrespuesta`) REFERENCES `respuesta` (`idrespuesta`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of resultados
-- ----------------------------

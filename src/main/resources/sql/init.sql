-- ===================================================
-- 포트폴리오 DB 초기화 스크립트 (doobo4202 DB)
-- 처음 실행 시 MySQL에서 직접 실행하세요
-- ===================================================

CREATE TABLE IF NOT EXISTS T_LD_CODE (
    C_BIG_CD   VARCHAR(3)   NOT NULL COMMENT '대분류코드 (10:배너, 20:개발자, 30:연락처)',
    C_SMALL_CD VARCHAR(3)   NOT NULL COMMENT '소분류코드',
    S_VALUE    VARCHAR(500) NULL     COMMENT '값',
    PRIMARY KEY (C_BIG_CD, C_SMALL_CD)
) COMMENT='코드성 정보';

CREATE TABLE IF NOT EXISTS T_LD_EXPERIENCE_INFO (
    C_PROJECT_SEQ INT          NOT NULL COMMENT '순번',
    S_COMPANY_NM  VARCHAR(100) NULL     COMMENT '회사명',
    C_START_DY    CHAR(8)      NULL     COMMENT '시작일(YYYYMMDD)',
    C_END_DY      CHAR(8)      NULL     COMMENT '종료일(YYYYMMDD)',
    C_ING_YN      CHAR(1)      DEFAULT 'N' COMMENT '재직중여부(Y/N)',
    S_GRADE_NM    VARCHAR(50)  NULL     COMMENT '직급명',
    S_SMALL_CONT  VARCHAR(255) NULL     COMMENT '간단설명',
    S_EXP_DETAIL  LONGTEXT     NULL     COMMENT '상세내용',
    C_USE_YN      CHAR(1)      DEFAULT 'Y' COMMENT '사용여부(Y/N)',
    PRIMARY KEY (C_PROJECT_SEQ)
) COMMENT='경력정보';

CREATE TABLE IF NOT EXISTS T_LD_PROJECT_INFO (
    C_PROJECT_SEQ INT          NOT NULL COMMENT '순번',
    S_PROJECT_NM  VARCHAR(100) NULL     COMMENT '프로젝트명',
    S_TAG         VARCHAR(255) NULL     COMMENT '기술태그(#구분)',
    S_SUM_IMG     VARCHAR(255) NULL     COMMENT '썸네일이미지경로',
    C_START_DY    CHAR(8)      NULL     COMMENT '시작일(YYYYMMDD)',
    C_END_DY      CHAR(8)      NULL     COMMENT '종료일(YYYYMMDD)',
    S_DETAIL_IMG  VARCHAR(255) NULL     COMMENT '상세이미지경로',
    S_DETAIL_CONT LONGTEXT     NULL     COMMENT '상세설명',
    C_USE_YN      CHAR(1)      DEFAULT 'Y' COMMENT '사용여부(Y/N)',
    PRIMARY KEY (C_PROJECT_SEQ)
) COMMENT='프로젝트정보';

CREATE TABLE IF NOT EXISTS T_LD_FAQ_LIST (
    C_FAQ_SEQ      INT          NOT NULL COMMENT '순번',
    S_FAQ_QUESTION VARCHAR(255) NULL     COMMENT '질문',
    S_FAQ_ANSWER   LONGTEXT     NULL     COMMENT '답변',
    C_USE_YN       CHAR(1)      DEFAULT 'Y' COMMENT '사용여부(Y/N)',
    PRIMARY KEY (C_FAQ_SEQ)
) COMMENT='FAQ목록';

-- 기초 코드 데이터 (이미 있는 경우 무시)
INSERT IGNORE INTO T_LD_CODE VALUES ('10', '001', '/images/landingDoobo/landingback.jpg');
INSERT IGNORE INTO T_LD_CODE VALUES ('10', '002', '안녕하세요. 개발자 포트폴리오입니다.');
INSERT IGNORE INTO T_LD_CODE VALUES ('20', '001', '이름');
INSERT IGNORE INTO T_LD_CODE VALUES ('20', '002', '백엔드 개발자');
INSERT IGNORE INTO T_LD_CODE VALUES ('20', '003', '/images/landingDoobo/photo.jpg');
INSERT IGNORE INTO T_LD_CODE VALUES ('20', '004', '안녕하세요.<br>Java/Spring Boot 기반의 백엔드 개발자입니다.');
INSERT IGNORE INTO T_LD_CODE VALUES ('20', '005', '끊임없이 성장하는 개발자가 되겠습니다.');
INSERT IGNORE INTO T_LD_CODE VALUES ('20', '006', '#Java#SpringBoot#MySQL#jQuery#JSP');
INSERT IGNORE INTO T_LD_CODE VALUES ('30', '001', 'your.email@example.com');
INSERT IGNORE INTO T_LD_CODE VALUES ('30', '002', '010-0000-0000');
INSERT IGNORE INTO T_LD_CODE VALUES ('30', '003', 'kakao_id');

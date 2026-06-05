# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 프로젝트 개요

개발자 포트폴리오 겸 소개 페이지. `landingDoobo` 폴더의 기존 프로젝트를 신규 패키지(`com.doobo`)로 재구성하고 어드민 CRUD 기능을 추가한 버전.

- **백엔드**: Spring Boot 2.7.15 / Java 1.8 / MyBatis / JSP
- **프론트**: HTML + jQuery 3.3.1 + jQuery UI
- **DB**: MySQL (doobo4202.cafe24.com / doobo4202 DB)
- **포트**: 7080

## 빌드 및 실행

```bash
# Eclipse에서 Gradle 프로젝트로 Import (Import > Existing Gradle Project)
# 또는 명령줄 실행
./gradlew bootRun

# JAR 빌드
./gradlew build
java -jar build/libs/doobo-0.0.1-SNAPSHOT.war
```

> 서버 재시작은 사용자가 직접 수행. 코드 수정 후 Eclipse에서 재시작.

## DB 초기화

처음 실행 시 MySQL에서 아래 스크립트를 수행:
```
src/main/resources/sql/init.sql
```

## 주요 URL

| URL | 설명 |
|-----|------|
| `/ld/mainPage` | 포트폴리오 메인 페이지 |
| `/admin` | 어드민 대시보드 |
| `/admin/code` | 코드 관리 (배너/개발자정보/연락처) |
| `/admin/experience` | 경력 관리 (CRUD) |
| `/admin/project` | 프로젝트 관리 (CRUD) |
| `/admin/faq` | FAQ 관리 (CRUD) |

## 아키텍처

```
Controller → Service → DAO (interface) → MyBatis XML → MySQL
```

- **패키지**: `com.doobo.controller`, `com.doobo.service`, `com.doobo.dao`
- **매퍼 XML**: `src/main/resources/mapper/*.xml`
- **JSP**: `src/main/webapp/WEB-INF/jsp/`
  - `landingDoobo/` - 포트폴리오 화면
  - `admin/` - 관리자 화면
- **정적 파일**: `src/main/resources/static/`

## DB 테이블

| 테이블 | 용도 |
|--------|------|
| `T_LD_CODE` | 배너/개발자정보/연락처 (C_BIG_CD: 10=배너, 20=개발자, 30=연락처) |
| `T_LD_EXPERIENCE_INFO` | 경력정보 |
| `T_LD_PROJECT_INFO` | 프로젝트/포트폴리오 |
| `T_LD_FAQ_LIST` | FAQ 목록 |

## AS-IS 프로젝트

`landingDoobo/` 폴더 — 참고용 기존 프로젝트 (패키지: `landingDoobo`).

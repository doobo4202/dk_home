<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>DOOBO ADMIN</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/css/jquery-ui/jquery-ui.css">
<link rel="stylesheet" href="/css/admin/admin.css">
<script src="/js/jquery/jquery-3.3.1.min.js"></script>
<script src="/js/jquery-ui/jquery-ui.js"></script>
<script src="/js/common/common.js"></script>
<script>
/* 공통 토스트 알림 */
function showToast(msg, type) {
    var $t = $("#admToast");
    if (!$t.length) {
        $t = $('<div id="admToast" class="adm-toast"></div>').appendTo("body");
    }
    $t.attr("class", "adm-toast " + (type||"")).text(msg);
    setTimeout(function(){ $t.addClass("show"); }, 10);
    setTimeout(function(){ $t.removeClass("show"); }, 3000);
}
</script>
</head>
<body>

<!-- 사이드바 -->
<aside class="adm-sidebar" id="admSidebar">
    <div class="sb-logo">
        <a href="/admin">DOOBO ADMIN</a>
        <p>포트폴리오 관리 시스템</p>
    </div>
    <div class="sb-section">컨텐츠</div>
    <ul class="sb-nav">
        <li><a href="/admin/devInfo"><span class="ico">👤</span>개발자 정보</a></li>
        <li><a href="/admin/experience"><span class="ico">💼</span>경력 관리</a></li>
        <li><a href="/admin/project"><span class="ico">📁</span>프로젝트 관리</a></li>
        <li><a href="/admin/faq"><span class="ico">❓</span>FAQ 관리</a></li>
        <li><a href="/admin/contact"><span class="ico">📞</span>연락처 관리</a></li>
    </ul>
    <div class="sb-bottom">
        <a href="/ld/mainPage" target="_blank">🔗 사이트 보기</a>
    </div>
</aside>

<!-- 메인 영역 -->
<div class="adm-main">
<div class="adm-topbar">
    <div class="adm-breadcrumb">
        ADMIN &nbsp;/&nbsp; <strong id="pageTitle">대시보드</strong>
    </div>
    <div class="adm-topbar-right">
        <button class="adm-view-btn" onclick="window.open('/ld/mainPage','_blank')">🔗 사이트 보기</button>
    </div>
</div>
<div class="adm-content">

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/admin/include/adminHeader.jsp" %>
<script>
$(function(){
    $("#pageTitle").text("대시보드");
    // 각 섹션 데이터 건수 조회
    AJAX_COLL("/admin/experience/list",{},  "","", function(d){ if(d.result==="success") $("#cntExp").text((d.list||[]).filter(function(r){return r.USE_YN==="Y";}).length); });
    AJAX_COLL("/admin/project/list",    {}, "","", function(d){ if(d.result==="success") $("#cntProj").text((d.list||[]).filter(function(r){return r.USE_YN==="Y";}).length); });
    AJAX_COLL("/admin/faq/list",        {}, "","", function(d){ if(d.result==="success") $("#cntFaq").text((d.list||[]).filter(function(r){return r.USE_YN==="Y";}).length); });
});
</script>

<div class="adm-page-title">대시보드</div>
<div class="adm-page-desc">포트폴리오 컨텐츠를 관리합니다.</div>

<div class="adm-stats">
    <div class="adm-stat-card"><div class="ico">💼</div><div class="num" id="cntExp">-</div><div class="lbl">등록된 경력</div></div>
    <div class="adm-stat-card"><div class="ico">📁</div><div class="num" id="cntProj">-</div><div class="lbl">등록된 프로젝트</div></div>
    <div class="adm-stat-card"><div class="ico">❓</div><div class="num" id="cntFaq">-</div><div class="lbl">등록된 FAQ</div></div>
    <div class="adm-stat-card"><div class="ico">✅</div><div class="num">ON</div><div class="lbl">사이트 상태</div></div>
</div>

<div class="adm-card">
    <div class="adm-card-title">빠른 관리</div>
    <div class="adm-shortcuts">
        <a href="/admin/devInfo" class="adm-shortcut"><div class="s-ico">👤</div><div class="s-title">개발자 정보</div><div class="s-desc">이름, 소개, 프로필 사진, 태그 관리</div></a>
        <a href="/admin/experience" class="adm-shortcut"><div class="s-ico">💼</div><div class="s-title">경력 관리</div><div class="s-desc">경력 및 이력 등록 · 수정 · 삭제</div></a>
        <a href="/admin/project" class="adm-shortcut"><div class="s-ico">📁</div><div class="s-title">프로젝트 관리</div><div class="s-desc">포트폴리오 프로젝트 등록 · 수정 · 삭제</div></a>
        <a href="/admin/faq" class="adm-shortcut"><div class="s-ico">❓</div><div class="s-title">FAQ 관리</div><div class="s-desc">자주묻는질문 등록 · 수정 · 삭제</div></a>
        <a href="/admin/contact" class="adm-shortcut"><div class="s-ico">📞</div><div class="s-title">연락처 관리</div><div class="s-desc">이메일, 전화번호, 카카오톡 관리</div></a>
    </div>
</div>

<%@ include file="/WEB-INF/jsp/admin/include/adminFooter.jsp" %>

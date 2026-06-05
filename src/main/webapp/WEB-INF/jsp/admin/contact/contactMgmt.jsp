<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/admin/include/adminHeader.jsp" %>
<script>
$(function(){
    $("#pageTitle").text("연락처 관리");
    fn_load();
});

function fn_load() {
    AJAX_COLL("/admin/contact/load",{},  "","", function(d){
        if (d.result !== "success") { showToast("데이터 로딩 실패","error"); return; }
        $("#contactMail").val(d.contactMail);
        $("#contactCall").val(d.contactCall);
        $("#contactTalk").val(d.contactTalk);
    });
}

function fn_save() {
    var param = {
        contactMail: $("#contactMail").val(),
        contactCall: $("#contactCall").val(),
        contactTalk: $("#contactTalk").val()
    };
    AJAX_COLL("/admin/contact/save", param, "","", function(d){
        if (d.result === "success") showToast("저장되었습니다.","success");
        else showToast("오류: " + d.message,"error");
    });
}
</script>

<div class="adm-page-title">연락처 관리</div>
<div class="adm-page-desc">메인 페이지 연락처 섹션에 표시되는 정보를 수정합니다.</div>

<div class="adm-card">
    <div class="adm-card-title">📞 연락처 정보</div>
    <div class="adm-form">
        <div class="adm-field">
            <label>이메일</label>
            <input type="text" id="contactMail" class="adm-input" placeholder="your@email.com">
        </div>
        <div class="adm-field">
            <label>전화번호</label>
            <input type="text" id="contactCall" class="adm-input" placeholder="010-0000-0000">
        </div>
        <div class="adm-field">
            <label>카카오톡 ID</label>
            <input type="text" id="contactTalk" class="adm-input" placeholder="카카오톡 아이디">
        </div>
    </div>
</div>

<div style="display:flex; justify-content:flex-end; gap:10px;">
    <button class="btn btn-outline" onclick="fn_load()">↺ 초기화</button>
    <button class="btn btn-grad" onclick="fn_save()">💾 저장하기</button>
</div>

<%@ include file="/WEB-INF/jsp/admin/include/adminFooter.jsp" %>

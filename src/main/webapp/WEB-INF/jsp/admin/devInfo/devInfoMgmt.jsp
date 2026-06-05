<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/admin/include/adminHeader.jsp" %>
<script>
$(function(){
    $("#pageTitle").text("개발자 정보");
    fn_load();
    // 이미지 경로 입력 시 미리보기
    $(document).on("input","#devImg", function(){ fn_preview($(this).val()); });
});

function fn_load() {
    AJAX_COLL("/admin/devInfo/load",{},  "","", function(d){
        if (d.result !== "success") { showToast("데이터 로딩 실패","error"); return; }
        $("#devNm").val(d.devNm);
        $("#devPart").val(d.devPart);
        $("#devImg").val(d.devImg);
        $("#devText").val(d.devText);
        $("#devMsg").val(d.devMsg);
        $("#devTag").val(d.devTag);
        $("#mainText").val(d.mainText);
        fn_preview(d.devImg);
    });
}

function fn_preview(src) {
    if (src) {
        $("#imgThumb").html("<img src='" + src + "' onerror=\"this.style.display='none'\"/>");
    } else {
        $("#imgThumb").html("🖼");
    }
}

function fn_save() {
    var param = {
        devNm:    $("#devNm").val(),
        devPart:  $("#devPart").val(),
        devImg:   $("#devImg").val(),
        devText:  $("#devText").val(),
        devMsg:   $("#devMsg").val(),
        devTag:   $("#devTag").val(),
        mainText: $("#mainText").val()
    };
    if (!param.devNm) { showToast("개발자 이름을 입력하세요.","error"); return; }
    AJAX_COLL("/admin/devInfo/save", param, "","", function(d){
        if (d.result === "success") showToast("저장되었습니다.","success");
        else showToast("오류: " + d.message, "error");
    });
}
</script>

<div class="adm-page-title">개발자 정보 관리</div>
<div class="adm-page-desc">메인 페이지에 표시되는 개발자 프로필 정보를 수정합니다.</div>

<div class="adm-card">
    <div class="adm-card-title">🏠 메인 배너</div>
    <div class="adm-form">
        <div class="adm-field">
            <label>배너 텍스트</label>
            <input type="text" id="mainText" class="adm-input" placeholder="메인 배너에 표시될 문구">
        </div>
    </div>
</div>

<div class="adm-card">
    <div class="adm-card-title">👤 개발자 프로필</div>
    <div class="adm-form">
        <div class="adm-form-row">
            <div class="adm-field">
                <label>이름 <span class="req">*</span></label>
                <input type="text" id="devNm" class="adm-input" placeholder="홍길동">
            </div>
            <div class="adm-field">
                <label>직급 / 직책</label>
                <input type="text" id="devPart" class="adm-input" placeholder="백엔드 개발자">
            </div>
        </div>
        <div class="adm-field">
            <label>프로필 사진 경로</label>
            <div class="img-preview-wrap">
                <input type="text" id="devImg" class="adm-input" placeholder="/images/landingDoobo/photo.jpg">
                <div class="img-thumb" id="imgThumb">🖼</div>
            </div>
            <p class="hint">서버에 업로드된 이미지 경로를 입력하세요. (예: /images/landingDoobo/photo.jpg)</p>
        </div>
        <div class="adm-field">
            <label>기술 태그</label>
            <input type="text" id="devTag" class="adm-input" placeholder="#Java#SpringBoot#MySQL#jQuery">
            <p class="hint"># 기호로 구분하여 입력 (예: #Java#SpringBoot#MySQL)</p>
        </div>
        <div class="adm-field">
            <label>소개 텍스트</label>
            <textarea id="devText" class="adm-input" rows="4" placeholder="개발자 소개 문구를 입력하세요.&#10;HTML 태그 사용 가능 (예: &lt;br&gt; 줄바꿈)"></textarea>
        </div>
        <div class="adm-field">
            <label>핵심 메시지</label>
            <input type="text" id="devMsg" class="adm-input" placeholder="끊임없이 성장하는 개발자가 되겠습니다.">
            <p class="hint">인용문 형식으로 페이지 하단에 표시됩니다.</p>
        </div>
    </div>
</div>

<div style="display:flex; justify-content:flex-end; gap:10px;">
    <button class="btn btn-outline" onclick="fn_load()">↺ 초기화</button>
    <button class="btn btn-grad" onclick="fn_save()">💾 저장하기</button>
</div>

<%@ include file="/WEB-INF/jsp/admin/include/adminFooter.jsp" %>

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/admin/include/adminHeader.jsp" %>
<script>
$(function(){ $("#pageTitle").text("프로젝트 관리"); fn_list(); });

function fn_list() {
    AJAX_COLL("/admin/project/list",{},  "","", function(d){
        if (d.result !== "success") return;
        var html = "";
        (d.list||[]).forEach(function(r){
            var badge = r.USE_YN==="Y" ? "<span class='badge-on'>사용</span>" : "<span class='badge-off'>미사용</span>";
            var thumb = r.SUM_IMG ? "<img src='"+r.SUM_IMG+"' style='width:48px;height:36px;object-fit:cover;border-radius:6px;border:1px solid var(--border)' onerror=\"this.style.display='none'\"/>" : "—";
            html += "<tr>";
            html += "<td class='td-center'>"+r.SEQ+"</td>";
            html += "<td>"+thumb+"</td>";
            html += "<td><strong>"+(r.PROJECT_NM||"")+"</strong></td>";
            html += "<td style='max-width:180px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;color:var(--text2)'>"+(r.TAG||"")+"</td>";
            html += "<td>"+(r.START_DY||"")+(r.END_DY?" ~ "+r.END_DY:"")+"</td>";
            html += "<td class='td-center'>"+badge+"</td>";
            html += "<td class='td-actions'>";
            html += "<button class='btn btn-sm btn-outline' onclick='fn_openModal("+r.SEQ+")'>수정</button> ";
            if (r.USE_YN==="Y") html += "<button class='btn btn-sm btn-danger' onclick='fn_delete("+r.SEQ+")'>삭제</button>";
            else html += "<button class='btn btn-sm btn-success' onclick='fn_restore("+r.SEQ+")'>복원</button>";
            html += "</td></tr>";
        });
        $("#tBody").html(html || "<tr><td colspan='7' style='text-align:center;color:var(--text2);padding:32px'>등록된 프로젝트가 없습니다.</td></tr>");
    });
}

function fn_openModal(seq) {
    fn_resetForm();
    if (seq) {
        AJAX_COLL("/admin/project/detail",{seq:seq},"","",function(d){
            if (d.result!=="success"||!d.detail) return;
            var r=d.detail;
            $("#fSeq").val(r.SEQ); $("#fProjectNm").val(r.PROJECT_NM);
            $("#fTag").val(r.TAG); $("#fSumImg").val(r.SUM_IMG);
            $("#fStartDy").val(r.START_DY); $("#fEndDy").val(r.END_DY);
            $("#fDetailImg").val(r.DETAIL_IMG); $("#fDetailCont").val(r.DETAIL_CONT);
            fn_previewThumb(r.SUM_IMG);
            $("#modalTitle").text("프로젝트 수정");
            $("#projModal").addClass("open");
        });
    } else {
        $("#modalTitle").text("프로젝트 추가");
        $("#projModal").addClass("open");
    }
}

function fn_previewThumb(src) {
    if (src) $("#thumbPreview").html("<img src='"+src+"' onerror=\"this.style.display='none'\"/>");
    else $("#thumbPreview").html("🖼");
}

$(document).on("input","#fSumImg",function(){ fn_previewThumb($(this).val()); });

function fn_resetForm() {
    $("#fSeq,#fProjectNm,#fTag,#fSumImg,#fStartDy,#fEndDy,#fDetailImg,#fDetailCont").val("");
    $("#thumbPreview").html("🖼");
}

function fn_save() {
    if (!$.trim($("#fProjectNm").val())) { showToast("프로젝트명을 입력하세요.","error"); return; }
    var param = {
        seq:       $("#fSeq").val(),       projectNm: $("#fProjectNm").val(),
        tag:       $("#fTag").val(),        sumImg:    $("#fSumImg").val(),
        startDy:   $("#fStartDy").val(),   endDy:     $("#fEndDy").val(),
        detailImg: $("#fDetailImg").val(), detailCont:$("#fDetailCont").val()
    };
    AJAX_COLL("/admin/project/save",param,"","",function(d){
        if (d.result==="success"){ fn_closeModal(); fn_list(); showToast("저장되었습니다.","success"); }
        else showToast("오류: "+d.message,"error");
    });
}

function fn_delete(seq) {
    if (!confirm("삭제하시겠습니까?\n(사이트에서 숨겨지며 복원 가능합니다)")) return;
    AJAX_COLL("/admin/project/delete",{seq:seq},"","",function(d){
        if (d.result==="success"){ fn_list(); showToast("삭제되었습니다.","success"); }
        else showToast("오류: "+d.message,"error");
    });
}

function fn_restore(seq) {
    AJAX_COLL("/admin/project/restore",{seq:seq},"","",function(d){
        if (d.result==="success"){ fn_list(); showToast("복원되었습니다.","success"); }
        else showToast("오류: "+d.message,"error");
    });
}

function fn_closeModal() { $("#projModal").removeClass("open"); }
</script>

<div class="adm-page-title">프로젝트 관리</div>
<div class="adm-page-desc">메인 페이지에 표시되는 포트폴리오 프로젝트를 등록·수정·삭제합니다.</div>

<div class="adm-card">
    <div class="adm-toolbar">
        <div class="adm-card-title" style="margin:0;border:0;padding:0">프로젝트 목록</div>
        <button class="btn btn-grad" onclick="fn_openModal(null)">+ 프로젝트 추가</button>
    </div>
    <br>
    <div class="adm-table-wrap">
        <table class="adm-table">
            <thead><tr>
                <th style="width:60px">SEQ</th><th style="width:70px">썸네일</th><th>프로젝트명</th>
                <th>태그</th><th>기간</th><th style="width:80px">상태</th><th style="width:130px">관리</th>
            </tr></thead>
            <tbody id="tBody"></tbody>
        </table>
    </div>
</div>

<!-- 모달 -->
<div class="modal-overlay" id="projModal">
    <div class="modal-box wide">
        <div class="modal-header">
            <h3 id="modalTitle">프로젝트 추가</h3>
            <button class="modal-close" onclick="fn_closeModal()">×</button>
        </div>
        <div class="modal-body">
            <input type="hidden" id="fSeq">
            <div class="adm-form">
                <div class="adm-field">
                    <label>프로젝트명 <span class="req">*</span></label>
                    <input type="text" id="fProjectNm" class="adm-input" placeholder="프로젝트명">
                </div>
                <div class="adm-field">
                    <label>기술 태그</label>
                    <input type="text" id="fTag" class="adm-input" placeholder="#Java#SpringBoot#MySQL">
                    <p class="hint"># 기호로 구분하여 입력</p>
                </div>
                <div class="adm-field">
                    <label>썸네일 이미지 경로</label>
                    <div class="img-preview-wrap">
                        <input type="text" id="fSumImg" class="adm-input" placeholder="/images/landingDoobo/project/xxx.png">
                        <div class="img-thumb" id="thumbPreview">🖼</div>
                    </div>
                </div>
                <div class="adm-form-row">
                    <div class="adm-field">
                        <label>시작일</label>
                        <input type="text" id="fStartDy" class="adm-input" placeholder="20230101">
                        <p class="hint">YYYYMMDD 형식</p>
                    </div>
                    <div class="adm-field">
                        <label>종료일</label>
                        <input type="text" id="fEndDy" class="adm-input" placeholder="20231231">
                    </div>
                </div>
                <div class="adm-field">
                    <label>상세 이미지 경로</label>
                    <input type="text" id="fDetailImg" class="adm-input" placeholder="/images/landingDoobo/project/xxx.png">
                </div>
                <div class="adm-field">
                    <label>상세 설명</label>
                    <textarea id="fDetailCont" class="adm-input" rows="5" placeholder="프로젝트 상세 설명을 입력하세요."></textarea>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button class="btn btn-outline" onclick="fn_closeModal()">취소</button>
            <button class="btn btn-grad" onclick="fn_save()">💾 저장</button>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/jsp/admin/include/adminFooter.jsp" %>

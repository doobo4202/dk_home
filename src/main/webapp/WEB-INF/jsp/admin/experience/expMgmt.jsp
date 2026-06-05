<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/admin/include/adminHeader.jsp" %>
<script>
$(function(){ $("#pageTitle").text("경력 관리"); fn_list(); });

function fn_list() {
    AJAX_COLL("/admin/experience/list",{},  "","", function(d){
        if (d.result !== "success") return;
        var html = "";
        (d.list||[]).forEach(function(r){
            var badge = r.USE_YN==="Y" ? "<span class='badge-on'>사용</span>" : "<span class='badge-off'>미사용</span>";
            var endDy = r.ING_YN==="Y" ? "<span class='badge-on'>재직중</span>" : (r.END_DY||"");
            html += "<tr>";
            html += "<td class='td-center'>"+r.SEQ+"</td>";
            html += "<td><strong>"+(r.COMPANY_NM||"")+"</strong></td>";
            html += "<td>"+(r.START_DY||"")+" ~ "+endDy+"</td>";
            html += "<td>"+(r.GRADE_NM||"")+"</td>";
            html += "<td style='max-width:220px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap'>"+(r.SMALL_CONT||"")+"</td>";
            html += "<td class='td-center'>"+badge+"</td>";
            html += "<td class='td-actions'>";
            html += "<button class='btn btn-sm btn-outline' onclick='fn_openModal("+r.SEQ+")'>수정</button> ";
            if (r.USE_YN==="Y") html += "<button class='btn btn-sm btn-danger' onclick='fn_delete("+r.SEQ+")'>삭제</button>";
            else html += "<button class='btn btn-sm btn-success' onclick='fn_restore("+r.SEQ+")'>복원</button>";
            html += "</td></tr>";
        });
        $("#tBody").html(html || "<tr><td colspan='7' style='text-align:center;color:var(--text2);padding:32px'>등록된 경력이 없습니다.</td></tr>");
    });
}

function fn_openModal(seq) {
    fn_resetForm();
    if (seq) {
        AJAX_COLL("/admin/experience/detail",{seq:seq},"","",function(d){
            if (d.result!=="success"||!d.detail) return;
            var r=d.detail;
            $("#fSeq").val(r.SEQ); $("#fCompanyNm").val(r.COMPANY_NM);
            $("#fStartDy").val(r.START_DY); $("#fEndDy").val(r.END_DY);
            $("#fIngYn").val(r.ING_YN); $("#fGradeNm").val(r.GRADE_NM);
            $("#fSmallCont").val(r.SMALL_CONT); $("#fExpDetail").val(r.EXP_DETAIL);
            $("#modalTitle").text("경력 수정");
            $("#expModal").addClass("open");
        });
    } else {
        $("#modalTitle").text("경력 추가");
        $("#expModal").addClass("open");
    }
}

function fn_resetForm() {
    $("#fSeq,#fCompanyNm,#fStartDy,#fEndDy,#fGradeNm,#fSmallCont,#fExpDetail").val("");
    $("#fIngYn").val("N");
}

function fn_save() {
    if (!$.trim($("#fCompanyNm").val())) { showToast("회사명을 입력하세요.","error"); return; }
    var param = {
        seq:       $("#fSeq").val(),       companyNm: $("#fCompanyNm").val(),
        startDy:   $("#fStartDy").val(),   endDy:     $("#fEndDy").val(),
        ingYn:     $("#fIngYn").val(),      gradeNm:  $("#fGradeNm").val(),
        smallCont: $("#fSmallCont").val(), expDetail: $("#fExpDetail").val()
    };
    AJAX_COLL("/admin/experience/save",param,"","",function(d){
        if (d.result==="success"){ fn_closeModal(); fn_list(); showToast("저장되었습니다.","success"); }
        else showToast("오류: "+d.message,"error");
    });
}

function fn_delete(seq) {
    if (!confirm("삭제하시겠습니까?\n(사이트에서 숨겨지며 복원 가능합니다)")) return;
    AJAX_COLL("/admin/experience/delete",{seq:seq},"","",function(d){
        if (d.result==="success"){ fn_list(); showToast("삭제되었습니다.","success"); }
        else showToast("오류: "+d.message,"error");
    });
}

function fn_restore(seq) {
    AJAX_COLL("/admin/experience/restore",{seq:seq},"","",function(d){
        if (d.result==="success"){ fn_list(); showToast("복원되었습니다.","success"); }
        else showToast("오류: "+d.message,"error");
    });
}

function fn_closeModal() { $("#expModal").removeClass("open"); }
</script>

<div class="adm-page-title">경력 관리</div>
<div class="adm-page-desc">메인 페이지에 표시되는 경력 정보를 등록·수정·삭제합니다.</div>

<div class="adm-card">
    <div class="adm-toolbar">
        <div class="adm-card-title" style="margin:0;border:0;padding:0">경력 목록</div>
        <button class="btn btn-grad" onclick="fn_openModal(null)">+ 경력 추가</button>
    </div>
    <br>
    <div class="adm-table-wrap">
        <table class="adm-table">
            <thead><tr>
                <th style="width:60px">SEQ</th><th>회사명</th><th>기간</th>
                <th>직급</th><th>간단설명</th><th style="width:80px">상태</th><th style="width:130px">관리</th>
            </tr></thead>
            <tbody id="tBody"></tbody>
        </table>
    </div>
</div>

<!-- 모달 -->
<div class="modal-overlay" id="expModal">
    <div class="modal-box wide">
        <div class="modal-header">
            <h3 id="modalTitle">경력 추가</h3>
            <button class="modal-close" onclick="fn_closeModal()">×</button>
        </div>
        <div class="modal-body">
            <input type="hidden" id="fSeq">
            <div class="adm-form">
                <div class="adm-form-row">
                    <div class="adm-field">
                        <label>회사명 <span class="req">*</span></label>
                        <input type="text" id="fCompanyNm" class="adm-input" placeholder="회사명">
                    </div>
                    <div class="adm-field">
                        <label>직급</label>
                        <input type="text" id="fGradeNm" class="adm-input" placeholder="사원 / 대리 / 과장">
                    </div>
                </div>
                <div class="adm-form-row cols3">
                    <div class="adm-field">
                        <label>시작일</label>
                        <input type="text" id="fStartDy" class="adm-input" placeholder="20200101">
                        <p class="hint">YYYYMMDD 형식</p>
                    </div>
                    <div class="adm-field">
                        <label>종료일</label>
                        <input type="text" id="fEndDy" class="adm-input" placeholder="20221231">
                        <p class="hint">재직중이면 비워두기</p>
                    </div>
                    <div class="adm-field">
                        <label>재직중 여부</label>
                        <select id="fIngYn" class="adm-input">
                            <option value="N">아니오</option>
                            <option value="Y">재직중</option>
                        </select>
                    </div>
                </div>
                <div class="adm-field">
                    <label>간단 설명</label>
                    <input type="text" id="fSmallCont" class="adm-input" placeholder="주요 업무 한 줄 요약">
                </div>
                <div class="adm-field">
                    <label>상세 내용</label>
                    <textarea id="fExpDetail" class="adm-input" rows="5" placeholder="상세 업무 내용을 입력하세요."></textarea>
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

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/admin/include/adminHeader.jsp" %>
<script>
$(function(){ $("#pageTitle").text("FAQ 관리"); fn_list(); });

function fn_list() {
    AJAX_COLL("/admin/faq/list",{},  "","", function(d){
        if (d.result !== "success") return;
        var html = "";
        (d.list||[]).forEach(function(r){
            var badge = r.USE_YN==="Y" ? "<span class='badge-on'>사용</span>" : "<span class='badge-off'>미사용</span>";
            var ans = r.FAQ_ANSWER ? r.FAQ_ANSWER.substring(0,60)+(r.FAQ_ANSWER.length>60?"...":"") : "";
            html += "<tr>";
            html += "<td class='td-center'>"+r.SEQ+"</td>";
            html += "<td><strong>"+(r.FAQ_QUESTION||"")+"</strong></td>";
            html += "<td style='color:var(--text2)'>"+ans+"</td>";
            html += "<td class='td-center'>"+badge+"</td>";
            html += "<td class='td-actions'>";
            html += "<button class='btn btn-sm btn-outline' onclick='fn_openModal("+r.SEQ+")'>수정</button> ";
            if (r.USE_YN==="Y") html += "<button class='btn btn-sm btn-danger' onclick='fn_delete("+r.SEQ+")'>삭제</button>";
            else html += "<button class='btn btn-sm btn-success' onclick='fn_restore("+r.SEQ+")'>복원</button>";
            html += "</td></tr>";
        });
        $("#tBody").html(html || "<tr><td colspan='5' style='text-align:center;color:var(--text2);padding:32px'>등록된 FAQ가 없습니다.</td></tr>");
    });
}

function fn_openModal(seq) {
    fn_resetForm();
    if (seq) {
        AJAX_COLL("/admin/faq/detail",{seq:seq},"","",function(d){
            if (d.result!=="success"||!d.detail) return;
            var r=d.detail;
            $("#fSeq").val(r.SEQ); $("#fQuestion").val(r.FAQ_QUESTION); $("#fAnswer").val(r.FAQ_ANSWER);
            $("#modalTitle").text("FAQ 수정");
            $("#faqModal").addClass("open");
        });
    } else {
        $("#modalTitle").text("FAQ 추가");
        $("#faqModal").addClass("open");
    }
}

function fn_resetForm() { $("#fSeq,#fQuestion,#fAnswer").val(""); }

function fn_save() {
    if (!$.trim($("#fQuestion").val())) { showToast("질문을 입력하세요.","error"); return; }
    var param = { seq:$("#fSeq").val(), faqQuestion:$("#fQuestion").val(), faqAnswer:$("#fAnswer").val() };
    AJAX_COLL("/admin/faq/save",param,"","",function(d){
        if (d.result==="success"){ fn_closeModal(); fn_list(); showToast("저장되었습니다.","success"); }
        else showToast("오류: "+d.message,"error");
    });
}

function fn_delete(seq) {
    if (!confirm("삭제하시겠습니까?")) return;
    AJAX_COLL("/admin/faq/delete",{seq:seq},"","",function(d){
        if (d.result==="success"){ fn_list(); showToast("삭제되었습니다.","success"); }
        else showToast("오류: "+d.message,"error");
    });
}

function fn_restore(seq) {
    AJAX_COLL("/admin/faq/restore",{seq:seq},"","",function(d){
        if (d.result==="success"){ fn_list(); showToast("복원되었습니다.","success"); }
        else showToast("오류: "+d.message,"error");
    });
}

function fn_closeModal() { $("#faqModal").removeClass("open"); }
</script>

<div class="adm-page-title">FAQ 관리</div>
<div class="adm-page-desc">메인 페이지에 표시되는 자주묻는질문을 등록·수정·삭제합니다.</div>

<div class="adm-card">
    <div class="adm-toolbar">
        <div class="adm-card-title" style="margin:0;border:0;padding:0">FAQ 목록</div>
        <button class="btn btn-grad" onclick="fn_openModal(null)">+ FAQ 추가</button>
    </div>
    <br>
    <div class="adm-table-wrap">
        <table class="adm-table">
            <thead><tr>
                <th style="width:60px">SEQ</th><th>질문</th><th>답변 미리보기</th>
                <th style="width:80px">상태</th><th style="width:130px">관리</th>
            </tr></thead>
            <tbody id="tBody"></tbody>
        </table>
    </div>
</div>

<!-- 모달 -->
<div class="modal-overlay" id="faqModal">
    <div class="modal-box">
        <div class="modal-header">
            <h3 id="modalTitle">FAQ 추가</h3>
            <button class="modal-close" onclick="fn_closeModal()">×</button>
        </div>
        <div class="modal-body">
            <input type="hidden" id="fSeq">
            <div class="adm-form">
                <div class="adm-field">
                    <label>질문 <span class="req">*</span></label>
                    <input type="text" id="fQuestion" class="adm-input" placeholder="질문 내용을 입력하세요.">
                </div>
                <div class="adm-field">
                    <label>답변</label>
                    <textarea id="fAnswer" class="adm-input" rows="6" placeholder="답변 내용을 입력하세요."></textarea>
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

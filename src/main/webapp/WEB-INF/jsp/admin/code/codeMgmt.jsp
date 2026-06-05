<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/admin/include/adminHeader.jsp" %>
<script>
$(function(){ fn_list(); });

function fn_list() {
    AJAX_COLL("/admin/code/list", {}, "", "", function(data) {
        if (data.result !== "FAIL") {
            var html = "";
            (data.list || []).forEach(function(row) {
                html += "<tr>";
                html += "<td>" + row.BIG_NM + "</td>";
                html += "<td>" + row.SMALL_NM + "</td>";
                html += "<td><input type='text' class='adm-input' style='width:100%' value='" + (row.S_VALUE || "") + "'" +
                        " data-big='" + row.C_BIG_CD + "' data-small='" + row.C_SMALL_CD + "'></td>";
                html += "<td><button class='adm-btn' onclick='fn_save(this)'>저장</button></td>";
                html += "</tr>";
            });
            $("#tBody").html(html);
        }
    });
}

function fn_save(btn) {
    var input = $(btn).closest("tr").find("input");
    var param = {
        cBigCd:   input.data("big"),
        cSmallCd: input.data("small"),
        sValue:   input.val()
    };
    AJAX_COLL("/admin/code/save", param, "", "", function(data) {
        if (data.result === "success") {
            DIV_ALERT("저장되었습니다.");
        } else {
            DIV_ALERT("오류: " + data.message);
        }
    });
}
</script>

<div class="adm-page-title">코드 관리</div>
<div class="adm-desc">배너, 개발자 정보, 연락처 값을 수정합니다.</div>
<table class="adm-table">
    <thead>
        <tr><th>분류</th><th>항목</th><th>값</th><th>저장</th></tr>
    </thead>
    <tbody id="tBody"></tbody>
</table>

<%@ include file="/WEB-INF/jsp/admin/include/adminFooter.jsp" %>
<%@ include file="/WEB-INF/jsp/common/include/divAlert.jsp" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
    $(function() {
        fn_schProjectDetail();
    });

    function fn_schProjectDetail() {
        var param = { projectSeq: $("#projectSeq").val() };
        AJAX_COLL("/project/schProjectDetail", param, "", "", fn_sucSchProjectDetail);
    }

    function fn_sucSchProjectDetail(data) {
        if (data.result !== "FAIL") {
            var detail = data.detail;
            $("#projectNm").html(detail.PROJECT_NM);
            $("#projectCont").html(detail.DETAIL_CONT);
            if (detail.DETAIL_IMG) {
                $("#mainImg").attr("src", detail.DETAIL_IMG);
            }
            var tags = detail.PROJECT_TAG ? detail.PROJECT_TAG.split("#").filter(function(v){ return v !== ""; }) : [];
            var tagHtml = "";
            tags.forEach(function(item) { tagHtml += "<span>#" + item + "</span>"; });
            $("#projectTag").html(tagHtml);
        }
    }
</script>
<input type="hidden" id="projectSeq" value="<c:out value='${seq}'/>"/>

<div class="project-popup-card">
    <button type="button" class="popup-close-btn" onclick="fn_closePopup()">×</button>
    <h2 class="popup-header">프로젝트 상세</h2>
    <div class="popup-inner">
        <div class="popup-left">
            <div class="main-image">
                <img id="mainImg" src="/images/landingDoobo/project/img_ing.png" alt="project image">
            </div>
        </div>
        <div class="popup-right">
            <h3 class="popup-title" id="projectNm"></h3>
            <div class="popup-tags" id="projectTag"></div>
            <div class="popup-section">
                <h4>상세 설명</h4>
                <p id="projectCont"></p>
            </div>
        </div>
    </div>
</div>

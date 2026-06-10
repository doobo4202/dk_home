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
            var imgSrc = detail.SUM_IMG || detail.DETAIL_IMG || "";
            if (imgSrc) {
                $("#mainImg").attr("src", imgSrc);
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

    <!-- 왼쪽 패널: 이미지 + 태그 -->
    <div class="popup-left">
        <div class="popup-left-badge">PROJECT</div>
        <div class="popup-thumb">
            <img id="mainImg" src="/images/landingDoobo/project/img_ing.png" alt="project image">
        </div>
        <div class="popup-tags" id="projectTag"></div>
    </div>

    <!-- 오른쪽 패널: 제목 + 설명 -->
    <div class="popup-right">
        <h3 class="popup-title" id="projectNm"></h3>
        <div class="popup-section-label">Project Description</div>
        <p class="popup-desc" id="projectCont"></p>
    </div>
</div>

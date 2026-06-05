<%@ page language = "java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%>
<script type="text/javascript">
  //<![CDATA[
  $(function() {
    fn_schProjectDetail();
  })

  function fn_schProjectDetail() {
    $("#projectSeq").val();

    var param = new Object();
    param.projectSeq = $("#projectSeq").val();

    var url = "/project/schProjectDetail";
    AJAX_COLL(url, param, "", "", fn_sucSchProjectDetail);
  }

  function fn_sucSchProjectDetail(data) {
    if (data.resultCd !== "FAIL") {
      var detail = data.detail;

      $("#projectNm").html(detail.PROJECT_NM);
      $("#projectCont").html(detail.DETAIL_CONT);

      var projectTag = detail.PROJECT_TAG.split("#").filter(v => v !== "");
      var tagHtml = "";
      projectTag.forEach(function(item, idx){
        tagHtml += "<span>#"+item+"</span>";
      });
      $("#projectTag").html(tagHtml);

    }
  }
  //]]>
</script>
<input type="hidden" id="projectSeq" value="<c:out value="${seq}" />" />
  <div class="project-popup-card">

    <button type="button" class="popup-close-btn" onclick="fn_closePopup()">×</button>
    <h2 class="popup-header">프로젝트 상세</h2>
    <div class="popup-inner">
      <!-- LEFT : 이미지 -->
      <div class="popup-left">
        <div class="main-image">
          <img src="/images/landingDoobo/project/img_ing.png" alt="project image">
        </div>

        <div class="thumbnail-list">
          <img src="/images/landingDoobo/project/img_ing.png">
          <img src="/images/landingDoobo/project/img_ing.png">
          <img src="/images/landingDoobo/project/img_ing.png">
        </div>

        <div class="image-pagination">1 / 4</div>
      </div>

      <!-- RIGHT : 텍스트 -->
      <div class="popup-right">
        <h3 class="popup-title" id="projectNm"></h3>
        <div class="popup-tags" id="projectTag"></div>
        <div class="popup-section">
          <h4>상세 설명</h4>
          <p id="projectCont"></p>
        </div>

        <div class="popup-section">
          <h4>사용 기술</h4>
          <div class="tech-stack">
            <span>SpringBoot</span>
            <span>java</span>
            <span>jsp</span>
            <span>Jquery</span>
          </div>
        </div>

        <div class="popup-section">
          <%--<h4>추가 자료</h4>
          <div class="download-box">
            <span>📎 발표자료.pdf</span>
            <a href="#" class="download-btn">다운로드</a>
          </div>--%>
        </div>
      </div>
    </div>

  </div>



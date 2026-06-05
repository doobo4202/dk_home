<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/landingDoobo/include/navigationBar.jsp" %>
<script>
$(document).ready(function () {
    fn_schBaseMain();
    fn_toggleFAQ();
    $(document).on("click touchstart", "#btnTop", function(e){
        e.preventDefault();
        $("html, body").animate({ scrollTop: 0 }, 400);
    });
});

function fn_toggleFAQ() {
    $(document).on("click", ".faq-q", function () {
        var $content = $(this).next(".faq-a");
        if ($content.is(":visible")) {
            $content.slideUp(200);
            $(this).find(".arrow").text("▾");
        } else {
            $(".faq-a").slideUp(200);
            $(".arrow").text("▾");
            $content.slideDown(200);
            $(this).find(".arrow").text("▴");
        }
    });
}

function fn_schBaseMain() {
    AJAX_COLL("/ld/main/schBaseMain", {}, "", "", fn_sucSchBaseMain);
}

function fn_sucSchBaseMain(data) {
    if (data.result === "FAIL") return;

    var devInfo     = data.devInfo     || {};
    var expList     = data.expList     || [];
    var projectList = data.projectList || [];
    var faqList     = data.faqList     || [];
    var contactInfo = data.contectInfo || {};

    /* ── 히어로 ── */
    var name = devInfo.DEV_NM || '';
    if (devInfo.DEV_IMG) {
        $("#heroAvatar").html("<img src='" + devInfo.DEV_IMG + "' alt='profile'>");
    } else {
        $("#heroAvatar").text(name.charAt(0) || 'D');
    }
    $("#devNm").text(name);
    $("#devPosition").text(devInfo.DEV_PART || '');
    $("#infoMiddleText").html(devInfo.DEV_TEXT || '');
    $("#heroQuote").text(devInfo.DEV_MSG || '');

    var tags = devInfo.DEV_TAG ? devInfo.DEV_TAG.split("#").filter(function(v){ return v !== ""; }) : [];
    $("#heroTags").html(tags.map(function(t){ return "<span>#" + t + "</span>"; }).join(""));

    /* ── 스탯 ── */
    // 최초 입사년도 계산
    var minYear = new Date().getFullYear();
    expList.forEach(function(exp) {
        var y = parseInt((exp.START_DY || "").substring(0, 4));
        if (!isNaN(y) && y < minYear) minYear = y;
    });
    var yearsExp = new Date().getFullYear() - minYear;
    $("#statYears").text(yearsExp > 0 ? yearsExp + "+" : "-");
    $("#statProjects").text(projectList.length > 0 ? projectList.length + "+" : "0");
    $("#statCompanies").text(expList.length || "0");
    $("#statTechStack").text(tags.length > 0 ? tags.length + "+" : "5+");

    /* ── 경력 타임라인 ── */
    var expHtml = "";
    expList.forEach(function(exp) {
        expHtml += "<div class='tl-item'>";
        expHtml += "<div class='tl-dot'></div>";
        expHtml += "<div class='tl-card'>";
        expHtml += "<div class='tl-period'>" + (exp.START_DY||'') + " — " + (exp.END_DY||'') + "</div>";
        expHtml += "<h3>" + (exp.COMPANY_NM||'') + "</h3>";
        expHtml += "<div class='tl-role'>" + (exp.SMALL_CONT||'') + " · " + (exp.GRADE_NM||'') + "</div>";
        expHtml += "<div class='tl-desc'>" + (exp.EXP_DETAIL||'') + "</div>";
        expHtml += "</div></div>";
    });
    $("#expTimeline").html(expHtml || "<p style='color:var(--text2)'>등록된 경력이 없습니다.</p>");

    /* ── 프로젝트 그리드 ── */
    var thumbBg = [
        'linear-gradient(135deg,#ede9fe,#ddd6fe)',
        'linear-gradient(135deg,#fce7f3,#fbcfe8)',
        'linear-gradient(135deg,#dbeafe,#bfdbfe)',
        'linear-gradient(135deg,#d1fae5,#a7f3d0)',
        'linear-gradient(135deg,#fef3c7,#fde68a)',
        'linear-gradient(135deg,#fee2e2,#fecaca)'
    ];
    var projHtml = "";
    projectList.forEach(function(proj, idx) {
        var tagHtml = "";
        if (proj.PROJECT_TAG) {
            proj.PROJECT_TAG.split("#").filter(function(v){ return v !== ""; }).forEach(function(t){
                tagHtml += "<span>#" + t + "</span>";
            });
        }
        var bg = thumbBg[idx % thumbBg.length];
        var hasImg = proj.SUM_IMG && proj.SUM_IMG.indexOf('img_ing') === -1;
        projHtml += "<div class='project-card' onclick=\"fn_openProjectDetail('" + proj.PROJECT_SEQ + "')\">";
        projHtml += "<div class='project-thumb' style='background:" + bg + "'>";
        if (hasImg) {
            projHtml += "<img src='" + proj.SUM_IMG + "' alt='" + proj.PROJECT_NM + "' style='width:100%;height:100%;object-fit:cover;border-radius:0'/>";
        }
        projHtml += "</div>";
        projHtml += "<div class='project-info'>";
        projHtml += "<h3>" + (proj.PROJECT_NM||'') + "</h3>";
        projHtml += "<div class='project-tags'>" + tagHtml + "</div>";
        projHtml += "</div></div>";
    });
    $("#projectGrid").html(projHtml || "<p style='color:var(--text2)'>등록된 프로젝트가 없습니다.</p>");

    /* ── FAQ ── */
    var faqHtml = "";
    faqList.forEach(function(faq) {
        faqHtml += "<div class='faq-item'>";
        faqHtml += "<div class='faq-q'><div><em>Q.</em>" + (faq.FAQ_QUESTION||'') + "</div><span class='arrow'>▾</span></div>";
        faqHtml += "<div class='faq-a'>" + (faq.FAQ_ANSWER||'') + "</div>";
        faqHtml += "</div>";
    });
    $("#faqList").html(faqHtml || "<p style='color:var(--text2)'>등록된 FAQ가 없습니다.</p>");

    /* ── 연락처 ── */
    $("#contactEmail").text(contactInfo.CONTACT_MAIL || '');
    $("#contactCall").text(contactInfo.CONTACT_CALL  || '');
    var talkVal = contactInfo.CONTACT_TALK || '';
    if (talkVal) {
        var talkHref = talkVal.indexOf('http') === 0 ? talkVal : 'https://' + talkVal;
        $("#contactTalk").html("<a href='" + talkHref + "' target='_blank' rel='noopener'>" + talkVal + "</a>");
    }
}

function fn_openProjectDetail(seq) {
    var divNm = "projectModal";
    $("#" + divNm).dialog("destroy").remove();
    $("<div></div>").attr({id: divNm, class: "dialogPopup"}).appendTo("body");
    $("#" + divNm).dialog({
        modal: true, width: "60%", height: "auto",
        resizable: false, draggable: false,
        show: { effect: "fadeIn", duration: 300 },
        hide: { effect: "fadeOut", duration: 300 },
        open: function() { $(this).css("overflow","hidden"); }
    });
    $("#" + divNm).load("/project/projectDetail", { seq: seq });
}

function fn_closePopup() {
    $("#projectModal").dialog("destroy").remove();
}
</script>

<!-- ── HERO ── -->
<div class="hero" id="about">
    <div class="wrap">
        <div class="hero-inner">
            <div class="hero-avatar" id="heroAvatar">D</div>
            <div class="hero-text">
                <div class="hero-badge">✦ Backend Developer</div>
                <h1><span id="devNm"></span></h1>
                <p id="infoMiddleText"></p>
                <div class="hero-quote" id="heroQuote"></div>
                <div class="hero-tags" id="heroTags"></div>
            </div>
        </div>
    </div>
</div>

<!-- ── STATS ── -->
<div class="stats-outer">
    <div class="stats-bar">
        <div class="stat"><div class="stat-num" id="statYears">-</div><div class="stat-label">Years Exp.</div></div>
        <div class="stat-divider"></div>
        <div class="stat"><div class="stat-num" id="statProjects">-</div><div class="stat-label">Projects</div></div>
        <div class="stat-divider"></div>
        <div class="stat"><div class="stat-num" id="statCompanies">-</div><div class="stat-label">Companies</div></div>
        <div class="stat-divider"></div>
        <div class="stat"><div class="stat-num" id="statTechStack">-</div><div class="stat-label">Tech Stack</div></div>
    </div>
</div>

<!-- ── EXPERIENCE ── -->
<div class="light-section" id="experience">
    <div class="wrap">
        <div class="sec-header">
            <h2>경력</h2><em>EXPERIENCE</em>
        </div>
        <div class="timeline" id="expTimeline"></div>
    </div>
</div>

<div class="section-line"><div class="wrap"></div></div>

<!-- ── PROJECT ── -->
<div class="white-section" id="project">
    <div class="wrap">
        <div class="sec-label">Works</div>
        <div class="sec-title">프로젝트 <span>PROJECT</span></div>
        <div class="projects-grid" id="projectGrid"></div>
    </div>
</div>

<div class="section-line"><div class="wrap"></div></div>

<!-- ── FAQ ── -->
<div class="white-section" id="faq">
    <div class="wrap">
        <div class="sec-label">Q&A</div>
        <div class="sec-title">FAQ <span>FAQ</span></div>
        <div class="faq-list" id="faqList"></div>
    </div>
</div>

<div class="section-line"><div class="wrap"></div></div>

<!-- ── CONTACT ── -->
<div class="white-section" id="contact">
    <div class="wrap">
        <div class="sec-label">Contact</div>
        <div class="sec-title">연락처 <span>CONTACT</span></div>
        <div class="contact-grid">
            <div class="contact-card">
                <div class="contact-icon">✉</div>
                <div class="contact-label">Email</div>
                <div class="contact-value" id="contactEmail"></div>
            </div>
            <div class="contact-card">
                <div class="contact-icon">📱</div>
                <div class="contact-label">Phone</div>
                <div class="contact-value" id="contactCall"></div>
            </div>
            <div class="contact-card">
                <div class="contact-icon">💬</div>
                <div class="contact-label">KakaoTalk</div>
                <div class="contact-value" id="contactTalk"></div>
            </div>
            <div class="contact-card">
                <div class="contact-icon">🔗</div>
                <div class="contact-label">오픈채팅</div>
                <div class="contact-value">링크 바로가기</div>
            </div>
        </div>
    </div>
</div>

<button id="btnTop">▲</button>

<%@ include file="/WEB-INF/jsp/landingDoobo/include/footer.jsp" %>

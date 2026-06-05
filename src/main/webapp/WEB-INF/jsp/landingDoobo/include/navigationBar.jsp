<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/landingDoobo/include/header.jsp" %>
<script>
    $('a[href^="#"]').on('click', function(e){
        e.preventDefault();
        var target = $(this.getAttribute('href'));
        if (target.length) {
            $('html, body').stop().animate({ scrollTop: target.offset().top - 60 }, 500);
        }
    });
    $(document).on("click", "#navToggle", function () {
        $("#navMenu").toggleClass("open");
        $("#navDim").toggleClass("show");
    });
    $(document).on("click", "#navDim", function () {
        $("#navMenu").removeClass("open");
        $("#navDim").removeClass("show");
    });
    $(document).on("click", "#navMenu a", function () {
        $("#navMenu").removeClass("open");
        $("#navDim").removeClass("show");
    });
</script>

<nav>
    <div class="nav-inner">
        <div class="nav-logo">DEV.PORTFOLIO</div>
        <ul class="nav-links" id="navMenu">
            <li><a href="#about">ABOUT</a></li>
            <li><a href="#experience">EXPERIENCE</a></li>
            <li><a href="#project">PROJECT</a></li>
            <li><a href="#faq">FAQ</a></li>
            <li><a href="#contact">CONTACT</a></li>
        </ul>
        <button type="button" id="navToggle" class="nav-toggle">
            <span></span><span></span><span></span>
        </button>
    </div>
    <div id="navDim" class="nav-dim"></div>
</nav>

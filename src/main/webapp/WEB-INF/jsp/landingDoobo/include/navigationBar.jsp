<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/landingDoobo/include/header.jsp" %>

<script type="text/javascript">
    // 스크롤 이벤트를 상단 네비 메뉴 클릭 시 이용하여 페이지 이동
    $('a[href^="#"]').on('click', function(e){
        e.preventDefault();

        const target = $(this.getAttribute('href'));
        if(target.length) {
            $('html, body').stop().animate({
                scrollTop: target.offset().top
            }, 500);     // 500 = 애니메이션 속도(ms)
        }
    });

    // 햄버거 클릭 시 메뉴 열기/닫기
    $(document).on("click", "#navToggle", function () {
        $("#navMenu").toggleClass("open");
        $("#navDim").toggleClass("show");
    });

    // 딤 클릭 시 닫기
    $(document).on("click", "#navDim", function () {
        $("#navMenu").removeClass("open");
        $("#navDim").removeClass("show");
    });

    // 메뉴 항목 클릭 후 자동 닫기
    $(document).on("click", "#navMenu a", function () {
        $("#navMenu").removeClass("open");
        $("#navDim").removeClass("show");
    });
</script>
        <div class="navDiv">
            <!-- 항상 보이는 로고 영역 -->
            <div class="navLogo">
                <a href="#">
                    <img src="/images/landingDoobo/dooboLogo.png" alt="logo">
                </a>
            </div>

            <!-- 햄버거 버튼 -->
            <button type="button" id="navToggle" class="navToggle">
                <span></span>
                <span></span>
                <span></span>
            </button>

            <!-- 슬라이드 메뉴 -->
            <ul class="navUl" id="navMenu">
                <li><a href="#devInfo">INFORMATION</a></li>
                <li><a href="#experience">EXPERIENCE</a></li>
                <li><a href="#project">PROJECT</a></li>
                <li><a href="#faq">FAQ</a></li>
                <li><a href="#contact">CONTACT</a></li>
            </ul>

            <!-- 딤 배경 -->
            <div id="navDim" class="navDim"></div>
        </div>


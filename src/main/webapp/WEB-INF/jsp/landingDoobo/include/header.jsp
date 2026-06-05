<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- 메타 -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- 메타 -->
<title>Kim Doohan’s Developer Space</title>
</head>
<link rel="shortcut icon" href="/img/doobo/title.ico"><!-- 웹 미니 아이콘 -->
<!-- CSS -->
<link rel="stylesheet" type="text/css" href="/css/common/common.css"><%-- 공용 CSS 호출 --%>
<link rel="stylesheet" type="text/css" href="/css/landingDoobo/style.css"><%-- 스타일 CSS 호출 --%>
<link rel="stylesheet" type="text/css" href="/css/jquery-ui/jquery-ui.css" />
<!-- JS -->
<script type="text/javascript" src="/js/jquery/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/js/common/common.js"></script><%-- 공용 js 호출 --%>
<script type="text/javascript" src="/js/jquery-ui/jquery-ui.js"></script>

<script type="text/javascript">
    $(document).on("click touchstart", "#btnTop", function(e){
        e.preventDefault();
        $("html, body").animate({ scrollTop: 0 }, 400);
    });
</script>
<body>
    <div class="content">
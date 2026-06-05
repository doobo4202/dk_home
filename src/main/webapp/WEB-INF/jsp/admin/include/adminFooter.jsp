<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
</div><!-- /adm-content -->
</div><!-- /adm-main -->
<div id="admToast" class="adm-toast"></div>
<script>
/* 현재 메뉴 active 처리 */
$(function(){
    var path = location.pathname;
    $(".sb-nav a").each(function(){
        if (path.indexOf($(this).attr("href")) === 0) $(this).addClass("active");
    });
});
</script>
</body>
</html>

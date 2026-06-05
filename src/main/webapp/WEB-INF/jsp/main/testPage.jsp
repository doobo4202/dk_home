<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/include/header.jsp" %>

<script type="text/javascript">

function test() {
	alert("닫기 이벤트 테스트");
}

function fn_testAjax() {
	var tId = $("input[id=\"tId\"]").val();
	var tNo = $("input[id=\"tNo\"]").val();

	console.log("tId : " + tId + " / tNo : " + tNo);

	var param = new Object();
	param.tId = tId;
	param.tNo = tNo;

	var url = "/dooTools/mvcTester/selectMap";

	AJAX_COLL(url, param, "", "", fn_sucTest);
}

function fn_sucTest(data) {
	var map = data.testMap;
	var tCont = map.tCont;
	console.log(tCont);
	DIV_ALERT(tCont);
}

function fn_testListAjax() {
	var lNo = $("input[id=\"lNo\"]").val();

	console.log("lNo : " + lNo);

	var param = new Object();
	param.lNo = lNo;

	var url = "/dooTools/mvcTester/selectList";

	AJAX_COLL(url, param, "", "", fn_sucTestList);
}

function fn_sucTestList(data) {
	console.log(data);
	var map = data.selectList;
	var cnt = map.length;
	var html = "";

	console.log(map);
	for (i = 0 ; i < cnt; i++) {
		html += "<p>" + map[i].tCont + "</p><br />";
	}
	DIV_ALERT(html);
}
</script>
<body>
	<h3>MVC 테스트 페이지</h3>
	<a href="javascript:DIV_ALERT('열려라 팝업이여!');">DIV_ALERT 테스트</a>

	<h2>DB 데이터</h2>
	<table style="margin: 0 auto; width: 40%;">
		<colgroup>
	        <col style="width: 40%;"/>
	        <col style="width: 30%;"/>
	        <col style="width: 30%;"/>
	    </colgroup>
		<tr>
			<th>내용</th><th>No</th><th>Id</th>
		</tr>
		<tr>
			<td>1-1번 내용</td><td>1</td><td>1</td>
		</tr>
		<tr>
			<td>1-2번 내용</td><td>1</td><td>2</td>
		</tr>
		<tr>
			<td>2-3번 내용</td><td>2</td><td>3</td>
		</tr>
		<tr>
			<td>2-5번 내용</td><td>2</td><td>5</td>
		</tr>
		<tr>
			<td>3-1번 내용</td><td>3</td><td>1</td>
		</tr>
		<tr>
			<td>4-2번 내용</td><td>4</td><td>2</td>
		</tr>
		<tr>
			<td>5-4번 내용</td><td>5</td><td>4</td>
		</tr>
	</table>

	<br/><br/>
	<h1>select Map 테스트</h1>
	No : <input type="text" id="tNo">
	Id : <input type="text" id="tId">
	<a href="javascript:fn_testAjax();">내용 확인</a>

	<br/><br/>
	<h1>select List 테스트</h1>
	No : <input type="text" id="lNo">
	<a href="javascript:fn_testListAjax();">내용 확인</a>

	<%@ include file="/WEB-INF/jsp/common/include/divAlert.jsp" %>
</body>
</html>
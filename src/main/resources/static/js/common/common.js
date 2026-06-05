/*
	AJAX_COLL() / 아작스 실행 함수
*/
function AJAX_COLL(url, data, loadingYN, beforeFunc, sucFinc) {
	// ajax 통신
	$.ajax({
		url : url,
		data : data,
		type : "post",
		cache: false,        
        async : true,
		timeout : 10000,
		beforeSend: function() {
			if (loadingYN == "Y") {
				// 로딩 처리
			}
			
			// beforeFunc이 함수인지 아닌지 판별
			if (beforeFunc != null && beforeFunc != "undefined" && beforeFunc != "") {
				// type function
				if (typeof beforeFunc === "function") {						
					// beforeFunc 에서 반드시 true/false 리턴 
					// 리턴이 true면 ajax 실행 false면 ajax 수행 안함
					var returnVal = beforeFunc();
					if (returnVal == false) {
						// beforeFunc 실패 시 로딩 처리 숨기고 리턴
					}
					return returnVal;						
				}					
			}
		},
		success: function(data) {
			sucFinc(data);
	    },
	    error : function(error, textStatus, message) {
			console.log("ajax 에러");
			console.log(error);
			console.log(textStatus);
			console.log(message);
		}
	})
}

/*
	OBJ_TO_JSON() / object를 json string으로 변환
*/
function OBJ_TO_JSON(obj) {
	return JSON.stringify(obj);
}

/*
	DIV_ALERT() / 팝업 창 호출
*/
function DIV_ALERT(msg, closeFn) {
	// 초기화 후 팝업 내용 등록
	$(".divAlertContent").html();
	$(".divAlertContent").html(msg);
	
	// 닫기 함수가 있으면 함수 적용
	if (TRIM(closeFn) != "") {
		closeFn = closeFn + "();";
		$(".divAlertBtn").attr("onclick", closeFn);
	}

	// 팝업 DIV 열기
	$(".divAlertControl").show();
} 

/*
	DIV_CLOSE() / 팝업 창 호출
*/
function DIV_CLOSE() {
	$(".divAlertControl").hide();
}

/*
	TRIM(str) / 여백 정리
	str - 스트링형 문자
*/
function TRIM(str) {
	return $.trim(str);
}

/*
	IS_NUM / 숫자형인지 아닌지 확인
	s - 숫자 또는 문자
*/
function IS_NUM(s) {
	s += "";		// 문자열로 변환
	s = TRIM(s);	// 좌우 공백 제거
	if (s == "" || isNaN(s)) return false;
	return true;
}

/*
	CM(str) / 숫자형 변환
	str - 변환시킬 문자
*/
function CM(str) {
	if (IS_NUM(str) == true) {
		str = TRIM(str);
		var spt = str.split(".");
	    var cnt = spt.length;
	    var retVal = "";

	    // 소수점 없을때
	    if (cnt == 1) {
	    	str = TRIM(parseInt(str, 10));
	    	retVal = str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	    // 소수점 하나일때
	    } else if (cnt == 2) {
	    	var str1 = TRIM(spt[0]);
	    	var str2 = TRIM(spt[1]);
	    	str1 = TRIM(parseInt(str1, 10));
	    	retVal = str1.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,') + "." + str2;
	    }
	    
	    return retVal;		
	} else {
		alert("숫자가 아닙니다.");
		return "";
	}
}
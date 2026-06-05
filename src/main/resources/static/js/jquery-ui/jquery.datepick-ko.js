/**
 * http://keith-wood.name/datepick.html
 * Korean localisation for jQuery Datepicker
 */
jQuery(function($) {	
	$.datepicker.regional['ko'] = {
		closeText: '닫기',
		prevText: '이전달',
		nextText: '다음달',
		currentText: '오늘',
		monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNames: ['일','월','화','수','목','금','토'],
		dayNamesShort: ['일','월','화','수','목','금','토'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		weekHeader: 'Wk',
		dateFormat: 'yy.mm.dd',
		firstDay: 0,
		isRTL: false,
		showMonthAfterYear: true,
		yearSuffix: '년',
		constrainInput: true, 

		// mcder_added
		showOn: 'button',
		showAnim: 'slideDown', 		// Name of jQuery animation for popup
		buttonText: "달력", 		// Text for trigger button
		buttonImage: '/images/btn_calendar_new.png',
		buttonImageOnly: true,
		showOtherMonths: true,
		selectOtherMonths: true,
		showButtonPanel: true, 		// True to show button panel, false to not show it
		gotoCurrent: true, 			// True if today link goes back to current selection instead
		changeYear: true,
		changeMonth: true 			// True if month can be selected directly, false if only prev/next
		// mcder_added
	};

	$.datepicker.setDefaults($.datepicker.regional['ko']);
});

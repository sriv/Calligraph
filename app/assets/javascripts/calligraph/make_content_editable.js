$(document).ready(function (){
	var iframe = document.getElementById("content_preview");
	$(iframe).load(function (){
    iframe.contentWindow.make_page_editable($('#content_data', window.parent.document), $("#selected_language").val());
	});
});
var make_page_editable = function(content_data_element, selected_language) {

	var updateDataField = function (data, field, value) {
		if(selected_language !== null && selected_language !== undefined && selected_language !== "") {
			data[selected_language][field] = value;
		} else {
			data[field] = value;
		}
	};

	var getSelectedField = function (data, field) {
		if(selected_language !== null && selected_language !== undefined && selected_language !== "") {
			return data[selected_language][field];
		} else {
			return data[field];
		}
	};

	$('.admin-editable:not(img):not(a):not(area):not(.youtube-video):not(.bg-image)').each(function(){
		var self = this;
		$(self).addClass('active');
		$(self).attr('contenteditable','true');
		if(CKEDITOR !== undefined) {
			$(self).ckeditor('inline');
		}
		$(self).blur(function(){
			var data = JSON.parse(content_data_element.val());
			updateDataField(data, $(self).data("field"), $(self).html().replace(/<div>/gi,'<br>').replace(/<\/div>/gi,''));
			content_data_element.val(JSON.stringify(data));
		});
	});

	var update_element_attr_and_data_json = function (element, data_attribute_name, json_property_name, data) {
		var newValue = $("#" + json_property_name + " input").val();
		updateDataField(data, json_property_name, newValue);
		$(element).attr(data_attribute_name, newValue);
	};

	//attach image handler
	$('img.admin-editable').each(function(){
		var self = this;
		$(self).addClass('active');
		$(self).click(function(){
			var data = JSON.parse(content_data_element.val());

			var picoModalHtml = "<div id='" + $(self).data("src") + "'><p>Choose New Image: </p><input type='text' value='"+ $(self).attr("src") + "'/></div>"
								+"<div id='" + $(self).data("alt") + "'><p>Enter Alt Text: </p><input type='text' value='"+ $(self).attr("alt") + "'/></div>"
								+"<div id='" + $(self).data("title") + "'><p>Image title: </p><input type='text' value='"+ $(self).attr("title") + "'/></div>"
								+"<p><a id='change_image'>Change</a></p>";

			var modal = picoModal(picoModalHtml);

			$("#change_image").click(function (){
				var data = JSON.parse(content_data_element.val());

				update_element_attr_and_data_json(self, "src", $(self).data("src"), data);
				update_element_attr_and_data_json(self, "alt", $(self).data("alt"), data);
				update_element_attr_and_data_json(self, "title", $(self).data("title"), data);

				content_data_element.val(JSON.stringify(data));
				modal.close();
			});

			modal.onClose(function () {
				$("#change_image").unbind();
			});
			return false;
		});
	});

	//make links non editable
	$("a, area").not(".admin-editable").each(function() {
		$(this).click(function (event) {
			event.preventDefault();
		});
		$(this).removeAttr("onclick");
		$(this).attr("target", "_self");
	});

	//bind link handler to editable area link
	$('area.admin-editable').each(function(){
		var self = this;
		$(self).addClass('active');
		$(self).click(function() {
			var data = JSON.parse(content_data_element.val());

			var picoModalHtml = "<div id='" + $(self).data("href") + "'><p>Choose New Link Path: </p><input type='text' value='"+ $(self).attr("href") + "'/></div>"
								+"<div id='" + $(self).data("title") + "'><p>Link title: </p><input type='text' value='"+ $(self).attr("title") + "'/></div>"
								+"<p><a id='change_hyperlink'>Change</a></p>";

			var modal = picoModal(picoModalHtml);

			$("#change_hyperlink").click(function (){
				var data = JSON.parse(content_data_element.val());
				update_element_attr_and_data_json(self, "href", $(self).data("href"), data);
				update_element_attr_and_data_json(self, "title", $(self).data("title"), data);
				content_data_element.val(JSON.stringify(data));
				modal.close();
			});

			modal.onClose(function () {
				$("#change_hyperlink").unbind();
			});
			return false;
		});
	});

	//bind link handler to editable anchor links
	$('a.admin-editable').each(function(){
		var self = this;
		$(self).addClass('active');
		$(self).click(function() {
			var data = JSON.parse(content_data_element.val());

			var picoModalHtml = "<div id='" + $(self).data("href") + "'><p>Choose New Link Path: </p><input type='text' value='"+ $(self).attr("href") + "'/></div>"
								+"<div id='" + $(self).data("text") + "'><p>Link text: </p><input type='text' value='"+ $(self).html() + "'/></div>"
								+"<div id='" + $(self).data("title") + "'><p>Link title: </p><input type='text' value='"+ $(self).attr("title") + "'/></div>"
								+"<p><a id='change_hyperlink'>Change</a></p>";

			var modal = picoModal(picoModalHtml);

			$("#change_hyperlink").click(function (){
				var data = JSON.parse(content_data_element.val());
				update_element_attr_and_data_json(self, "href", $(self).data("href"), data);
				update_element_attr_and_data_json(self, "title", $(self).data("title"), data);

				var newLinkText = $("#"+$(self).data("text")+" input").val();
				data[$(self).data("text")] = newLinkText;
				$(self).html(newLinkText);

				content_data_element.val(JSON.stringify(data));
				modal.close();
			});

			modal.onClose(function () {
				$("#change_hyperlink").unbind();
			});
			return false;
		});
	});

	//make youtube videos editable
	$('.admin-editable.youtube-video').each(function (){
		var self = this;
		$(self).addClass('active');
		$(self).find(".change-youtube-video").click(function(){
			var picoModalHtml = "<div id='" + $(self).data("src") + "'><p>Enter Youtube Video Link: </p><input type='text' value='"+ $(self).find('iframe').attr("src") + "'/></div>"
								+"<p><a id='change_video'>Change</a></p>";

			var modal = picoModal(picoModalHtml);

			$("#change_video").click(function (){
				var data = JSON.parse(content_data_element.val());

				var newValue = youtubeVideoEmbedUrl($("#" + $(self).data("src") + " input").val());
				updateDataField(data, $(self).data("src"), newValue);
				$(self).find('iframe').attr("src", newValue);

				content_data_element.val(JSON.stringify(data));
				modal.close();
			});

			modal.onClose(function () {
				$("#change_video").unbind();
			});
			return false;
		});
	});

	//make background image editable
	$('.admin-editable.bg-image').each(function () {
		var self = this;
		$(self).addClass("active");
		$(self).prepend('<a class="change-bg-image fa fa-cog"></a>');
		$(self).find(".change-bg-image").click(function (event) {
			event.preventDefault();

			var picoModalHtml = "<div id='" + $(self).data("bg-image") + "'><p>Enter New Background Image Link: </p><input type='text' value='"+ decodeBgImageUrl($(self).css('background-image')) + "'/></div>"
								+"<p><a id='change_bg'>Change</a></p>";

			var modal = picoModal(picoModalHtml);

			$("#change_bg").click(function (){
				var data = JSON.parse(content_data_element.val());

				var newValue = constructBgImageUrl($("#" + $(self).data("bg-image") + " input").val());
				if(newValue !== "url()") {
					updateDataField(data, $(self).data("bg-image"), newValue);
					$(self).css('background-image', newValue);
				} else {
					updateDataField(data, $(self).data("bg-image"), undefined);
					var styleAttribute = $(self).attr("style");
					styleAttribute = styleAttribute.replace(/(background-image:\surl\(\S+\));/,"")
					$(self).attr("style", styleAttribute);
				}
				content_data_element.val(JSON.stringify(data));
				modal.close();
			});

			modal.onClose(function () {
				$("#change_bg").unbind();
			});
		});
	});

	//make widgets editable
	$(".admin-editable.widgets-section").each(function () {
		var self = this;
		$(self).removeClass("hidden");
		$(self).addClass("active");
		$(self).prepend('<a class="change-widgets fa fa-cog"></a>');
		$(self).find(".change-widgets").click(function (event){
			var data = JSON.parse(content_data_element.val());
			event.preventDefault();
			var widgetsList = getSelectedField(data, $(self).data("widget-section"));
			var picoModalHtml = '<div id="'+$(self).data("widget-section")+'"><p>Enter Widgets List (seperated by comma(,)): </p>'+
			'<input type="text" value="'+ widgetsList +'"/>'+
			'<p>You need to click update content on sidebar after confirming changes on this popup, for the data to be populated from server.</p>'+
			'<a id="change_widgets">Change Widgets</a></div>';

			var modal = picoModal(picoModalHtml);

			$("#change_widgets").click(function () {				
				var newWidgetsArray = $("#"+$(self).data("widget-section")).find("input[type='text']").val().split(",").filter(function (value) {
					return value !== "" && value !== undefined && value !== null;
				});
				for(var i=0; i<newWidgetsArray.length; i++) {
					newWidgetsArray[i] = newWidgetsArray[i].trim();
				}
				updateDataField(data, $(self).data("widget-section"), newWidgetsArray.join(","));
				content_data_element.val(JSON.stringify(data));
				modal.close();
			});

			modal.onClose(function () {
				$("#change_widgets").unbind();
			});
		});
	});

	//helper methods
	var constructYearOptions = function (chosenYear) {
		var yearOptions = [];
		var selected = "";
		var currentYear = new Date().getFullYear();
		for(var i=0;i<4;i++) {
			selected = (chosenYear == currentYear - i) ? "selected" : "";
			yearOptions.push("<option "+selected+">"+ (currentYear - i).toString() +"</option>");
		}
		return yearOptions.join("");
	};

	var constructBgImageUrl = function(url) {
		return "url("+url+")";
	};

	var decodeBgImageUrl = function(url) {
		return url.substring(4, url.length - 1);
	};

	var youtubeVideoEmbedUrl = function (videoUrl) {
		var videoId = videoUrl.split("?v=")[1];
		return "https://www.youtube.com/embed/"+videoId;
	};
};
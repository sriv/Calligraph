var contentPage = {
	firstLoad: true,
	bindChangeContentTemplate: function () {
		var self = this;
		$("#content_content_template_type").change(function (event) {
			$.ajax({
				url: $(this).data("url"),
				method: "GET",
				data: {
					template_type: $(this).val()
				},
				success: function (response, status) {
					$("#content_content_template_id").html("");
					$.each(response, function (index, value) {
						$("#content_content_template_id").append("<option value="+value.id+">"+value.title+"</option>");
					});
					self.setSelectedTemplate();
				},
				error: function (response, status) {

				}
			});
		});
		$("#content_content_template_type").trigger("change");
	},
	setSelectedTemplate: function () {
		if(this.firstLoad) {
			this.firstLoad = false;
			var content_template_id = parseInt($("#content_template_id").val());
			$('#content_content_template_id').find("option[value='"+content_template_id+"']").attr("selected", "selected");
		}
	},
	bindPreviewSizes: function () {
		$(".mobile").click(function () {
			$("#content_preview").attr("style", "width: 320px;");
		});
		$(".desktop").click(function (){
			$("#content_preview").attr("style", "");
		});
	},
	bindRemoveMetaTag: function () {
		$(".remove-meta-tag").unbind("click");
		$(".remove-meta-tag").click(function () {
			$(this).closest(".meta-tag").remove();
		});
	},
	resetAddMeta: function () {
		$("#add_meta_tag_template").addClass("hidden");
		$(".meta-tag-name").val("");
		$(".meta-tag-value").val("");
		$(".add-meta-tag").removeClass("hidden");
	},
	bindAddMetaTag: function () {
		$(".add-meta-tag").click(function () {
			$("#add_meta_tag_template").removeClass("hidden");
			$(this).addClass("hidden");
		});
		$(".cancel-add-meta").click(function () {
			contentPage.resetAddMeta();
		});
		$(".add-meta").click(function () {
			$(".meta-tag-error").addClass("hidden");
			var metaTagName = $(".meta-tag-name").val().toLowerCase();
			var metaTagValue = $(".meta-tag-value").val();

			if(metaTagName && metaTagName.length > 0 && $('.meta-tag-list input[name="content[meta_tags]['+metaTagName+']"]').length === 0) {
				var newMetaTagHtml = $("#meta_tag_template").html();
				newMetaTagHtml = newMetaTagHtml.replace(/{{key}}/gi, metaTagName).replace(/{{value}}/gi, metaTagValue);
				$(".meta-tag-list").append(newMetaTagHtml);
				contentPage.resetAddMeta();
				contentPage.bindRemoveMetaTag();
			} else {
				$(".meta-tag-error").removeClass("hidden");
			}
		});
	},
	bindLanguageSwitch: function () {
		$("#language_selector").change(function (event) {
			var newLanguage = $(this).val();
			$("#selected_language").val(newLanguage);
			var iframe = document.getElementById("content_preview");
			iframe.contentWindow.switchLanguage(newLanguage);
		});
	}
};

$(document).ready(function () {
	contentPage.bindChangeContentTemplate();
	contentPage.bindPreviewSizes();
	contentPage.bindRemoveMetaTag();
	contentPage.bindAddMetaTag();
	contentPage.bindLanguageSwitch();
});
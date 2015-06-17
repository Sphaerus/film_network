$(document).ready ->
	$('.user_score select').change ->
		hash = {"resource_type": "Movie", "resource_id": $('.score_resource_id input').val(), "score": $('.score_score select').val() }
		$.ajax
			dataType: "json"
			type: $(".user_score [name='_method']").attr("value")
			url: $('.user_score form').attr("action")
			data: { score: hash }		
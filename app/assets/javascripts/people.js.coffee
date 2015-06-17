$(document).ready ->
	$('.datepicker').datepicker(dateFormat: 'yy-mm-dd')
	
	$(document).ready ->
		$('.user_score select').change ->
			hash = {"resource_type": "Person", "resource_id": $('.id.hidden').data("id"), "score": $('.user_score select').val() }
			$.ajax
				dataType: "json"
				type: "post"
				url: "/scores/score"
				data: { score: hash }
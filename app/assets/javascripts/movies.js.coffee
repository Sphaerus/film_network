$(document).ready ->
	console.log "jestem tu"
	select = $('.person-select:last').clone()
	select.addClass("hidden")
	$('.hidden_select').append(select)
	$('.person-select').last().find('input').val(null)
	$('.person-select').last().find('input').attr("disabled", true)
	
	for person in $('.people .person-select')
		if $(person).find(".person-id input").val() == ""
			$(person).remove()
	
	$('.people .attribute.job select').change ->  ##actor role field appears
		if $(this).val() == "0"
			$(this).closest(".person-select").find(".role").removeClass("hidden")	
		else
			$(this).closest(".person-select").find(".role").addClass("hidden")		
	
	for role in $(".people .person-select .attribute.role")		
		if $(role).closest(".person-select").find(".attribute.job select").val() == "0"
			$(role).removeClass("hidden")
		else	
			$(role).addClass("hidden")
		
	$('.search_bar input').devbridgeAutocomplete
	  serviceUrl: '/people/autocomplete',
	  onSelect: (suggestion) ->
		  new_input = $('.person-select.hidden:last').clone()
		  new_input.appendTo($('.people'))	
		  console.log suggestion.data
		  $('.people .person-select:hidden .person-id input').val(suggestion.data)
		  $('.people .person-select:hidden .person-id input').removeAttr("disabled")
		  size = $('.people .person-select').length
		  index = 0
		  for person in $('.people .person-select')
			  $(person).find('.movie_movie_people_id input').attr("name", "movie[movie_people_attributes][#{index}][id]")
			  $(person).find('.movie_movie_people_id input').attr("id", "movie_movie_people_attributes_#{index}_id")
			  $(person).find('.person-id input').attr("name", "movie[movie_people_attributes][#{index}][person_id]")
			  $(person).find('.person-id input').attr("id", "movie_movie_people_attributes_#{index}_person_id")
			  $(person).find('.role input').attr("name", "movie[movie_people_attributes][#{index}][role_name]")
			  $(person).find('.role input').attr("id", "movie_movie_people_attributes_#{index}_role_name")
			  $(person).find('.job select').attr("name", "movie[movie_people_attributes][#{index}][job]")
			  $(person).find('.people .person-select:hidden .job select').attr("id", "movie_movie_people_attributes_#{index}_job")
			  index = index + 1
		  #$('.movie_movie_people_id input').attr("name", "movie[movie_people_attributes][#{size - 1}][person_id]")
		  #$('.people .person-select:hidden .movie_movie_people_id input').attr("id", "movie_movie_people_attributes_#{size - 1}_person_id")
		  #$('.people .person-select:hidden .person-id input').attr("name", "movie[movie_people_attributes][#{size - 1}][person_id]")
		  #$('.people .person-select:hidden .person-id input').attr("id", "movie_movie_people_attributes_#{size - 1}_person_id")
			
		  #$('.people .person-select:hidden .role input').attr("name", "movie[movie_people_attributes][#{size - 1}][role_name]")
		  #$('.people .person-select:hidden .role input').attr("id", "movie_movie_people_attributes_#{size - 1}_role_name")
		  #$('.people .person-select:hidden .job select').attr("name", "movie[movie_people_attributes][#{size - 1}][job]")
		  #$('.people .person-select:hidden .job select').attr("id", "movie_movie_people_attributes_#{size - 1}_job")

		  $('.people .person-select.hidden .movie_movie_people_job select').val("0") ##actor
							
		  $('.people .person-select.hidden .attribute.role input').removeClass("hidden") 
		  $('.people .person-select.hidden .attribute.role input').prop("disabled", false)  ##actor role field
		  
		  $('.people .person-select.hidden').removeClass("hidden")
		  
		  $('.people .person-select:last .name').text(suggestion.value)

		  $('.search_bar input').val(null)
			
		  $('.minus').mouseup ->
			  $(this).closest('.person-select').remove()
				
			$(document).on 'change', '.people .person-select .attribute.job select', ->  ##actor role field appears
				if $(this).val() == "0"
					$(this).closest(".person-select").find(".role").removeClass("hidden")	
					$(this).closest(".person-select").find(".role input").prop("disabled", false)
				else
					$(this).closest(".person-select").find(".role").addClass("hidden")	
					$(this).closest(".person-select").find(".role input").prop("disabled")	

	$('.minus').mouseup ->
		destroy = false			
				
		$(this).closest('.person-select').remove()
	
	$(document).ready ->
		$('.user_score select').change ->
			hash = {"resource_type": "Movie", "resource_id": $('.id.hidden').data("id"), "score": $('.user_score select').val() }
			$.ajax
				dataType: "json"
				type: "post"
				url: "/scores/score"
				data: { score: hash }	
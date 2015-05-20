$(document).ready ->

	$(document).on "mouseup", ".plus", ->
		$('.minus').mouseup ->
			$(this).closest('.movie-select').remove()

	$('.plus').mouseup ->
		new_input = $('.movie-select').last().clone()
		$(new_input).find('select').val(null)
		$('.movies').append(new_input)	

	$('.minus').mouseup ->
			$(this).closest('.movie-select').remove()	

	fakedata = ['test1','test2','test3','test4','ietsanders']
	$('.search_input input').devbridgeAutocomplete lookup: fakedata
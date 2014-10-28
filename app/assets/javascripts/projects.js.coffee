# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'ready page:load', ->
  $('li[class*="tab_project"]').click (event) ->
    $('li[class="tab_project active"]').removeClass('active');
    $(this).addClass('active');
  tinyMCE.init (selector: 'textarea')
  $('#addTag').click ->
    $('<div class="col-md-3"><input type="text" name="tag[]" class="form-control" placeholder="Tag du post..."></input></div>').fadeIn("slow").appendTo('.tags_space');
$(document).on 'page:receive', ->
	tinyMCE.remove()
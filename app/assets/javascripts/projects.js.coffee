# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'ready page:load', ->
  $('li[class*="tab_project"]').click (event) ->
    $('li[class="tab_project active"]').removeClass('active');
    $(this).addClass('active');
  tinyMCE.init (selector: 'textarea')
$(document).on 'page:receive', ->
	tinyMCE.remove()

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  if $('#show').length > 0
    $('.best_in_place').best_in_place()
  if $('#index').length > 0
    $('#entries').dataTable
      'sPaginationType': "full_numbers"
      'bJQueryUI': true
      'bProcessing': true
      'bServerSide': true
      'sAjaxSource': $('#entries').data('source')

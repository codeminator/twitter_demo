// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function enable_disable_submit(){

	$('input[type="text"],textarea').keyup(function(){
		var $this = $(this);
		var $submit_button =$this.parent().find('input[type="submit"]');
    if($this.val() !=  "")
      $submit_button.attr('disabled', false);    
    else
      $submit_button.attr('disabled', true);   
	});

	$("div[id^=modal_]").on('show.bs.modal', function() {
		var $this = $(this);
    enable_disable_submit();
	});
}

$('document').ready(function(){
	enable_disable_submit();
})

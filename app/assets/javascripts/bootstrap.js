jQuery(function() {
  $("a[rel~=popover], .has-popover").popover();
  $("a[rel~=tooltip], .has-tooltip").tooltip();

  //messages modal
 //  $('a[data-toggle=modal]').on('click',function(){
 //  	$('.dropdown').removeClass('open')
 //  })
	// $('a[data-target=#ajax-modal]').on('click', function(e){
	//   e.preventDefault()
	//   e.stopPropagation();
	//   //jQuery.noConflict();
	//   $('body').modal('loading');
	//   $.rails.handleRemote( $(this) );
	// })
	// $(document).on('click', '[data-dismiss=modal], .modal-scrollable', function(){
	//   $('.modal-body-content').empty()
	// })
	// $(document).on('click', '#ajax-modal', function(e){
	//   e.stopPropagation();
	// })
});

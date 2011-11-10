(function( $ ) {
  
  var TimeSelector = function ( content, options ) {
    this.settings = $.extend({}, $.fn.modal.defaults, options)

    return this
  }
  
  $.fn.timeSelector = function() {
  
    var timeSelector = this.data('timeSelector');
    
    if (!timeSelector){
      
      return this.each(function () {
        $(this).data('modal', new TimeSelector(this, options))
      })
    }
    

  };
})( jQuery );
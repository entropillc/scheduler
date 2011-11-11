$(function(){
  
  $(".datepicker").datepicker({
    dateFormat: 'yy-mm-dd',
    onSelect: function(dateText, inst){
       
    }
  });
  
  $('#event_room_id').change(function() {
    var eventDate = $("#event_event_date").val();
    var room = $(this).val()
    $.getJSON("/rooms/"+room+"?date="+eventDate, function(data) {
      var el = $("#open-date-selector");
      var dateList = $('<ul class="inputs-list">');
      var markerArray = [];
      
      
      $.each(data["time_markers"], function(k, value) {
       markerArray.push(value['marker']);
      });
      
      for (var i = 16; i <= 39; i++){
        dateList.append("<li><label>");
        if(jQuery.inArray(i, markerArray) === -1){
          dateList.append('<input type="checkbox" id="time_' + i + '" name="time_marker_ids[]" value="' + i + '">');
        }
        dateList.append("<span>" + Math.floor(i/2) + ':' + (i % 2 ? '00' : 30) +"</span></label></li>");
      }
      el.html(dateList);

    });
  });
  
  //$(".roomSelector").change
  
  $( "#calendar-selector" ).datepicker({
    dateFormat: 'yy-mm-dd',
    onSelect:  function(dateText, inst) { 
      $.getJSON("/rooms/?date=" + dateText, function(data) {
        var timeTable = $("#time-table");
        var table = '<table class="time"><thead><tr><th></th>';
        
        timesTaken = [];
        
        for(var i = 0; i < data.length; i++){
          var timesArray = [];
          $.each(data[i]["time_markers"], function(k, value) {
           timesArray.push(value['marker']);
          });
          timesTaken.push(timesArray);
          
          table += "<th>" + data[i]["name"] + "</th>";
        }
        table += "</tr></thead>";
        
        for (var times = 16; times <= 39; times++){
          table += '<tr>';
          table += "<td><span>" + Math.floor(times/2) + ':' + (times % 2 ? '00' : 30) +"</span></td>";
          for (var columns = 0; columns < data.length; columns++){
            var arrayPosition = jQuery.inArray(times, timesTaken[columns])
            
            var rowClass = (arrayPosition === -1) ? '' : 'reserved';
            var cell = (arrayPosition > -1) ?  data[columns]["time_markers"][arrayPosition]["event_name"] : ''
            
            table += '<td style="color: #000;" class="' + rowClass +'">' + cell + '</td>';
              
          }
          table += '</tr>';
        }
        
        table += "</tr></table>";
        
        timeTable.html(table);
      })
    }
  });
  
  var eventModal = $('#modal-from-dom');
  
  eventModal.bind('hidden', function () {
    //alert('The modal was hidden');
  });
  
  eventModal.bind('show', function () {
    //alert('The show event was fired.');
  });
  
  
  $('#new_event')
    .bind("ajax:beforeSend", function(evt, xhr, settings){
      var $submitButton = $(this).find('input[name="commit"]');
      
      
      // Update the text of the submit button to let the user know stuff is happening.
      // But first, store the original text of the submit button, so it can be restored when the request is finished.
      $submitButton.data( 'origText', $(this).text() );
      $submitButton.text( "Submitting..." );

    })
   .bind("ajax:success", function(evt, data, status, xhr){
     var $form = $(this);

     // Reset fields and any validation errors, so form can be used again, but leave hidden_field values intact.
     $form.find('textarea,input[type="text"],input[type="file"]').val("");
     $form.find('div.validation-error').empty();

     // Insert response partial into page below the form.
     $('#modal-from-dom').modal('hide');

   })
   .bind('ajax:complete', function(evt, xhr, status){
     var $submitButton = $(this).find('input[name="commit"]');

     // Restore the original submit button text
     $submitButton.text( $(this).data('origText') );
   })
   .bind("ajax:error", function(evt, xhr, status, error){
     var $form = $(this),
         errors,
         errorText;

     try {
       // Populate errorText with the comment errors
       errors = $.parseJSON(xhr.responseText);
     } catch(err) {
       // If the responseText is not valid JSON (like if a 500 exception was thrown), populate errors with a generic error message.
       errors = {message: "Please reload the page and try again"};
     }

     // Build an unordered list from the list of errors
     errorText = "There were errors with the submission: \n<ul>";

     for ( error in errors ) {
       errorText += "<li>" + error + ': ' + errors[error] + "</li> ";
     }

     errorText += "</ul>";

     // Insert error list into form
     $form.find('div.validation-error').html(errorText);
   });
     
});
$(function(){
  
  var displayEventSelection = function(dateText){
    $.getJSON("/rooms/?date=" + dateText, function(data) {
      var el = $("#open-date-selector");
      var current_event = $("#current_event_id").val();
      var dataSelections = '<div class="row">';
      
      var clockTimes = [ "11:00 am - 12:30 pm", "1:00 pm - 2:30 pm", "3:00 pm - 4:30 pm", "5:00 pm - 6:30 pm"];
      
      for(var i = 0; i < data.length; i++){
        dataSelections += '<div class="span3-5"><h6>' + data[i]["name"] + '</h6>';
        
        var timesArray = [];
        
        $.each(data[i]["time_markers"], function(k, value) {
         timesArray.push(value['marker']);
        });
        
        for (var v = 0; v < clockTimes.length; v++){
          dataSelections += '<div class="clearfix"><div class="input-prepend">';

          var _id = v+1
          var _did = i+1
          var currentTimePosition = jQuery.inArray(v+1, timesArray);
          
          
          if ( currentTimePosition === -1){
            checkbox = '<input class="add-on" type="checkbox" id="time_' + _id + '" name="time_marker_ids[]" value="' + _did + ',' + _id + '">';
          } else {
            if (data[i]["time_markers"][currentTimePosition]["event_id"] == current_event){
              checkbox = '<input class="add-on" type="checkbox" id="time_' + _id + '" name="time_marker_ids[]" value="' + _did + ',' + _id + '" checked="checked">';;
            } else {
              checkbox = '';
            }
          }

          dataSelections += '<label class="add-on">' + checkbox + '</label>';

          dataSelections += '<input readonly="readonly" id="prependedInput2" name="prependedInput2" value="' + clockTimes[v]  + '" class="span2-5" type="text"></div></div>';
        }
        dataSelections += '</div>';
      }
      
      dataSelections += '</div>';
      el.html(dataSelections);
    });
  }
  
  $( "#event_event_date" ).datepicker({
    dateFormat: 'yy-mm-dd',
    onSelect:  function(dateText, inst) { 
      displayEventSelection(dateText);
    }
  });
  
  
  var displayEventCalendar = function(dateText){
    $.getJSON("/rooms/?date=" + dateText, function(data) {
      var timeTable = $("#time-table");
      var table = '<table class="time"><thead><tr><th></th>';
      var clockTimes = [ "11:00 am - 12:30 pm", "1:00 pm - 2:30 pm", "3:00 pm - 4:30 pm", "5:00 pm - 6:30 pm"];
        
      timesTaken = [];
      
      for(var i = 0; i < data.length; i++){
        var timesArray = [];
        $.each(data[i]["time_markers"], function(k, value) {
         timesArray.push(value['marker']);
        });
        timesTaken.push(timesArray);
        
        table += "<th width='14%'>" + data[i]["name"] + "</th>";
      }
      table += "</tr></thead>";
      
      for (var times = 0; times < clockTimes.length; times++){
        table += '<tr>';
        table += "<td><span>" + clockTimes[times] +"</span></td>";
        for (var columns = 0; columns < data.length; columns++){
          var arrayPosition = jQuery.inArray(times+1, timesTaken[columns])
          
          var rowClass = (arrayPosition === -1) ? '' : 'reserved';
          var cell = (arrayPosition > -1) ? '<a href="/events/' + data[columns]["time_markers"][arrayPosition]["event_id"] + '">' + data[columns]["time_markers"][arrayPosition]["event_name"] + '</a>' : ''
          
          table += '<td style="color: #000;" class="' + rowClass +'">' + cell + '</td>';
            
        }
        table += '</tr>';
      }
      
      table += "</tr></table>";
      
      timeTable.html(table);
    });
  }
  
  $( "#calendar-selector" ).datepicker({
    dateFormat: 'yy-mm-dd',
    onSelect:  function(dateText, inst) { 
      displayEventCalendar(dateText);
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
   
   
   if($( "#calendar-selector" ).length != 0){
     var currentTime = new Date();
     var year = currentTime.getFullYear();
     var month = currentTime.getMonth()+1;
     var day = currentTime.getDate();
     displayEventCalendar(year + '-' + month + '-' + day);
   }   
   
   if($("#event_event_date").length != 0){
     displayEventSelection($("#event_event_date").val());
   }
    
});
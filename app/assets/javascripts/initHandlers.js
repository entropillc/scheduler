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
  
  var displayNotesForDay = function (dateText) {
    $.getJSON("/notes/find?date=" + dateText, function(data) {
      var notesView = $("#notes-view");
      var innerHtml = '<a href="notes/' + data["id"] + '/edit" class="btn primary">Edit Notes</a>';
      
      if (data["body"] != null){
        innerHtml += '<pre>' + data["body"] + '</pre>'
      }
      
      notesView.html(innerHtml);
    });
  }

	var displayEventsList = function(date){
		$.getJSON("/events/date=" + dateText, function(data) {
			var eventsList = $("#events-list");
			var innerHtml = "<h6>Today's " + data.length + " Events</h6>";
			
			/*for (e in data){
				
			}*/
			
			eventsList.html(innerHtml);
		});
	}
  
  
  $( "#event_event_date" ).datepicker({
    dateFormat: 'yy-mm-dd',
    onSelect:  function(dateText, inst) { 
      displayEventSelection(dateText);
    }
  });
  
  $( "#calendar-selector" ).datepicker({
    dateFormat: 'yy-mm-dd',
    onSelect:  function(dateText, inst) { 
      displayEventCalendar(dateText);
      displayNotesForDay(dateText);
    }
  });
  
  

   
   
   if($( "#calendar-selector" ).length != 0){
     var currentTime = new Date();
     var year = currentTime.getFullYear();
     var month = currentTime.getMonth()+1;
     var day = currentTime.getDate();
     currentDate = year + '-' + month + '-' + day
     displayEventCalendar(currentDate);
     displayNotesForDay(currentDate);
		 displayEventsList(currentDate);
   } 
   
   var eventEventDate = $("#event_event_date");
   
   if(eventEventDate.length != 0){
     if (eventEventDate.val().length > 0){
       displayEventSelection($("#event_event_date").val());
     }
   }
    
});
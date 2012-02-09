$(function(){
  
	var allClockTimes = [
			{
				value: 1,
				daysAvailable: [1,2,3,4,5,6],
				text: "11:00 am - 12:30 pm"
			},
			{
				value: 2,
				daysAvailable: [0],
				text: "12:30 am - 2:00 pm"
			},
			{
				value: 3,
				daysAvailable: [1,2,3,4,5,6],
				text: "1:00 pm - 2:30 pm"
			},
			{
				value: 4,
				daysAvailable: [0],
				text: "2:30 am - 4:00 pm"
			},
			{
				value: 5,
				daysAvailable: [1,2,3,4,5,6],
				text: "3:00 pm - 4:30 pm"
			},
			{
				value: 6,
				daysAvailable: [0],
				text: "4:30 am - 6:00 pm"
			},
			{
				value: 7,
				daysAvailable: [1,2,3,4,5,6],
				text: "5:00 pm - 6:30 pm"
			},
			{
				value: 8,
				daysAvailable: [0],
				text: "6:30 am - 8:00 pm"
			},
			{
				value: 9,
				daysAvailable: [1,2,3,4,5,6],
				text: "7:00 pm - 8:30 pm"
			},
		];
	
	var availableClockTimes = function(dateString) {
		var dateArray = dateString.split("-")
		var currentDay = new Date(dateArray[0], dateArray[1]-1, dateArray[2]).getDay();
		var clockTimes = [];
		
		for (timePosition in allClockTimes) {
			if (jQuery.inArray(currentDay, allClockTimes[timePosition]["daysAvailable"]) != -1){
				clockTimes.push(allClockTimes[timePosition])
			}
		}
		
		return clockTimes;
	}
	

  var displayEventSelection = function(dateText){
    $.getJSON("/rooms/?date=" + dateText, function(data) {
      var el = $("#open-date-selector");
      var current_event = $("#current_event_id").val();
      var dataSelections = '<div class="row">';

      var clockTimes = availableClockTimes(dateText);
			
      for(var i = 0; i < data.length; i++){
        dataSelections += '<div class="span3-5"><h6>' + data[i]["name"] + '</h6>';
        
        var timesArray = [];
        
        $.each(data[i]["time_markers"], function(k, value) {
         timesArray.push(value['marker']);
        });
        
        console.log(timesArray);
        
        for (var v = 0; v < clockTimes.length; v++){
          dataSelections += '<div class="clearfix"><div class="input-prepend">';

          var _id = clockTimes[v]["value"]
          var _did = i+1
          
          console.log(clockTimes);
          
          var currentTimePosition = jQuery.inArray(clockTimes[v]["value"], timesArray);
          
          
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

          dataSelections += '<input readonly="readonly" id="prependedInput2" name="prependedInput2" value="' + clockTimes[v]["text"]  + '" class="span2-5" type="text"></div></div>';
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
      var clockTimes = availableClockTimes(dateText);
        
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
        table += "<td><span>" + clockTimes[times]["text"] +"</span></td>";
        for (var columns = 0; columns < data.length; columns++){
          var arrayPosition = jQuery.inArray(clockTimes[times]["value"], timesTaken[columns])
          
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

	var displayEventsList = function(dateText){
		$.getJSON("/events/?date=" + dateText, function(data) {
			var eventsList = $("#events-list");
			var innerHtml = "<h6>Today's " + data.length + " Event(s)</h6><dl>";
			
			for (e in data){
				innerHtml += '<dt>' + data[e]["customer_name"] + '</dt><dd>';
				if (data[e]["event_type"] === 1) {
				  innertHtml += 'Basic';
				} else {
				  innerHtml += 'Deluxe';
				}
				innerHtml += ' Party</dd>';
				
			}
			innerHtml += '</dl>';
			
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
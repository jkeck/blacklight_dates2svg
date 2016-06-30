/*
 * jQuery SVG Month Grid Selector Plugin
 *
 * https://github.com/jkeck/svgMonthGridSelector
 *
 * This plugin is explicitly designed for use with the SVG ouput by the dates2svg RubyGem ( https://github.com/jkeck/dates2svg )
 *
 * VERSION 0.0.1.beta1
 *
**/
(function( $ ){
	$.fn.svgMonthGridSelector = function(options){
		var settings = $.extend({
			'begin_input' : '.begin-date',
			'end_input'   : '.end-date',
			'hits'				: '.hits'
		}, options);

		var selector = this;
		var svg = $("svg", selector);
    var begin_input = $("form input" + settings.begin_input, selector);
		var end_input = $("form input" + settings.end_input, selector);
		var hits_element = $(settings.hits, selector);

		updateRangesFromInputs();
		updateRangeOnFormChange();

		$("rect", svg).each(function(){
			$(this).click(function(){
				// clear selected months
				clearSelections();

				// change data-selected attribute on click
	      var selected = $(this).attr("data-selected") == "true" ? "false" : "true";
	      $(this).attr("data-selected", selected);

				// fill in range of selections
				selectRange();

				// update form controls with selections.
				updateDateSelectorFormControls();
			});
		});

		function inputHasValue(input) {
			return (input != "" && input !== undefined);
		}

		function selectRange(){
		  if($("rect[data-selected='true']", svg).length > 1){
	      var in_range = false;
	      $("rect", svg).each(function(){
	        // if we're already in_range, but we get to an item w/
	        // data-selected=true, then we're at the end of the range
	        if(in_range && $(this).attr("data-selected") == "true"){
	          return false;
	        }
	        // set in_range to true now that we're come across a selected item
	        if($(this).attr("data-selected") == "true"){
	          in_range = true;
	        }
	        // set data-selected to true for all the boxes in_range
	        if(in_range && $(this).attr("data-selected") != "true"){
	          $(this).attr("data-selected", "true");
	        }
	      });
	    }
	  }

	  function clearSelections(){
			// If a range has already been selected
		  if($("rect[data-selected='true']", svg).length >= 2){
	      $("rect", svg).each(function(){
	        $(this).attr("data-selected", "false");
	      });
				begin_input.attr("value", "");
				$(".date-range-selector form input" + settings.end_input, selector).attr("value", "");
				$(settings.hits, selector).text("");
	    }
	  }

	  function updateDateSelectorFormControls(){
		  var begin_element = $("rect[data-selected='true']", svg).first();
		  var end_element = $("rect[data-selected='true']", svg).last();
		  if(begin_element.length > 0){
	      begin_input.attr("value", begin_element.attr("data-year") + "-" + begin_element.attr("data-month"));
		  }
		  if($("rect[data-selected='true']", svg).length == 1){
			  end_input.attr("value", begin_element.attr("data-year") + "-" + begin_element.attr("data-month"));
			}else if($("rect[data-selected='true']", svg).length > 1){
			  end_input.attr("value", end_element.attr("data-year") + "-" + end_element.attr("data-month"));
		  }else if($("rect[data-selected='true']", svg).length == 0){
			  begin_input.attr("value", "");
			  end_input.attr("value", "")
		  }
			var hits = 0;
			$("rect[data-selected='true']", svg).each(function(){
				hits += parseInt($(this).attr("data-hits"));
			});
			$(settings.hits, selector).text(hits > 0 ? hits : "");
	  }

	  function updateRangeOnFormChange(){
		  $.each([begin_input, end_input], function(){
			  $(this).change(function(){
				  if(inputHasValue($(this).attr("value")) &&
				       begin_input.attr("value").match(/^\d{4}-\d{2}/) &&
							 end_input.attr("value").match(/^\d{4}-\d{2}/)){
				    $("rect", svg).each(function(){
			        $(this).attr("data-selected", "false");
			      });
					  updateRangesFromInputs();
				  }
			  });
		  });
	  }

	  function updateRangesFromInputs(){
		  var begin_grid_element, end_grid_element;
			if(begin_input.length > 0 && inputHasValue(begin_input.attr("value"))) {
				var match = begin_input.attr("value").match(/^(\d{4})-(\d{2})/)
				var year = match[1]
				var month = match[2]
				begin_grid_element = $("rect[data-year='" + year + "'][data-month='" + month +"']", svg);
				begin_grid_element.attr("data-selected", "true");
			}
			if(end_input.length > 0 && inputHasValue(end_input.attr("value"))) {
				var match = end_input.attr("value").match(/^(\d{4})-(\d{2})/)
				var year = match[1]
				var month = match[2]
				end_grid_element = $("rect[data-year='" + year + "'][data-month='" + month +"']", svg);
				end_grid_element.attr("data-selected", "true");
			}
			selectRange();
			updateDateSelectorFormControls();
	  }

	}
})( jQuery );

# BlacklightDates2SVG

This gem is intended to be installed into Blacklight applications ( https://github.com/projectblacklight/blacklight ) to generate an SVG of date data into a heat-map style grid from date facet data.

![date range heat map](http://i.imgur.com/6dcL09C.png)

## Installation

Add this line to your application's Gemfile:

    gem 'blacklight_dates2svg'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install blacklight_dates2svg
    
Add asset references to application.css and application.js.

    $ rails generate blacklight_dates2svg


## Components

This gem simply provides the form elements to interact with the SVG grid, the logic to inject the range query into Blacklight's Solr parameters, and brings in a few other gems/plugins to drive the interaction and process the data for Blacklight.

* Dates2SVG gem ( https://github.com/jkeck/dates2svg ) to generate the SVG grid.
* svgMonthGridSelector jQuery plugin ( https://github.com/jkeck/svgMonthGridSelector ) to drive the interaction with the form elements.
* date_range_solr_query gem ( https://github.com/jkeck/date_range_solr_query ) to turn the YYYY-MM dates into full date range queries for Solr.


## Solr Requirements

The data should be a facet that is a DateField ( http://lucene.apache.org/solr/api/org/apache/solr/schema/DateField.html ).  The facet limit should be set to return all values in the response to drive the SVG grid.  Alternatively you can pass an array of dates in as a :dates option (see Usage below).

## Usage

Once the gem is installed you will need to include the BlacklightDates2SVG module into you search controller (CatalogController by default in Blacklight).

    include BlacklightDates2SVG
    
You will need to add 2 lines in the contorller level Blacklight configuration ( configure_blacklight block ).  One to configure the facet (and most likely set :show to false) and another to let the gem know which field is the date field.

    config.add_facet_field 'date_facet', :label => "Date", :show => false
    config.search_date_field = 'date_facet'
    
Now in any helper or view rendered under that controller will have the render_date_range_selector_grid helper method available.

    <%= render_date_range_selector_grid %>
    
You can pass all the options described in the [README](https://github.com/jkeck/dates2svg) of the Dates2SVG gem to the render_date_range_selector_grid helper method.

This gem adds an additional :dates option that when passed will ignore the facets in the response and just use the array passed in that option.

    dates = [OpenStruct.new(:value => "2012-03-23", :hits => 836),
             OpenStruct.new(:value => "2012-02-21", :hits => 584)]
    
    svg = render_date_range_selector_grid(:dates => dates)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

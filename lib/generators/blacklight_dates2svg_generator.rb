# -*- encoding : utf-8 -*-
require 'rails/generators'
require 'rails/generators/migration'     
class BlacklightDates2svgGenerator < Rails::Generators::Base

    desc """
  This generator makes the following changes to your application:
   1. Requires javascript from the svgMonthGridSelector jQuery plugin
   2. Requires a css file to style the grid, form, and legend.
         """ 

    # insert require statements into application level CSS/JS manifestes.
    def inject_blacklight_dates2svg_assets
      css = "app/assets/stylesheets/application.css"
      if File.exists?("app/assets/stylesheets/application.css.scss")
        css = "app/assets/stylesheets/application.css.scss"
      end
      unless IO.read(css).include?("Required by BlacklightDates2SVG")
        insert_into_file css, :after => "/*" do
  %q{
 * Required by BlacklightDates2SVG:
 *= require blacklight_dates2svg/date_range_selector
 *}
        end
      end
      unless IO.read("app/assets/javascripts/application.js").include?("Required by BlacklightDates2SVG")
        insert_into_file "app/assets/javascripts/application.js", :before => "//= require_tree ." do
%q{// Required by BlacklightDates2SVG:
//= require blacklight_dates2svg/svgMonthGridSelector
//= require blacklight_dates2svg/blacklight_dates2svg
}
        end
      end
    end
    
    
end

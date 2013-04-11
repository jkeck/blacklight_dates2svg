require "blacklight_dates2svg/engine"
require 'dates2svg'

module BlacklightDates2SVG
  extend ActiveSupport::Concern
  included do
    helper_method :render_date_range_selector_grid, :render_date_range_value, :date_range_form_omit_keys
  end
  
  def render_date_range_selector_grid(options)
    response ||= (options[:response] || @response)
    if @response
      fs = @response.facets.select do |f|
        f.name == blacklight_config.search_date_field
      end.first
      unless fs.blank?
        @date_selector = Dates2SVG.new(fs.items, options)
        render(:partial => "blacklight_dates2svg/date_range_selector").join(" ").html_safe
      end
    end
  end
  
  def render_date_range_value(range)
    if range.is_a? Array
      return range.first
    else range.is_a? Range
      return "#{range.first} - #{range.last}"
    end
  end
  
  def date_range_form_omit_keys
    [:q, :search_field, :qt, :page]
  end
  
end


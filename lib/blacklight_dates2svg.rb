require "blacklight_dates2svg/engine"
require 'dates2svg'
require 'date_range_solr_query'

module BlacklightDates2SVG
  extend ActiveSupport::Concern
  included do
    self.solr_search_params_logic += [:add_dates2svg_range_query]
    helper_method :render_date_range_selector_grid, :render_date_range_value, :date_range_form_omit_keys
  end
  
  def add_dates2svg_range_query(solr_params, user_params)
    if user_params["dates"] and !user_params["date-start"].blank?
      range_query = DateRangeSolrQuery.new(:start_date => user_params['date-start'],
                                           :end_date => user_params['date-end'],
                                           :field => blacklight_config.search_date_field).range_query
      if solr_params[:fq]
        solr_params[:fq] << range_query
      else
        solr_params[:fq] = [range_query]
      end
    end
  end

  def render_date_range_selector_grid(options={})
    items = (options[:dates] || @response.facets.select do |facet|
                                  facet.name == blacklight_config.search_date_field
                                end.first.items)
    options.delete(:dates)
    unless items.blank?
      @date_selector = Dates2SVG.new(items, options)
      render(:partial => "blacklight_dates2svg/date_range_selector").join(" ").html_safe
    end
  end
  
  def render_date_range_value(range)
    [range.first, range.last].uniq.join(" - ")
  end
  
  def date_range_form_omit_keys
    [:q, :search_field, :qt, :page]
  end
  
end


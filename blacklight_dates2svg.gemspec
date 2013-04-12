$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "blacklight_dates2svg/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "blacklight_dates2svg"
  s.version     = BlacklightDates2SVG::VERSION
  s.authors     = ["Jessie Keck"]
  s.email       = ["jessie.keck@gmail.com"]
  s.homepage    = "https://github.com/jkeck/blacklight_dates2svg"
  s.summary     = "BlacklightDates2svg generates a month SVG grid for date facet data"
  s.description = "Uses https://github.com/jkeck/dates2svg gem to generate an SVG of date data into a heat-map style grid.  Also uses the https://github.com/jkeck/svgMonthGridSelector jQuery plugin to interact with the grid and udpate necessary form elements."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1"
  s.add_dependency "blacklight", "~> 4.0"
  s.add_dependency "dates2svg"
  s.add_dependency "date_range_solr_query"

  s.add_development_dependency "sqlite3"
end

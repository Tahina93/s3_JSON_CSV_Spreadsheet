require 'open-uri'
require 'nokogiri'
require 'bundler'

Bundler.require

$:.unshift File.expand_path("./../lib", __FILE__)
require 'app/scrapper'

new_scrapper = Scrapper.new("http://annuaire-des-mairies.com/val-d-oise.html")
new_scrapper.perform
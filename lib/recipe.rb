# wrapper class to make instances of Recipe fromm the data in the API response
require "httparty"
require 'pry'

class Recipe
  attr_reader :name, :id, :photo, :ingredients, :diet_labels, :uri, :company
 def initialize(name, id, options = {})
   raise ArgumentError if name == nil || name == "" || id == nil || id == ""
   @name = name
   @id = id
   @photo = options[:photo]
   @url = options[:url]
   # TODO: format ingredients into a more readable format in the initialize
   @ingredients = []
   options[:ingredients].each do |ing|
     @ingredients << ing["text"]
   end
   @diet_labels = options[:diet_labels]
   @uri = options[:uri]
   @company = options[:company]
 end # initialize
end

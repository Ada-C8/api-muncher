# wrapper class to make instances of Recipe fromm the data in the API response
require "httparty"
require 'pry'

class Recipe
  attr_reader :name, :id, :photo, :ingredients, :diet_labels
 def initialize(name, id, options = {})
   raise ArgumentError if name == nil || name == "" || id == nil || id == ""

   @name = name
   @id = id
   @photo = options[:image]
   @url = options[:url]
   # TODO: format ingredients into a more readable format in the initialize
   @ingredients = options[:ingredients]
   @diet_labels = options[:diet_labels]
 end # initialize
end

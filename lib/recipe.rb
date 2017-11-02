require 'httparty'
require 'awesome_print'

class Recipe

  attr_reader :label, :uri, :image, :source, :url, :dietLabels, :healthLabels, :ingredientLines, :find_recipe_id

  def initialize(recipes_list)
    raise ArgumentError if recipes_list["label"] == nil || recipes_list["label"] == "" || recipes_list["uri"] == nil || recipes_list["uri"] == ""

    @uri = URI.escape(recipes_list['uri'])
    # puts "URI: #{@uri}"
    @label = recipes_list['label']
    @image = recipes_list['image']
    @source = recipes_list['source']
    @url = recipes_list['url']
    @dietLabels = recipes_list['dietLabels']
    @healthLabels = recipes_list['healthLabels']
    @ingredientLines = recipes_list['ingredientLines']
  end

  def find_recipe_id
    a = @uri.split('owl')
    uri_id = a[1]
    # puts "URI_ID: #{uri_id}"
    return uri_id
  end



end

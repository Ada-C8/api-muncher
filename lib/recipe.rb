require 'httparty'
require 'awesome_print'

class Recipe

  attr_reader :label, :uri, :image, :source, :url, :dietLabels, :healthLabels, :ingredientLines, :find_recipe_id

  def initialize(api_params)
    raise ArgumentError if api_params["label"] == nil || api_params["label"] == "" || api_params["uri"] == nil || api_params["uri"] == ""

    @uri = URI.escape(api_params['uri'])
    @label = api_params['label']
    @image = api_params['image']
    @source = api_params['source']
    @url = api_params['url']
    @dietLabels = api_params['dietLabels']
    @healthLabels = api_params['healthLabels']
    @ingredientLines = api_params['ingredientLines']
  end

  def find_recipe_id
    a = @uri.split('edamam.ow')
    uri_id = a[1]
    return uri_id
  end



end

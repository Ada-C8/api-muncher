class Recipe

  attr_reader :name, :image_url, :url, :uri, :ingredients, :diet_labels, :health_labels, :cautions, :calories, :total_nutrients, :total_daily, :diet_label

  def initialize(name, url, uri, image, yield_num, ingredients, diet_labels, options= {})
    @name= name
    @url = url
    @uri = uri
    @image_url = image
    @yield = yield_num
    @ingredients = ingredients
    @diet_labels = diet_labels

    @health_labels = options[:health_labels]
    @cautions = options[:cautions]
    @calories = options[:calories]
    @total_nutrients = options[:total_nutrients]
    @total_daily = options[:total_daily]
    @diet_label = options[:digest]

  end


end

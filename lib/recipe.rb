require 'json/ext'

class Recipe
  attr_reader :uri, :label, :url, :ingredientLines, :dietLabels, :image, :source

  def initialize(uri, label, url, options = {})
    raise ArgumentError if uri.blank? || label.blank? || url.blank?

    @uri = uri
    @label = label
    @url = url

    #Optional Variables
    @dietLabels = options[:dietLabels]
    @ingredientLines = options[:ingredientLines]
    @image = options[:image]
    @source = options[:source]

  end

  def stringify()
    self.to_json
  end

end

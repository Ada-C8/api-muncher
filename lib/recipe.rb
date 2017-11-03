class Recipe

  attr_reader :uri, :label, :source, :image_url, :source_url, :ingredient_lines, :total_nutrients

  def initialize(uri, label, source, options = {})
    if uri == "" || uri == nil || label == "" || label == nil || source == nil || source == ""
      raise ArgumentError.new("Recipe was not created")
    end

    @uri = uri
    @label = label
    @source = source

    @image_url = options[:image_url]
    @source_url = options[:source_url]
    @ingredient_lines = options[:ingredient_lines]
    @total_nutrients = options[:total_nutrients]
  end

  def uri_id # This is called in the view
    return self.uri[/(?<=_)[a-zA-Z0-9]+/]
  end
  
end

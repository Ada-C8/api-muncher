class Recipe
  attr_reader :uri, :title, :image, :diet_label, :url, :ingredient_lines

  def initialize(uri, title, image, options = {} )
    raise ArgumentError if title == nil || title == "" || uri == nil || uri == ""


    @title = title
    @uri = uri
    @image = image

    @diet_label = options[:dietLabels]
    @url = options[:url]
    @ingredient_lines = options[:ingredientLines]
  end

   def id
     return self.uri[/(?<=_)[a-zA-Z0-9]+/]
   end

end

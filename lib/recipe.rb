class Recipe
  attr_reader :uri, :title, :image, :diet_labels, :url, :ingredient_lines, :source

  def initialize(uri, title, image, options = {} )
    raise ArgumentError if title == nil || title == "" || uri == nil || uri == ""


    @title = title
    @uri = uri
    @image = image

    @diet_labels = options[:diet_labels]
    @source = options[:source]
    @url = options[:url]
    @ingredient_lines = options[:ingredient_lines]
  end

   def id
     return self.uri[/(?<=_)[a-zA-Z0-9]+/]
   end

end

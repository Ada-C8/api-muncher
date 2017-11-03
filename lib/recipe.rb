class Recipe
  attr_reader :label, :uri

  def initialize(label, uri)
    @label = label
    @uri = uri
  end

end 

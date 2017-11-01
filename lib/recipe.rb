class Recipe
  attr_reader :label, :url

  def initialize(label, url)
    @label = label
    @url = url
  end
  
end

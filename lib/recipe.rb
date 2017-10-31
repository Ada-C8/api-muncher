class Recipe
  attr_reader :title, :id


  def initialize(title, id)
    raise ArgumentError if title == nil || title == ""

    @title = title
    @id = id
  end
end

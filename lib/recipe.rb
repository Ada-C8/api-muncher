class Recipe
  attr_reader :title


  def initialize(title)
    raise ArgumentError if title == nil || title == ""

    @title = title

  end
end

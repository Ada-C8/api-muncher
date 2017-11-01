class Recipe
  attr_reader :label

  def initialize(label)
    raise ArgumentError if label == nil
    @label = label

  end
end

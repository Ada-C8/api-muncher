class Recipe
  attr_reader :name, :image_url, :recipe_url, :source, :ingredients, :dietary_info, :diet_labels

  def initialize(args)
    unless args.keys.include?(:name && :image_url && :source && :recipe_url && :source && :ingredients)
      raise ArgumentError
    end

    @name = args[:name]
    @image_url = args[:image_url]
    @recipe_url = args[:recipe_url]
    @source = args[:source]
    @ingredients = args[:ingredients]

    @dietary_info = args[:dietary_info] if args[:dietary_info]
    @diet_labels = args[:diet_labels] if args[:diet_labels]

  end
end

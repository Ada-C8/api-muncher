# :nodoc:
class Recipe
  attr_reader :name, :image_url, :recipe_url, :source, :ingredients, :id,
              :dietary_info, :diet_labels

  def initialize(args)
    check_for_args(args)

    @name = args[:name]
    @image_url = args[:image_url]
    @recipe_url = args[:recipe_url]
    @source = args[:source]
    @ingredients = args[:ingredients]
    @id = args[:recipe_uri]
    # @id = URI.encode(args[:recipe_uri])

    @dietary_info = args[:dietary_info] if args[:dietary_info]
    @diet_labels = args[:diet_labels] if args[:diet_labels]
  end

  def check_for_args(args)
    missing = %i[name image_url recipe_url source ingredients recipe_uri].find_all { |n| !args.keys.include? n }
    raise ArgumentError, "Missing parameters: #{missing.join(', ')}" unless missing.empty?
  end
end

# :nodoc:
class Recipe
  attr_reader :name, :image_url, :recipe_url, :source, :ingredients,
              :dietary_info, :diet_labels

  def initialize(args)
    check_for_args(args)

    @name = args[:name]
    @image_url = args[:image_url]
    @recipe_url = args[:recipe_url]
    @source = args[:source]
    @ingredients = args[:ingredients]
    @id = @name.gsub(/\W/){} + ("%010i" % rand(10 ** 10))

    @dietary_info = args[:dietary_info] if args[:dietary_info]
    @diet_labels = args[:diet_labels] if args[:diet_labels]
  end

  def check_for_args(args)
    missing = %i[name image_url recipe_url source ingredients].find_all do |n|
      !args.keys.include? n
    end
    raise ArgumentError, "Missing parameters: #{missing.join(', ')}" unless missing.empty?
  end
end

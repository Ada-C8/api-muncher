# :nodoc:
class Recipe
  attr_reader :name, :image_url, :recipe_url, :source, :ingredients, :id,
              :servings, :nutrition, :diet_labels

  def initialize(args)
    check_for_args(args)

    @name = args[:name]
    @image_url = args[:image_url]
    @recipe_url = args[:recipe_url]
    @source = args[:source]
    @ingredients = args[:ingredients]
    @id = args[:recipe_uri]
    @servings = args[:servings]
    @nutrition = args[:nutrition]

    @diet_labels = args[:diet_labels] if args[:diet_labels]
  end

  def check_for_args(args)
    missing = %i[name image_url recipe_url source ingredients recipe_uri servings nutrition].find_all { |n| !args.keys.include? n }
    raise ArgumentError, "Missing parameters: #{missing.join(', ')}" unless missing.empty?
  end

  def basic_nutrition(serving = true)
    nutrition = []
    ["ENERC_KCAL", "FAT", "FASAT", "FATRN", "CHOCDF", "FIBTG", "SUGAR", "PROCNT"].each do |nutrient|
      nutrition << print_nutrient(nutrient) if @nutrition[nutrient]
    end
    nutrition
  end

  private

  def print_nutrient(nutrient)
    [
      @nutrition[nutrient]['label'],
      "#{((@nutrition[nutrient]['quantity']) / @servings).round(2)} #{@nutrition[nutrient]['unit']}"
    ]
  end
end

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
      nutrition << print_nutrient(nutrient)
    end
    nutrition
  end

  private

  def print_nutrient(nutrient)
    [
      @nutrition['nutrient']['label'],
      "#{(@nutrition['nutrient']['quantity']) / @servings} #{(@nutrition['nutrient']['unit'}"
    ]
  end
end

@nutrition=
   {"ENERC_KCAL"=>{"label"=>"Energy", "quantity"=>3967.414659171387, "unit"=>"kcal"},
    "FAT"=>{"label"=>"Fat", "quantity"=>273.8429084838867, "unit"=>"g"},
    "FASAT"=>{"label"=>"Saturated", "quantity"=>72.0597932203098, "unit"=>"g"},
    "FATRN"=>{"label"=>"Trans", "quantity"=>0.8941317656940918, "unit"=>"g"},
    "FAMS"=>{"label"=>"Monounsaturated", "quantity"=>105.2130467024314, "unit"=>"g"},
    "FAPU"=>{"label"=>"Polyunsaturated", "quantity"=>52.52342901845752, "unit"=>"g"},
    "CHOCDF"=>{"label"=>"Carbs", "quantity"=>150.129525, "unit"=>"g"},
    "FIBTG"=>{"label"=>"Fiber", "quantity"=>10.7455, "unit"=>"g"},
    "SUGAR"=>{"label"=>"Sugars", "quantity"=>17.887050000000002, "unit"=>"g"},
    "PROCNT"=>{"label"=>"Protein", "quantity"=>210.6513572753906, "unit"=>"g"},
    "CHOLE"=>{"label"=>"Cholesterol", "quantity"=>793.7866592407227, "unit"=>"mg"},
    "NA"=>{"label"=>"Sodium", "quantity"=>13128.735488891602, "unit"=>"mg"},
    "CA"=>{"label"=>"Calcium", "quantity"=>441.0476614379882, "unit"=>"mg"},
    "MG"=>{"label"=>"Magnesium", "quantity"=>330.23478027343754, "unit"=>"mg"},
    "K"=>{"label"=>"Potassium", "quantity"=>2019.7677444458009, "unit"=>"mg"},
    "FE"=>{"label"=>"Iron", "quantity"=>27.09347672729492, "unit"=>"mg"},
    "ZN"=>{"label"=>"Zinc", "quantity"=>8.533867758178712, "unit"=>"mg"},
    "P"=>{"label"=>"Phosphorus", "quantity"=>1014.6511233520508, "unit"=>"mg"},
    "VITA_RAE"=>{"label"=>"Vitamin A", "quantity"=>124.04581390380858, "unit"=>"µg"},
    "VITC"=>{"label"=>"Vitamin C", "quantity"=>26.526000000000003, "unit"=>"mg"},
    "THIA"=>{"label"=>"Thiamin (B1)", "quantity"=>1.3088798834228517, "unit"=>"mg"},
    "RIBF"=>{"label"=>"Riboflavin (B2)", "quantity"=>1.2780951480102538, "unit"=>"mg"},
    "NIA"=>{"label"=>"Niacin (B3)", "quantity"=>37.87907770111084, "unit"=>"mg"},
    "VITB6A"=>{"label"=>"Vitamin B6", "quantity"=>3.1502952490234373, "unit"=>"mg"},
    "FOLDFE"=>{"label"=>"Folate equivalent (total)", "quantity"=>544.9514663696289, "unit"=>"µg"},
    "FOLFD"=>{"label"=>"Folate (food)", "quantity"=>338.5514663696289, "unit"=>"µg"},
    "FOLAC"=>{"label"=>"Folic acid", "quantity"=>120.39999999999999, "unit"=>"µg"},
    "VITB12"=>{"label"=>"Vitamin B12", "quantity"=>1.5639809417724608, "unit"=>"µg"},
    "VITD"=>{"label"=>"Vitamin D", "quantity"=>22.67961883544922, "unit"=>"IU"},
    "TOCPHA"=>{"label"=>"Vitamin E", "quantity"=>22.818920446337888, "unit"=>"mg"},
    "VITK1"=>{"label"=>"Vitamin K", "quantity"=>211.7390103149414, "unit"=>"µg"}}

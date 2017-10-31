class Recipe
# Recipe Name
# Recipe Image URL
# Company that wrote it
# All ingredients
# Nutrition Facts with quantities?

  def initialize(label, image_url, source, source_url, diet_labels, health_labels, ingredient_lines, ingredients, calories, total_weight, total_nutrients, total_daily, digest)
    @label = label
    @image_url = image_url
    @source = source
    @source_url = source_url
    @diet_labels = diet_labels # Array
    @health_labels = health_labels # Array
    @ingredient_lines = ingredient_lines # Array
    @ingredients = ingredients # Array with hashes inside
    @calories = calories
    @total_weight = total_weight
    @total_nutrients = total_nutrients # Hash key with hashes as the values --> Another method to parse out each label
    @total_daily = total_daily
    @digest = digest #Hash Key with an Array of hashes
  end
end
# response.parsed_response["hits"][0]["recipe"]["uri"]
# ["image"]
# ["url"]
# ["dietLabels"] => ["Low-Carb"]
# ["healthLabels"] => ["Sugar-Conscious",
 # "Peanut-Free",
 # "Tree-Nut-Free",
 # "Alcohol-Free"]
 #["ingredientLines"] =>
  # ["1/2 cup (125ml) mirin",
  #  "1/2 cup (125ml) soy sauce",
  #  "One 2-inch (5cm) piece of fresh ginger, peeled and grated",
  #  "2-pounds (900g) boneless chicken thighs (4-8 thighs, depending on size)"],
  #


# response["hits"].each do |recipe|

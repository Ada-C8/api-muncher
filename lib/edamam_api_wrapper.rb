class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search?q="
  EDAMAM_KEY = ENV["EDAMAM_KEY"]
  EDAMAM_ID = ENV["EDAMAM_ID"]

  class ApiError < StandardError
  end

  def self.list_recipes(search_term)
    url = BASE_URL + "#{search_term}" + "&app_id=" + EDAMAM_ID + "&app_key=" + EDAMAM_KEY

    data = HTTParty.get(url)
    recipe_list = []
    if data["hits"]
      data["hits"].each do |result|

        recipe_list << self.parse_recipe(result["recipe"])
      end
    end

    return recipe_list
  end

  private
  def self.parse_recipe(raw_recipe)
    return Recipe.new(
      name: raw_recipe["label"],
      id: raw_recipe["uri"],
      url: raw_recipe["url"],
      ingredients: raw_recipe["ingredients"],
      servings: raw_recipe["yield"],
      calories: raw_recipe["calories"],
      total_nutrients: raw_recipe["total_nutrients"],
      health_labels: raw_recipe["health_labels"],
      diet_labels: raw_recipe["diet_labels"]
    )
  end
end

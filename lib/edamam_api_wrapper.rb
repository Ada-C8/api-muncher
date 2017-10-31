class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search?q="
  ID_AND_KEY = "&app_id=#{ENV["EDAMAM_ID"]}&app_key=#{ENV["EDAMAM_KEY"]}"

  def self.search(query)
    url = BASE_URL + query + ID_AND_KEY
    data = HTTParty.get(url)
    recipes = []
    unless data["hits"].empty?
      data["hits"].each do |hit_data|
        recipes << self.create_recipe(hit_data)
      end
    end
    return recipes
  end


private
  def self.create_recipe(hit_data)
    api_data = hit_data["recipe"]
    recipe = Recipe.new(
      api_data["label"],
      api_data["image"],
      api_data["url"],
      api_data["ingredientLines"],
      {
        diet_labels: api_data["dietLabels"],
        health_labels: api_data["healthLabels"],
      }
    )
    return recipe
  end
end
